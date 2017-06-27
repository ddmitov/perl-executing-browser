/*
 Perl Executing Browser

 This program is free software;
 you can redistribute it and/or modify it under the terms of the
 GNU Lesser General Public License,
 as published by the Free Software Foundation;
 either version 3 of the License, or (at your option) any later version.
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY;
 without even the implied warranty of MERCHANTABILITY or
 FITNESS FOR A PARTICULAR PURPOSE.
 Dimitar D. Mitov, 2013 - 2017
 Valcho Nedelchev, 2014 - 2016
 https://github.com/ddmitov/perl-executing-browser
*/

#ifndef PAGE_H
#define PAGE_H

#include <QJsonDocument>
#include <QJsonObject>
#include <QMessageBox>
#include <QRegularExpression>
#include <QTimer>
#include <QUrl>
#include <QUrlQuery>
#include <QWebPage>
#include <QWebFrame>
#include <QWebSecurityOrigin>

#include <QInputDialog>

#include <QNetworkReply>

#include "file-reader.h"
#include "script-handler.h"

// ==============================
// WEB PAGE CLASS CONSTRUCTOR:
// ==============================
class QPage : public QWebPage
{
    Q_OBJECT

signals:
    void changeTitleSignal();
    void displayScriptErrorsSignal(QString errors);
    void printPreviewSignal();
    void printSignal();
    void closeAllScriptsSignal();
    void closeWindowSignal();

public slots:
    void qPageLoadedSlot(bool ok)
    {
        if (ok) {
            emit changeTitleSignal();

            // Inject all browser-specific Javascript:
            QFileReader *resourceReader =
                    new QFileReader(QString(":/peb.js"));
            QString pebJavaScript = resourceReader->fileContents;

            QPage::mainFrame()->evaluateJavaScript(pebJavaScript);
        }
    }

    // ==============================
    // Script handling:
    // ==============================
    void qHandleScriptSlot(QUrl url, QByteArray postDataArray)
    {
        QString scriptId = url.password() + "@" + url.path();

        if ((url.userName() == "interactive" and
             (!runningScripts.contains(scriptId))) or
                (url.userName() != "interactive")) {
            QScriptHandler *scriptHandler =
                    new QScriptHandler(url, postDataArray);

            QObject::connect(scriptHandler,
                             SIGNAL(displayScriptOutputSignal(QString,
                                                              QString)),
                             this,
                             SLOT(qDisplayScriptOutputSlot(QString,
                                                           QString)));
            QObject::connect(scriptHandler,
                             SIGNAL(scriptFinishedSignal(QString,
                                                         QString,
                                                         QString)),
                             this,
                             SLOT(qScriptFinishedSlot(QString,
                                                      QString,
                                                      QString)));

            if (url.userName() == "interactive") {
                runningScripts.insert(scriptId, scriptHandler);
            }
        }

        if (url.userName() == "interactive" and
                runningScripts.contains(scriptId) and
                postDataArray.length() > 0) {

            QScriptHandler *handler =
                    runningScripts.value(scriptId);
            if (handler->scriptProcess.isOpen()) {
                postDataArray.append(QString("\n").toLatin1());
                handler->scriptProcess.write(postDataArray);
            }
        }
    }

    void qDisplayScriptOutputSlot(QString output,
                                  QString targetElement)
    {
        QString outputInsertionJavaScript =
                "pebOutputInsertion(\"" +
                output +
                "\" , \"" +
                targetElement +
                "\"); null";

        mainFrame()->evaluateJavaScript(outputInsertionJavaScript);
    }

    void qScriptFinishedSlot(QString scriptAccumulatedErrors,
                             QString scriptId,
                             QString scriptFullFilePath)
    {
        runningScripts.remove(scriptId);

        if (scriptAccumulatedErrors.length() > 0) {
            QString scriptErrorTitle =
                    "Errors were found during script execution:";

            scriptAccumulatedErrors.replace(QRegExp("\n\n$"), "\n");

            QString scriptError = scriptErrorTitle +
                    "<br>" +
                    scriptFullFilePath +
                    "<br><br>" +
                    "<pre>" +
                    scriptAccumulatedErrors +
                    "</pre>";

            QFileReader *resourceReader =
                    new QFileReader(QString(":/html/error.html"));
            QString scriptFormattedErrors = resourceReader->fileContents;

            scriptFormattedErrors.replace("ERROR_MESSAGE", scriptError);

            emit displayScriptErrorsSignal(scriptFormattedErrors);
        }

        if (windowCloseRequested == true and runningScripts.isEmpty()) {
            emit closeWindowSignal();
        }
    }

    // ==============================
    // Page security:
    // ==============================
    void qSslErrorsSlot(QNetworkReply *reply, const QList<QSslError> &errors)
    {
        reply->ignoreSslErrors();

        foreach (QSslError error, errors) {
            qDebug() << "SSL error:" << error;
        }
    }

    void qNetworkReply(QNetworkReply *reply)
    {
        if (reply->error() != QNetworkReply::NoError) {
            qDebug() << "Network error:" << reply->errorString();

            if (reply->url().fileName().length() == 0) {
                QFileReader *resourceReader =
                        new QFileReader(QString(":/html/error.html"));
                QString htmlErrorContents = resourceReader->fileContents;

                htmlErrorContents
                        .replace("ERROR_MESSAGE",
                                 "<br>" + reply->errorString() + "<br><br>" +
                                 "<a href='" +
                                 qApp->property("startPage").toString() +
                                 "'>start page</a>");
                QPage::mainFrame()->setHtml(htmlErrorContents);
            }
        }

        if (reply->error() == QNetworkReply::NoError) {
            if (mainFrame()->securityOrigin().scheme() == "file" and
                    reply->url().scheme() != "file" and
                    reply->url().userName().length() == 0 and
                    reply->url().password().length() == 0 and
                    reply->url().authority() !=
                    qApp->property("pseudoDomain").toString()) {
                qMixedContentWarning(reply->url());
            }
        }
    }

    void qMixedContentWarning(QUrl url)
    {
        QString errorMessage =
                "<br>Mixed content is detected.<br>"
                "Offending URL:<br>" +
                url.toString() + "<br>"
                "Mixing local and web content is prohibited.<br><br>"
                "<a href='" +
                qApp->property("startPage").toString() +
                "'>start page</a>";
        qWarning() << "Mixed content is detected. Offending URL:"
                   << url.toString();

        QFileReader *resourceReader =
                new QFileReader(QString(":/html/error.html"));
        QString htmlErrorContents = resourceReader->fileContents;

        htmlErrorContents.replace("ERROR_MESSAGE", errorMessage);
        QPage::mainFrame()->setHtml(htmlErrorContents);
    }

    // ==============================
    // Select files or folders:
    // ==============================
    void qSelectInodesSlot(QNetworkRequest request)
    {
        QString target = request.url().query().replace("target=", "");

        QFileDialog inodesDialog (qApp->activeWindow());
        inodesDialog.setWindowModality(Qt::WindowModal);
        inodesDialog.setViewMode(QFileDialog::Detail);
#ifdef Q_OS_WIN
        inodesDialog.setOption(QFileDialog::DontUseNativeDialog);
#endif

        if (request.url().fileName() == "open-file.function") {
            inodesDialog.setFileMode(QFileDialog::AnyFile);
        }

        if (request.url().fileName() == "open-files.function") {
            inodesDialog.setFileMode(QFileDialog::ExistingFiles);
        }

        if (request.url().fileName() == "new-file-name.function") {
            inodesDialog.setAcceptMode(QFileDialog::AcceptSave);
        }

        if (request.url().fileName() == "open-directory.function") {
            inodesDialog.setFileMode(QFileDialog::Directory);
        }

        QStringList userSelectedInodes;
        if (inodesDialog.exec()) {
            userSelectedInodes = inodesDialog.selectedFiles();
        }

        inodesDialog.close();
        inodesDialog.deleteLater();

        if (!userSelectedInodes.isEmpty()) {
            QString userSelectedInodesFormatted;
            foreach (QString userSelectedInode, userSelectedInodes) {
                userSelectedInodesFormatted.append(userSelectedInode);
                userSelectedInodesFormatted.append(";");
            }
            userSelectedInodesFormatted.replace(QRegularExpression(";$"), "");

            // JavaScript bridge back to
            // the local HTML page where request originated:
            QString inodeSelectedJavaScript =
                    "pebInodeSelection(\"" +
                    userSelectedInodesFormatted +
                    "\" , \"" +
                    target +
                    "\"); null";

            mainFrame()->evaluateJavaScript(inodeSelectedJavaScript);
        }
    }

    // ==============================
    // Page-closing routines:
    // ==============================
    void qInitiateWindowClosingSlot()
    {
        QVariant checkUserInputJsResult =
                mainFrame()->
                evaluateJavaScript("pebCheckUserInputBeforeClose()");
        bool textIsEntered = checkUserInputJsResult.toBool();

        QVariant checkCloseWarningJsResult =
                mainFrame()->evaluateJavaScript("pebCheckCloseWarning()");
        QString closeWarning = checkCloseWarningJsResult.toString();

        if (textIsEntered == true) {
            if (closeWarning == "async") {
                mainFrame()->evaluateJavaScript("pebCloseConfirmationAsync()");
            }

            if (closeWarning == "sync") {
                QVariant jsSyncResult =
                        mainFrame()->
                        evaluateJavaScript("pebCloseConfirmationSync()");

                bool jsCloseDecision;
                if (jsSyncResult.toString().length() > 0) {
                    jsCloseDecision = jsSyncResult.toBool();
                } else {
                    jsCloseDecision = true;
                }

                if (jsCloseDecision == true) {
                    if (!runningScripts.isEmpty()){
                        emit closeAllScriptsSignal();
                    } else {
                        emit closeWindowSignal();
                    }
                }
            }

            if (closeWarning == "none") {
                if (!runningScripts.isEmpty()){
                    emit closeAllScriptsSignal();
                } else {
                    emit closeWindowSignal();
                }
            }
        }

        if (textIsEntered == false) {
            if (!runningScripts.isEmpty()){
                emit closeAllScriptsSignal();
            } else {
                emit closeWindowSignal();
            }
        }
    }

    void qCloseAllScriptsSlot()
    {
        windowCloseRequested = true;

        if (!runningScripts.isEmpty()) {
            int maximumTimeMilliseconds = 5000;
            QTimer::singleShot(maximumTimeMilliseconds,
                               this,
                               SLOT(qScriptsTimeoutSlot()));

            QHash<QString, QScriptHandler*>::iterator iterator;
            for (iterator = runningScripts.begin();
                 iterator != runningScripts.end();
                 ++iterator) {
                QScriptHandler *handler = iterator.value();

                QByteArray scriptCloseCommandArray;
                scriptCloseCommandArray
                        .append(
                            QString(handler->scriptCloseCommand).toLatin1());
                scriptCloseCommandArray.append(QString("\n").toLatin1());

                handler->scriptProcess.write(scriptCloseCommandArray);
            }
        }
    }

    void qScriptsTimeoutSlot()
    {
        if (!runningScripts.isEmpty()) {
            QHash<QString, QScriptHandler*>::iterator iterator;
            for (iterator = runningScripts.begin();
                 iterator != runningScripts.end();
                 ++iterator) {
                QScriptHandler *handler = iterator.value();

                if (handler->scriptProcess.isOpen()) {
                    handler->scriptProcess.kill();

                    qDebug() << "Interactive script"
                             << "timed out after close command and"
                             << "was killed:"
                             << handler->scriptFullFilePath;
                }
            }
        }

        emit closeWindowSignal();
    }

    void qCloseWindowTransmitterSlot()
    {
        emit closeWindowSignal();
    }

protected:
    // ==============================
    // Link clicking management:
    // ==============================
    bool acceptNavigationRequest(QWebFrame *frame,
                                 const QNetworkRequest &request,
                                 QWebPage::NavigationType navigationType)
    {
        // ==============================
        // Web page called from a local page
        // is loaded in a new browser window:
        // ==============================
        if (mainFrame()->securityOrigin().scheme() == "file" and
                request.url().scheme().contains("http") and
                request.url().userName().length() == 0 and
                request.url().password().length() == 0 and
                request.url().authority() !=
                qApp->property("pseudoDomain").toString()) {

            QWebPage *page =
                    QPage::createWindow(QWebPage::WebBrowserWindow);
            page->mainFrame()->load(request.url());

            return false;
        }

        if (request.url().authority() ==
                qApp->property("pseudoDomain").toString()) {
            // ==============================
            // User selected single file:
            // ==============================
            if (navigationType == QWebPage::NavigationTypeLinkClicked and
                    request.url().fileName() == "open-file.function") {
                if (request.url().query()
                        .replace("target=", "").length() > 0) {
                    qSelectInodesSlot(request);
                }

                return false;
            }

            // ==============================
            // User selected multiple files:
            // ==============================
            if (navigationType == QWebPage::NavigationTypeLinkClicked and
                    request.url().fileName() == "open-files.function") {
                if (request.url().query()
                        .replace("target=", "").length() > 0) {
                    qSelectInodesSlot(request);
                }

                return false;
            }

            // ==============================
            // User selected new file name:
            // ==============================
            if (navigationType == QWebPage::NavigationTypeLinkClicked and
                    request.url().fileName() == "new-file-name.function") {
                if (request.url().query()
                        .replace("target=", "").length() > 0) {
                    qSelectInodesSlot(request);
                }

                return false;
            }

            // ==============================
            // User selected directory:
            // ==============================
            if (navigationType == QWebPage::NavigationTypeLinkClicked and
                    request.url().fileName() == "open-directory.function") {
                if (request.url().query()
                        .replace("target=", "").length() > 0) {
                    qSelectInodesSlot(request);
                }

                return false;
            }

#ifndef QT_NO_PRINTER
            // ==============================
            // Print preview from URL:
            // ==============================
            if (navigationType == QWebPage::NavigationTypeLinkClicked and
                    request.url().fileName() == "print.function" and
                    request.url().query() == "action=preview") {

                emit printPreviewSignal();

                return false;
            }

            // ==============================
            // Print page from URL:
            // ==============================
            if (navigationType == QWebPage::NavigationTypeLinkClicked and
                    request.url().fileName() == "print.function" and
                    request.url().query() == "action=print") {
                emit printSignal();

                return false;
            }
#endif

            // ==============================
            // About browser dialog box:
            // ==============================
            if (navigationType == QWebPage::NavigationTypeLinkClicked and
                    request.url().fileName() == "about.function" and
                    request.url().query() == "type=browser") {
                QFileReader *resourceReader =
                        new QFileReader(QString(":/html/about.html"));
                QString aboutPageContents = resourceReader->fileContents;

                aboutPageContents
                        .replace("VERSION_STRING",
                                 QApplication::applicationVersion()
                                 .toLatin1());

                aboutPageContents
                        .replace("START_PAGE",
                                 qApp->property("startPage").toString());

                frame->setHtml(aboutPageContents);

                return false;
            }

            // ==============================
            // About Qt dialog box:
            // ==============================
            if (navigationType == QWebPage::NavigationTypeLinkClicked and
                    request.url().fileName() == "about.function" and
                    request.url().query() == "type=qt") {
                QApplication::aboutQt();

                return false;
            }
        }

        return QWebPage::acceptNavigationRequest(frame,
                                                 request,
                                                 navigationType);
    }

    // ==============================
    // JavaScript Alert:
    // ==============================
    virtual void javaScriptAlert(QWebFrame *frame, const QString &msg)
    {
        QFileReader *resourceReader =
                new QFileReader(QString(":/peb.js"));
        QString pebJavaScript = resourceReader->fileContents;

        frame->evaluateJavaScript(pebJavaScript);

        QVariant messageBoxElementsJsResult =
                frame->evaluateJavaScript("pebFindMessageBoxElements()");

        QJsonDocument messageBoxElementsJsonDocument =
                QJsonDocument::fromJson(
                    messageBoxElementsJsResult.toString().toUtf8());

        QJsonObject messageBoxElementsJsonObject =
                messageBoxElementsJsonDocument.object();

        if (messageBoxElementsJsonObject.length() > 0) {
            if (messageBoxElementsJsonObject["alertTitle"]
                    .toString().length() > 0) {
                alertTitle =
                        messageBoxElementsJsonObject["alertTitle"]
                        .toString();
            }

            if (messageBoxElementsJsonObject["okLabel"]
                    .toString().length() > 0) {
                okLabel =
                        messageBoxElementsJsonObject["okLabel"].toString();
            }
        }

        QMessageBox javaScriptAlertMessageBox (qApp->activeWindow());
        javaScriptAlertMessageBox.setWindowModality(Qt::WindowModal);
        javaScriptAlertMessageBox.setWindowTitle(alertTitle);
        javaScriptAlertMessageBox.setText(msg);
        javaScriptAlertMessageBox.setButtonText(QMessageBox::Ok, okLabel);
        javaScriptAlertMessageBox.setDefaultButton(QMessageBox::Ok);
        javaScriptAlertMessageBox.exec();
    }

    // ==============================
    // JavaScript Confirm:
    // ==============================
    virtual bool javaScriptConfirm(QWebFrame *frame, const QString &msg)
    {
        QFileReader *resourceReader =
                new QFileReader(QString(":/peb.js"));
        QString pebJavaScript = resourceReader->fileContents;

        frame->evaluateJavaScript(pebJavaScript);

        QVariant messageBoxElementsJsResult =
                frame->evaluateJavaScript("pebFindMessageBoxElements()");

        QJsonDocument messageBoxElementsJsonDocument =
                QJsonDocument::fromJson(
                    messageBoxElementsJsResult.toString().toUtf8());

        QJsonObject messageBoxElementsJsonObject =
                messageBoxElementsJsonDocument.object();

        if (messageBoxElementsJsonObject.length() > 0) {
            if (messageBoxElementsJsonObject["confirmTitle"]
                    .toString().length() > 0) {
                confirmTitle =
                        messageBoxElementsJsonObject["confirmTitle"].toString();
            }

            if (messageBoxElementsJsonObject["yesLabel"]
                    .toString().length() > 0) {
                yesLabel =
                        messageBoxElementsJsonObject["yesLabel"].toString();
            }

            if (messageBoxElementsJsonObject["noLabel"]
                    .toString().length() > 0) {
                noLabel =
                        messageBoxElementsJsonObject["noLabel"].toString();
            }
        }

        QMessageBox javaScriptConfirmMessageBox (qApp->activeWindow());
        javaScriptConfirmMessageBox.setWindowModality(Qt::WindowModal);
        javaScriptConfirmMessageBox.setWindowTitle(confirmTitle);
        javaScriptConfirmMessageBox.setText(msg);
        javaScriptConfirmMessageBox
                .setStandardButtons(QMessageBox::Yes | QMessageBox::No);
        javaScriptConfirmMessageBox.setButtonText(QMessageBox::Yes, yesLabel);
        javaScriptConfirmMessageBox.setButtonText(QMessageBox::No, noLabel);
        javaScriptConfirmMessageBox.setDefaultButton(QMessageBox::No);
        return QMessageBox::Yes == javaScriptConfirmMessageBox.exec();
    }

    // ==============================
    // JavaScript Prompt:
    // ==============================
    virtual bool javaScriptPrompt(QWebFrame *frame,
                                  const QString &msg,
                                  const QString &defaultValue,
                                  QString *result)
    {
        QFileReader *resourceReader =
                new QFileReader(QString(":/peb.js"));
        QString pebJavaScript = resourceReader->fileContents;

        frame->evaluateJavaScript(pebJavaScript);

        QVariant messageBoxElementsJsResult =
                frame->evaluateJavaScript("pebFindMessageBoxElements()");

        QJsonDocument messageBoxElementsJsonDocument =
                QJsonDocument::fromJson(
                    messageBoxElementsJsResult.toString().toUtf8());

        QJsonObject messageBoxElementsJsonObject =
                messageBoxElementsJsonDocument.object();

        if (messageBoxElementsJsonObject.length() > 0) {
            if (messageBoxElementsJsonObject["promptTitle"]
                    .toString().length() > 0) {
                promptTitle =
                        messageBoxElementsJsonObject["promptTitle"]
                        .toString();
            }

            if (messageBoxElementsJsonObject["okLabel"]
                    .toString().length() > 0) {
                okLabel =
                        messageBoxElementsJsonObject["okLabel"].toString();
            }

            if (messageBoxElementsJsonObject["cancelLabel"]
                    .toString().length() > 0) {
                cancelLabel =
                        messageBoxElementsJsonObject["cancelLabel"].toString();
            }
        }

        bool ok = false;

        QInputDialog dialog;
        dialog.setModal(true);
        dialog.setWindowTitle(promptTitle);
        dialog.setLabelText(msg);
        dialog.setInputMode(QInputDialog::TextInput);
        dialog.setTextValue(defaultValue);
        dialog.setOkButtonText(okLabel);
        dialog.setCancelButtonText(cancelLabel);

        if (dialog.exec() == QDialog::Accepted) {
            *result = dialog.textValue();
            ok = true;
            return ok;
        }

        return ok;
    }

private:
    bool windowCloseRequested;

    QString alertTitle;
    QString confirmTitle;
    QString promptTitle;

    QString okLabel;
    QString cancelLabel;
    QString yesLabel;
    QString noLabel;

public:
    QPage();
    QHash<QString, QScriptHandler*> runningScripts;
};

#endif // PAGE_H
