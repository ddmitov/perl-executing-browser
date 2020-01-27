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
 Dimitar D. Mitov, 2013 - 2020
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
#include "file-writer.h"
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
    void hideWindowSignal();
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

                // Log basic program information on the JavaScript console:
                QString applicationVersion =
                        "peb.browser_version = '" +
                        qApp->applicationVersion().toLatin1() + "';";
                mainFrame()->evaluateJavaScript(applicationVersion);

                QString qtVersion =
                        "peb.qt_version = '" + QString(QT_VERSION_STR) + "';";
                mainFrame()->evaluateJavaScript(qtVersion);

                QString applicationVersionMessage =
                        "console.log('Browser version: ' + peb.browser_version);";
                mainFrame()->evaluateJavaScript(applicationVersionMessage);

                QString qtVersionMessage =
                        "console.log('Qt version: ' + peb.qt_version);";
                mainFrame()->evaluateJavaScript(qtVersionMessage);
            }
        }
    }

    // ==============================
    // Page settings:
    // ==============================

    void qGetPageSettings(QVariant settingsJsResult) {
        QJsonDocument settingsJsonDocument =
                QJsonDocument::fromJson(settingsJsResult.toString().toUtf8());

        if (!settingsJsonDocument.isEmpty()) {
            QJsonObject settingsJsonObject = settingsJsonDocument.object();

            // Get Perl interpreter:
            QString perlInterpreter;
            QString perlInterpreterSetting =
                    settingsJsonObject["perlInterpreter"].toString();

            if (perlInterpreterSetting.length() > 0) {
                perlInterpreter =
                        qApp->property("appDir").toString() + '/' +
                        settingsJsonObject["perlInterpreter"].toString();
            }

            if (perlInterpreterSetting.length() == 0) {
                perlInterpreter = "perl";
            }

            qApp->setProperty("perlInterpreter", perlInterpreter);

            // Get all autostarting scripts:
            QJsonArray autoStartScripts =
                    settingsJsonObject["autoStartScripts"].toArray();

            foreach (const QJsonValue &value, autoStartScripts) {
                QString autoStartScript = value.toString();
                qHandleScript(autoStartScript);
            }

            // Get dialog and context menu labels:
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
                noLabel = settingsJsonObject["noLabel"].toString();
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
    // Filesystem dialogs:
    // ==============================
    void qHandleDialogs(QString dialogObjectName)
    {
        if (QPage::mainFrame()->url().scheme() == "file") {
            QVariant dialogSettings =
                    mainFrame()->evaluateJavaScript(
                        "peb.getDialogSettings(" + dialogObjectName + ")");

            QJsonDocument dialogJsonDocument =
                    QJsonDocument::fromJson(dialogSettings.toString().toUtf8());

            if (!dialogJsonDocument.isEmpty()) {
                QJsonObject dialogJsonObject = dialogJsonDocument.object();
                dialogJsonObject["id"] = dialogObjectName;
                qReadDialogSettings(dialogJsonObject);
            }
        }
    }

    void qReadDialogSettings(QJsonObject dialogJsonObject)
    {
        QString id = dialogJsonObject["id"].toString();
        QString type = dialogJsonObject["type"].toString();

        QFileDialog inodesDialog (qApp->activeWindow());
        inodesDialog.setWindowModality(Qt::WindowModal);
        inodesDialog.setViewMode(QFileDialog::Detail);
        inodesDialog.setDirectory(qApp->property("browserDir").toString());

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
    // Perl scripts:
    // ==============================
    void qHandleScript(QString scriptObjectName)
    {
        if (QPage::mainFrame()->url().scheme() == "file") {
            QVariant scriptSettings =
                    mainFrame()->evaluateJavaScript(
                        "peb.getScriptSettings(" + scriptObjectName + ")");

            QJsonDocument scriptJsonDocument =
                    QJsonDocument::fromJson(scriptSettings.toString().toUtf8());

            if (!scriptJsonDocument.isEmpty()) {
                QJsonObject scriptJsonObject = scriptJsonDocument.object();
                scriptJsonObject["id"] = scriptObjectName;
                qScriptStartedCheck(scriptJsonObject);
            }
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
                         SIGNAL(displayScriptErrorsSignal(QString)),
                         this,
                         SLOT(qDisplayScriptErrorsSlot(QString)));

        QObject::connect(scriptHandler, SIGNAL(scriptFinishedSignal(QString)),
                         this, SLOT(qScriptFinishedSlot(QString)));

        runningScripts.insert(scriptJsonObject["id"].toString(), scriptHandler);
    }

    void qFeedScript(QJsonObject scriptJsonObject)
    {
        QString tempFileFullPath =
                temporaryFiles.value(scriptJsonObject["id"].toString());

        if (closeRequested == false) {
            QString scriptInput = scriptJsonObject["scriptInput"].toString();

            if (scriptInput.length() > 0) {
                if (tempFileFullPath.length() == 0) {
                    qWriteOnScriptStdin(scriptJsonObject, scriptInput);
                }

                if (tempFileFullPath.length() > 0) {
                    qWriteInScriptTempFile(tempFileFullPath, scriptInput);
                }
            }
        }

        if (closeRequested == true) {
            QString exitCommand = scriptJsonObject["exitCommand"].toString();

            if (tempFileFullPath.length() == 0) {
                qWriteOnScriptStdin(scriptJsonObject, exitCommand);
            }

            if (tempFileFullPath.length() > 0) {
                qWriteInScriptTempFile(tempFileFullPath, exitCommand);
            }
        }
    }

    void qWriteOnScriptStdin(QJsonObject scriptJsonObject, QString scriptInput)
    {
        QScriptHandler *handler =
                runningScripts.value(scriptJsonObject["id"]
                .toString());
        if (handler->scriptProcess.isOpen()) {
            handler->scriptProcess.write(scriptInput.toUtf8());
            handler->scriptProcess.write(QString("\n").toLatin1());
        }
    }

    void qWriteInScriptTempFile(QString tempFileFullPath, QString scriptInput)
    {
        QFileWriter(tempFileFullPath, scriptInput);
    }

    void qDisplayScriptOutputSlot(QString id, QString output)
    {
        if (QPage::mainFrame()->url().scheme() == "file") {
            QString outputInsertionJavaScript =
                    id + ".stdoutFunction('" + output + "'); null";

            mainFrame()->evaluateJavaScript(outputInsertionJavaScript);

            if (output.contains("tempfile")) {
                QJsonDocument tempFileJsonDocument =
                        QJsonDocument::fromJson(output.toUtf8());
                QJsonObject tempFileJsonObject = tempFileJsonDocument.object();
                QString tempFileFullPath =
                        tempFileJsonObject["tempfile"].toString();

                QFileInfo tempFileInfo(tempFileFullPath);
                if (tempFileInfo.isFile()) {
                    temporaryFiles.insert(id, tempFileFullPath);
                }
            }
        }
    }

    void qDisplayScriptErrorsSlot(QString errors)
    {
        if (QPage::mainFrame()->url().scheme() == "file") {
            if (errors.length() > 0) {
                errors.replace("\"", "\\\"");
                errors.replace("\'", "\\'");
                errors.replace("\n", "\\n");
                errors.replace("\r", "");

                QString perlScriptErrorsMessage =
                        "console.debug('" + errors + "'); null";

                mainFrame()->evaluateJavaScript(perlScriptErrorsMessage);
            }
        }
    }

    void qScriptFinishedSlot(QString id)
    {
        runningScripts.remove(id);

        if (closeRequested == true and runningScripts.isEmpty()) {
            emit closeWindowSignal();
        }
    }

    // ==============================
    // SSL errors:
    // ==============================
    void qSslErrorsSlot(QNetworkReply *reply, const QList<QSslError> &errors)
    {
        Q_UNUSED(errors);
        reply->ignoreSslErrors();
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

        if (jsResult.toByteArray().length() > 0) {
            jsCloseDecision = jsResult.toBool();
        }

        if (jsCloseDecision == true) {
            if (!runningScripts.isEmpty()){
                qCloseAllScriptsSlot();
            } else {
                closeRequested = true;
                emit closeWindowSignal();
            }
        }
    }

    void qCloseAllScriptsSlot()
    {
        closeRequested = true;
        emit hideWindowSignal();

        if (runningScripts.isEmpty()) {
            emit closeWindowSignal();
        } else {
            QHash<QString, QScriptHandler*>::iterator iterator;
            for (iterator = runningScripts.begin();
                 iterator != runningScripts.end();
                 ++iterator) {

                QString scriptObjectName = iterator.key();
                QScriptHandler *handler = iterator.value();

                if (handler->scriptProcess.isOpen()) {
                    qHandleScript(scriptObjectName);
                }
            }

            int maximumTimeMilliseconds = 3000;
            QTimer::singleShot(maximumTimeMilliseconds,
                               this, SLOT(qScriptsTimeoutSlot()));
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
                }
            }
        }

        emit closeWindowSignal();
    }

protected:
    // ==============================
    // Special URLs:
    // ==============================
    bool acceptNavigationRequest(QWebFrame *frame,
                                 const QNetworkRequest &request,
                                 QWebPage::NavigationType navType)
    {
        Q_UNUSED(frame);

        if (request.url().scheme() == "file") {
            if (navType == QWebPage::NavigationTypeLinkClicked) {
                // Handle filesystem dialogs:
                if (request.url().fileName().contains(".dialog")) {
                    qHandleDialogs(request.url().fileName()
                                   .replace(".dialog", ""));
                    return false;
                }

                // Handle local Perl scripts after local link is clicked:
                if (request.url().fileName().contains(".script")) {
                    qHandleScript(request.url().fileName()
                                   .replace(".script", ""));
                    return false;
                }
            }

            // Handle local Perl scripts after local form is submitted:
            if (navType == QWebPage::NavigationTypeFormSubmitted and
                    request.url().fileName().contains(".script")) {
                qHandleScript(request.url().fileName().replace(".script", ""));
                return false;
            }
        }

        return QWebPage::acceptNavigationRequest(frame, request, navType);
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

    QHash<QString, QScriptHandler*> runningScripts;
    QHash<QString, QString> temporaryFiles;

    bool closeRequested;

public:
    QPage();

};

#endif // PAGE_H
