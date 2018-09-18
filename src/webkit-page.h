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
 Dimitar D. Mitov, 2013 - 2018
 Valcho Nedelchev, 2014 - 2016
 https://github.com/ddmitov/perl-executing-browser
*/

#ifndef PAGE_H
#define PAGE_H

#include <QFileDialog>
#include <QInputDialog>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QMessageBox>
#include <QNetworkReply>
#include <QRegularExpression>
#include <QTimer>
#include <QUrl>
#include <QWebElement>
#include <QWebFrame>
#include <QWebPage>

#include "file-reader.h"
#include "script-handler.h"

// ==============================
// WEB PAGE CLASS DEFINITION:
// (QTWEBKIT VERSION)
// ==============================
class QPage : public QWebPage
{
    Q_OBJECT

signals:
    void pageLoadedSignal();
    void closeWindowSignal();

public slots:
    void qPageLoadedSlot(bool ok)
    {
        if (ok) {
            if (QPage::mainFrame()->url().scheme() == "file") {
                // Inject all browser-specific Javascript:
                QFileReader *resourceReader =
                        new QFileReader(QString(":/peb.js"));
                QString pebJavaScript = resourceReader->fileContents;

                mainFrame()->evaluateJavaScript(pebJavaScript);

                // Start getting the page settings:
                QVariant result = mainFrame()->
                        evaluateJavaScript("peb.getPageSettings()");
                qGetPageSettings(result);

                // Get the title of the page for use in dialog boxes:
                QWebElement titleDomElement =
                        QPage::currentFrame()->documentElement()
                        .findFirst("title");
                title = titleDomElement.toInnerXml();

                // Send signal to the html-viewing class that a page is loaded:
                emit pageLoadedSignal();
            }
        }
    }

    void qGetPageSettings(QVariant settingsJsResult) {
        QJsonDocument settingsJsonDocument =
                QJsonDocument::fromJson(settingsJsResult.toString().toUtf8());
        QJsonObject settingsJsonObject = settingsJsonDocument.object();

        // Get auto-start scripts:
        QJsonArray autoStartScripts =
                settingsJsonObject["autoStartScripts"].toArray();

        foreach (const QJsonValue &value, autoStartScripts) {
            QString autoStartScript = value.toString();
            qHandleScripts(autoStartScript);
        }

        // Get dialog and context menu labels:
        if (settingsJsonObject.length() > 0) {
            if (settingsJsonObject["okLabel"].toString().length() > 0) {
                okLabel = settingsJsonObject["okLabel"].toString();
            }

            if (settingsJsonObject["cancelLabel"].toString().length() > 0) {
                cancelLabel = settingsJsonObject["cancelLabel"].toString();
            }

            if (settingsJsonObject["yesLabel"].toString().length() > 0) {
                yesLabel = settingsJsonObject["yesLabel"].toString();
            }

            if (settingsJsonObject["noLabel"].toString().length() > 0) {
                noLabel =settingsJsonObject["noLabel"].toString();
            }

            if (settingsJsonObject["cutLabel"].toString().length() > 0) {
                qApp->setProperty("cutLabel",
                                  settingsJsonObject["cutLabel"].toString());
            }

            if (settingsJsonObject["copyLabel"].toString().length() > 0) {
                qApp->setProperty("copyLabel",
                                  settingsJsonObject["copyLabel"].toString());
            }

            if (settingsJsonObject["pasteLabel"].toString().length() > 0) {
                qApp->setProperty("pasteLabel",
                                  settingsJsonObject["pasteLabel"].toString());
            }

            if (settingsJsonObject["selectAllLabel"].toString().length() > 0) {
                qApp->setProperty(
                            "selectAllLabel",
                            settingsJsonObject["selectAllLabel"].toString());
            }
        }
    }

    // ==============================
    // Filesystem dialogs handling:
    // ==============================
    void qHandleDialogs(QString dialogObjectName)
    {
        if (QPage::mainFrame()->url().scheme() == "file") {
            QVariant dialogSettings =
                    mainFrame()->evaluateJavaScript(
                        "peb.getDialogSettings(" + dialogObjectName + ")");

            QJsonDocument dialogJsonDocument =
                    QJsonDocument::fromJson(dialogSettings.toString().toUtf8());
            QJsonObject dialogJsonObject = dialogJsonDocument.object();

            dialogJsonObject["id"] = dialogObjectName;

            qReadDialogSettings(dialogJsonObject);
        }
    }

    void qReadDialogSettings(QJsonObject dialogJsonObject)
    {
        QString id = dialogJsonObject["id"].toString();

        QString type = dialogJsonObject["type"].toString();

        QFileDialog inodesDialog (qApp->activeWindow());
        inodesDialog.setWindowModality(Qt::WindowModal);
        inodesDialog.setViewMode(QFileDialog::Detail);

#ifdef Q_OS_WIN
        inodesDialog.setOption(QFileDialog::DontUseNativeDialog);
#endif

        if (type == "single-file") {
            inodesDialog.setFileMode(QFileDialog::AnyFile);
        }

        if (type == "multiple-files") {
            inodesDialog.setFileMode(QFileDialog::ExistingFiles);
        }

        if (type == "new-file-name") {
            inodesDialog.setAcceptMode(QFileDialog::AcceptSave);
        }

        if (type == "directory") {
            inodesDialog.setFileMode(QFileDialog::Directory);
        }

        QStringList selectedInodes;
        if (inodesDialog.exec()) {
            selectedInodes = inodesDialog.selectedFiles();
        }

        inodesDialog.close();
        inodesDialog.deleteLater();

        if (!selectedInodes.isEmpty()) {
            QString inodesFormatted;
            foreach (QString userSelectedInode, selectedInodes) {
                inodesFormatted.append(userSelectedInode);
                inodesFormatted.append(";");
            }
            inodesFormatted.replace(QRegularExpression(";$"), "");

            QString outputInsertionJavaScript =
                    id + ".receiverFunction('" + inodesFormatted + "'); null";

            mainFrame()->evaluateJavaScript(outputInsertionJavaScript);
        }
    }

    // ==============================
    // Scripts handling:
    // ==============================
    void qHandleScripts(QString scriptObjectName)
    {
        if (QPage::mainFrame()->url().scheme() == "file") {
            QVariant scriptSettings =
                    mainFrame()->evaluateJavaScript("peb.getScriptSettings(" +
                                                    scriptObjectName + ")");

            QJsonDocument scriptJsonDocument =
                    QJsonDocument::fromJson(
                        scriptSettings.toString().toUtf8());
            QJsonObject scriptJsonObject = scriptJsonDocument.object();

            scriptJsonObject["id"] = scriptObjectName;

            qScriptStartedCheck(scriptJsonObject);
        }
    }

    void qScriptStartedCheck(QJsonObject scriptJsonObject)
    {
        // Start the script if it is not yet started:
        if (!runningScripts.contains(scriptJsonObject["id"].toString())) {
            qStartScript(scriptJsonObject);
        }

        // Feed the script with data if it is already started:
        if (runningScripts.contains(scriptJsonObject["id"].toString())) {
            qFeedScript(scriptJsonObject);
        }
    }

    void qStartScript(QJsonObject scriptJsonObject)
    {
        QScriptHandler *scriptHandler = new QScriptHandler(scriptJsonObject);

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

        runningScripts.insert(scriptJsonObject["id"].toString(), scriptHandler);
    }

    void qFeedScript(QJsonObject scriptJsonObject)
    {
        QString inputData;
        if (scriptJsonObject["inputData"].toString().length() > 0) {
            inputData = scriptJsonObject["inputData"].toString();
        }

        if (inputData.length() > 0) {
            QScriptHandler *handler =
                    runningScripts.value(scriptJsonObject["id"].toString());
            if (handler->scriptProcess.isOpen()) {
                QByteArray inputDataArray = inputData.toUtf8();
                inputDataArray.append(QString("\n").toLatin1());
                handler->scriptProcess.write(inputDataArray);
            }
        }
    }

    void qDisplayScriptOutputSlot(QString id, QString output)
    {
        if (QPage::mainFrame()->url().scheme() == "file") {
            QString outputInsertionJavaScript =
                    id + ".stdoutFunction('" + output + "'); null";

            mainFrame()->evaluateJavaScript(outputInsertionJavaScript);
        }
    }

    void qScriptFinishedSlot(QString scriptId,
                             QString scriptFullFilePath,
                             QString scriptAccumulatedErrors)
    {
        runningScripts.remove(scriptId);

        if (QPage::mainFrame()->url().scheme() == "file") {
            if (scriptAccumulatedErrors.length() > 0) {
                qDebug() << scriptFullFilePath << "errors:"
                         << scriptAccumulatedErrors;
            }
        }

        if (closeRequested == true and runningScripts.isEmpty()) {
            emit closeWindowSignal();
        }
    }

    // ==============================
    // SSL errors:
    // ==============================
    void qSslErrorsSlot(QNetworkReply *reply, const QList<QSslError> &errors)
    {
        reply->ignoreSslErrors();

        foreach (QSslError error, errors) {
            qDebug() << "SSL error:" << error;
        }
    }

    // ==============================
    // Page-closing routines:
    // ==============================
    void qStartWindowClosingSlot()
    {
        if (QPage::mainFrame()->url().scheme() == "file") {
            QVariant jsResult =
                    mainFrame()->evaluateJavaScript(
                        "peb.checkUserInputBeforeClose()");
            qCloseWindow(jsResult);
        } else {
            qCloseAllScriptsSlot();
        }
    }

    void qCloseWindow(QVariant jsResult)
    {
        bool jsCloseDecision = true;
        jsCloseDecision = jsResult.toBool();

        if (jsCloseDecision == true) {
            if (!runningScripts.isEmpty()){
                qCloseAllScriptsSlot();
            } else {
                emit closeWindowSignal();
            }
        }
    }

    void qCloseAllScriptsSlot()
    {
        closeRequested = true;

        if (!runningScripts.isEmpty()) {
            int maximumTimeMilliseconds = 3000;
            QTimer::singleShot(maximumTimeMilliseconds,
                               this,
                               SLOT(qScriptsTimeoutSlot()));

            QHash<QString, QScriptHandler*>::iterator iterator;
            for (iterator = runningScripts.begin();
                 iterator != runningScripts.end();
                 ++iterator) {
                QScriptHandler *handler = iterator.value();

                if (handler->scriptExitCommand.length() == 0 and
                        handler->scriptProcess.isOpen()) {
                    handler->scriptProcess.kill();
                }

                if (handler->scriptExitCommand.length() > 0) {
                    QByteArray scriptExitCommand;
                    scriptExitCommand.append(
                                QString(handler->scriptExitCommand).toLatin1());
                    scriptExitCommand.append(QString("\n").toLatin1());

                    if (handler->scriptProcess.isOpen()) {
                        handler->scriptProcess.write(scriptExitCommand);
                    }
                }
            }
        }

        if (runningScripts.isEmpty()) {
            emit closeWindowSignal();
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

protected:
    // ==============================
    // Special URLs handling:
    // ==============================
    bool acceptNavigationRequest(QWebFrame *frame,
                                 const QNetworkRequest &request,
                                 QWebPage::NavigationType navigationType)
    {
        Q_UNUSED(frame);

        if (request.url().scheme() == "file") {
            // Local forms submission:
            if (navigationType == QWebPage::NavigationTypeFormSubmitted) {
                if (request.url().fileName().contains(".settings")) {
                    qHandleScripts(request.url().fileName()
                                   .replace(".settings", ""));
                    return false;
                } else {
                    return false;
                }
            }

            if (navigationType == QWebPage::NavigationTypeLinkClicked) {
                // Handle filesystem dialogs:
                if (request.url().fileName().contains(".dialog")) {
                    qHandleDialogs(request.url().fileName()
                                   .replace(".dialog", ""));
                    return false;
                }

                // Handle local Perl scripts:
                if (request.url().fileName().contains(".settings")) {
                    qHandleScripts(request.url().fileName()
                                   .replace(".settings", ""));
                    return false;
                }

                // About browser dialog:
                if (request.url().fileName() == "about-browser.function") {
                    QFileReader *resourceReader =
                            new QFileReader(QString(":/html/about.html"));
                    QString aboutText = resourceReader->fileContents;

                    aboutText.replace("APPLICATION_VERSION",
                                      QApplication::applicationVersion());
                    aboutText.replace("QT_VERSION",
                                      QT_VERSION_STR);

                    QPixmap icon(32, 32);
                    icon.load(":/icon/camel.png");

                    QMessageBox aboutBox;
                    aboutBox.setWindowTitle ("About PEB");
                    aboutBox.setIconPixmap(icon);
                    aboutBox.setText(aboutText);
                    aboutBox.setDefaultButton (QMessageBox::Ok);
                    aboutBox.exec();

                    return false;
                }

                // About Qt dialog:
                if (request.url().fileName() == "about-qt.function") {
                    QApplication::aboutQt();
                    return false;
                }
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
        Q_UNUSED(frame);

        QMessageBox javaScriptAlertMessageBox (qApp->activeWindow());
        javaScriptAlertMessageBox.setWindowModality(Qt::WindowModal);
        javaScriptAlertMessageBox.setWindowTitle(title);
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
        Q_UNUSED(frame);

        QMessageBox javaScriptConfirmMessageBox (qApp->activeWindow());
        javaScriptConfirmMessageBox.setWindowModality(Qt::WindowModal);
        javaScriptConfirmMessageBox.setWindowTitle(title);
        javaScriptConfirmMessageBox.setText(msg);
        javaScriptConfirmMessageBox
                .setStandardButtons(QMessageBox::Yes | QMessageBox::No);
        javaScriptConfirmMessageBox.setDefaultButton(QMessageBox::No);
        javaScriptConfirmMessageBox.setButtonText(QMessageBox::Yes, yesLabel);
        javaScriptConfirmMessageBox.setButtonText(QMessageBox::No, noLabel);
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
        Q_UNUSED(frame);

        bool ok = false;

        QInputDialog dialog;
        dialog.setModal(true);
        dialog.setWindowTitle(title);
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
    QString title;

    QString okLabel;
    QString cancelLabel;
    QString yesLabel;
    QString noLabel;

    bool closeRequested;

public:
    QPage();
    QHash<QString, QScriptHandler*> runningScripts;
};

#endif // PAGE_H
