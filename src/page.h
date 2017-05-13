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

#include <QInputDialog>
#include <QJsonDocument>
#include <QJsonObject>
#include <QMessageBox>
#include <QNetworkReply>
#include <QRegularExpression>
#include <QTimer>
#include <QUrl>
#include <QUrlQuery>
#include <QWebPage>
#include <QWebFrame>

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
    void pageStatusSignal(QString pageStatus);
    void closeAllScriptsSignal();
    void closeWindowSignal();

public slots:
    void qPageLoadedSlot(bool ok)
    {
        if (ok) {
            emit changeTitleSignal();
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
                                                         QString,
                                                         QString,
                                                         QString)),
                             this,
                             SLOT(qScriptFinishedSlot(QString,
                                                      QString,
                                                      QString,
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
        if (targetElement.length() > 0) {
            qOutputInserter(currentFrame(), targetElement, output);
        } else {
            currentFrame()->setHtml(output,
                                    QUrl(qApp->property("pseudoDomain")
                                         .toString()));
        }
    }

    void qScriptFinishedSlot(QString scriptAccumulatedOutput,
                             QString scriptAccumulatedErrors,
                             QString scriptId,
                             QString scriptFullFilePath,
                             QString scriptTargetElement)
    {
        runningScripts.remove(scriptId);

        if (pageStatus == "trusted") {
            // If script has no errors and
            // no STDOUT target:
            if (scriptAccumulatedOutput.length() > 0 and
                    scriptAccumulatedErrors.length() == 0 and
                    scriptTargetElement.length() == 0) {
                qDisplayScriptOutputSlot(scriptAccumulatedOutput,
                                         emptyString);
            }

            if (scriptAccumulatedErrors.length() > 0) {
                if (scriptAccumulatedOutput.length() == 0) {
                    if (scriptTargetElement.length() == 0) {
                        // If script has no output and
                        // only errors and
                        // no STDOUT target is defined,
                        // all HTML formatted errors will be displayed
                        // in the same window:
                        qFormatScriptErrors(scriptAccumulatedErrors,
                                            scriptFullFilePath,
                                            false);
                    } else {
                        // If script has no output and
                        // only errors and
                        // a STDOUT target is defined,
                        // all HTML formatted errors will be displayed
                        // in a new window:
                        qFormatScriptErrors(scriptAccumulatedErrors,
                                            scriptFullFilePath,
                                            true);
                    }
                } else {
                    // If script has some output and errors,
                    // HTML formatted errors
                    // will be displayed in a new window:
                    qFormatScriptErrors(scriptAccumulatedErrors,
                                        scriptFullFilePath,
                                        true);
                    qDisplayScriptOutputSlot(emptyString,
                                             scriptAccumulatedOutput);
                }
            }
        }

        if (windowCloseRequested == true and runningScripts.isEmpty()) {
            emit closeWindowSignal();
        }
    }

    void qOutputInserter(QWebFrame *targetFrame,
                         QString targetElement,
                         QString data)
    {
        qJavaScriptInjector(targetFrame);

        QString outputInsertionJavaScript =
                "pebOutputInsertion(\"" +
                data +
                "\" , \"" +
                targetElement +
                "\"); null";

        targetFrame->evaluateJavaScript(outputInsertionJavaScript);
    }

    void qFormatScriptErrors(QString errors,
                             QString scriptFullFilePath,
                             bool newWindow)
    {
        QString scriptErrorTitle = "Errors were found during script execution:";

        errors.replace(QRegExp("\n\n$"), "\n");

        QString scriptError = scriptErrorTitle +
                "<br>" +
                scriptFullFilePath +
                "<br><br>" +
                "<pre>" +
                errors +
                "</pre>";

        QFileReader *resourceReader =
                new QFileReader(QString(":/html/error.html"));
        QString scriptFormattedErrors = resourceReader->fileContents;

        scriptFormattedErrors.replace("ERROR_MESSAGE", scriptError);

        if (newWindow == false) {
            qDisplayScriptOutputSlot(emptyString,
                                     scriptFormattedErrors);
        }

        if (newWindow == true) {
            emit displayScriptErrorsSignal(scriptFormattedErrors);
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
        QStringList trustedDomains =
                qApp->property("trustedDomains").toStringList();

        if (reply->error() != QNetworkReply::NoError) {
            qDebug() << "Network error:" << reply->errorString();

            if (reply->url().fileName().length() == 0 or
                    reply->url().userName() == "ajax") {
                QFileReader *resourceReader =
                        new QFileReader(QString(":/html/error.html"));
                QString htmlErrorContents = resourceReader->fileContents;

                htmlErrorContents
                        .replace("ERROR_MESSAGE",
                                 "<p>" + reply->errorString() + "</p>");
                QPage::currentFrame()->setHtml(htmlErrorContents);
            }
        }

        if (reply->error() == QNetworkReply::NoError) {
            if (reply->url() == qApp->property("startPage").toString()) {
                pageStatus = "trusted";
                emit pageStatusSignal(pageStatus);
            }

            if (pageStatus.length() == 0) {
                if (trustedDomains.contains(reply->url().host())) {
                    pageStatus = "trusted";
                    emit pageStatusSignal(pageStatus);
                }

                if (!trustedDomains.contains(reply->url().host())) {
                    pageStatus = "untrusted";
                    emit pageStatusSignal(pageStatus);
                }
            }

            if (pageStatus == "trusted") {
                if (!trustedDomains.contains(reply->url().host())) {
                    qMixedContentWarning(reply->url());
                }
            }
        }
    }

    void qMixedContentWarning(QUrl url)
    {
        QString errorMessage =
                "<p>Mixed content is detected.<br>"
                "Offending URL:<br>" +
                url.toString() + "<br>"
                "Mixing trusted and untrusted content is prohibited.<br>"
                "Go to <a href='" +
                qApp->property("startPage").toString() +
                "'>start page</a> "
                "to unlock local scripting.</p>";
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
            // the local HTML frame where request originated:
            qJavaScriptInjector(currentFrame());

            QString inodeSelectedJavaScript =
                    "pebInodeSelection(\"" +
                    userSelectedInodesFormatted +
                    "\" , \"" +
                    target +
                    "\"); null";

            currentFrame()->evaluateJavaScript(inodeSelectedJavaScript);

            qDebug() << "User selected inode:" << userSelectedInodesFormatted;
        }
    }

    // ==============================
    // JavaScript-injecting routine:
    // ==============================
    void qJavaScriptInjector(QWebFrame *frame)
    {
        QFileReader *resourceReader =
                new QFileReader(QString(":/peb.js"));
        QString pebJavaScript = resourceReader->fileContents;

        frame->evaluateJavaScript(pebJavaScript);
    }

    // ==============================
    // Page-closing routines:
    // ==============================
    void qInitiateWindowClosingSlot()
    {
        if (mainFrame()->childFrames().length() > 0) {
            foreach (QWebFrame *frame, mainFrame()->childFrames()) {
                qUserInputFrameIterator(frame);
            }
        } else {
            qCheckUserInputBeforeClose(mainFrame());
        }
    }

    void qUserInputFrameIterator(QWebFrame *frame)
    {
        if (frame->childFrames().length() > 0) {
            qCheckUserInputBeforeClose(frame);
            foreach (QWebFrame *frame, frame->childFrames()) {
                qUserInputFrameIterator(frame);
            }
        } else {
            qCheckUserInputBeforeClose(frame);
        }
    }

    void qCheckUserInputBeforeClose(QWebFrame *frame)
    {
        qJavaScriptInjector(frame);

        QVariant checkUserInputJsResult =
                frame->evaluateJavaScript("pebCheckUserInputBeforeClose()");
        bool textIsEntered = checkUserInputJsResult.toBool();

        QVariant checkCloseWarningJsResult =
                frame->evaluateJavaScript("pebCheckCloseWarning()");
        QString closeWarning = checkCloseWarningJsResult.toString();

        if (textIsEntered == true) {
            if (closeWarning == "async") {
                frame->evaluateJavaScript("pebCloseConfirmationAsync()");
            }

            if (closeWarning == "sync") {
                QVariant jsSyncResult =
                        frame->evaluateJavaScript("pebCloseConfirmationSync()");

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
        // Untrusted domains called from a trusted page
        // are loaded in new browser windows:
        // ==============================
        QStringList trustedDomains =
                qApp->property("trustedDomains").toStringList();

        if (pageStatus == "trusted" and
                (!trustedDomains.contains(request.url().authority())) and
                (request.url().fileName().length() == 0 or
                 request.url().fileName()
                 .contains(htmlFileNameExtensionMarker))) {
            QWebPage *page =
                    QPage::createWindow(QWebPage::WebBrowserWindow);
            page->mainFrame()->load(request.url());

            return false;
        }

        if (request.url().authority() ==
                qApp->property("pseudoDomain").toString()) {
            if (pageStatus == "trusted") {
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

            if (pageStatus == "untrusted") {
                qMixedContentWarning(request.url());
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
    QString pageStatus;
    QRegExp htmlFileNameExtensionMarker;
    QString emptyString;
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
