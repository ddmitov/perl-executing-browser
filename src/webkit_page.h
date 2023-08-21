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
 Dimitar D. Mitov, 2013 - 2020, 2023
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
#include <QRegularExpression>
#include <QUrl>
#include <QWebElement>
#include <QWebFrame>
#include <QWebPage>

#include "file_reader.h"
#include "script_handler.h"

// ==============================
// WEB PAGE CLASS DEFINITION:
// ==============================

class QPage : public QWebPage
{
    Q_OBJECT

signals:

    void pageLoadedSignal();
    void closeWindowSignal();

public slots:

    // ==============================
    // Page initialization:
    // ==============================

    void qPageLoadedSlot(bool ok)
    {
        if (ok) {
            if (QPage::mainFrame()->url().scheme() == "file") {
                // Inject PEB-specific Javascript:
                QFileReader *resourceReader =
                    new QFileReader(QString(":/peb.js"));

                QString pebJavaScript = resourceReader->fileContents;

                mainFrame()->evaluateJavaScript(pebJavaScript);

                // Start getting the page settings:
                QVariant result =
                    mainFrame()->evaluateJavaScript("peb.getPageSettings()");

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

    // ==============================
    // Page settings:
    // ==============================

    void qGetPageSettings(QVariant settingsJsResult) {
        QJsonDocument settingsJsonDocument =
            QJsonDocument::fromJson(settingsJsResult.toString().toUtf8());

        if (settingsJsonDocument.isEmpty()) {
            qApp->setProperty("perlInterpreter", "perl");
        }

        if (!settingsJsonDocument.isEmpty()) {
            QJsonObject settingsJsonObject = settingsJsonDocument.object();

            // Get Perl interpreter:
            QString perlInterpreter;
            QString perlInterpreterSetting =
                settingsJsonObject["perlInterpreter"].toString();

            if (perlInterpreterSetting.length() > 0) {
                perlInterpreter =
                    qApp->property("appDir").toString()
                    + '/'
                    + settingsJsonObject["perlInterpreter"].toString();
            }

            if (perlInterpreterSetting.length() == 0) {
                perlInterpreter = "perl";
            }

            qApp->setProperty("perlInterpreter", perlInterpreter);

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
                mainFrame()->evaluateJavaScript("peb.getDialogSettings("
                                                + dialogObjectName
                                                + ")");

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

        QFileDialog inodesDialog(qApp->activeWindow());

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

    void qStartScript(QString scriptObjectName)
    {
        QVariant scriptSettings =
            mainFrame()->evaluateJavaScript(
                "peb.getScriptSettings(" + scriptObjectName + ")");

        QJsonDocument scriptJsonDocument =
            QJsonDocument::fromJson(scriptSettings.toString().toUtf8());

        if (!scriptJsonDocument.isEmpty()) {
            QJsonObject scriptJsonObject = scriptJsonDocument.object();

            QScriptHandler *scriptHandler = 
                new QScriptHandler(scriptJsonObject);

            scriptHandler->id = scriptObjectName;

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

            QString scriptInput = scriptJsonObject["scriptInput"].toString();

            if (scriptInput.length() > 0) {
                if (scriptHandler->process.isOpen()) {
                    scriptHandler->process.write(scriptInput.toUtf8());
                    scriptHandler->process.write(QString("\n").toLatin1());
                }
            }
        }
    }

    void qDisplayScriptOutputSlot(QString id, QString output)
    {
        QString outputInsertionJavaScript =
            id + ".stdoutFunction('" + output + "'); null";

        mainFrame()->evaluateJavaScript(outputInsertionJavaScript);
    }

    void qDisplayScriptErrorsSlot(QString errors)
    {
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

    // ==============================
    // Page-closing routine:
    // ==============================

    void qCloseWindowSlot()
    {
        QVariant jsResult =
            mainFrame()->evaluateJavaScript(
                "peb.checkUserInputBeforeClose()");

        bool jsCloseDecision = true;

        if (jsResult.toByteArray().length() > 0) {
            jsCloseDecision = jsResult.toBool();
        }

        if (jsCloseDecision == true) {
            emit closeWindowSignal();
        }
    }

protected:

    // ==============================
    // Special URLs:
    // ==============================

    bool acceptNavigationRequest(QWebFrame *frame,
                                 const QNetworkRequest &request,
                                 QWebPage::NavigationType navigationType)
    {
        Q_UNUSED(frame);

        // No access to web pages:
        if (request.url().scheme() != "file") {
            return false;
        }

        if (navigationType == QWebPage::NavigationTypeLinkClicked) {
            // Handle filesystem dialogs:
            if (request.url().fileName().contains(".dialog")) {
                qHandleDialogs(request.url()
                               .fileName()
                               .replace(".dialog", ""));

                return false;
            }

            // Handle Perl scripts after link is clicked:
            if (request.url().fileName().contains(".script")) {
                qStartScript(request.url().fileName().replace(".script", ""));

                return false;
            }
        }

        // Handle Perl scripts after form is submitted:
        if (navigationType == QWebPage::NavigationTypeFormSubmitted and
            request.url().fileName().contains(".script")) {
            qStartScript(request.url().fileName().replace(".script", ""));

            return false;
        }

        return QWebPage::acceptNavigationRequest(frame,
                                                 request,
                                                 navigationType);
    }

    // ==============================
    // JavaScript Dialogs:
    // ==============================
    virtual void javaScriptAlert(QWebFrame *frame, const QString &msg)
    {
        Q_UNUSED(frame);

        QMessageBox alertMessage(qApp->activeWindow());

        alertMessage.setWindowModality(Qt::WindowModal);
        alertMessage.setWindowTitle(title);
        alertMessage.setText(msg);
        alertMessage.setButtonText(QMessageBox::Ok, okLabel);
        alertMessage.setDefaultButton(QMessageBox::Ok);

        alertMessage.exec();
    }

    virtual bool javaScriptConfirm(QWebFrame *frame, const QString &msg)
    {
        Q_UNUSED(frame);

        QMessageBox confirmMessage(qApp->activeWindow());

        confirmMessage.setWindowModality(Qt::WindowModal);
        confirmMessage.setWindowTitle(title);
        confirmMessage.setText(msg);
        confirmMessage.setStandardButtons(QMessageBox::Yes | QMessageBox::No);
        confirmMessage.setDefaultButton(QMessageBox::No);
        confirmMessage.setButtonText(QMessageBox::Yes, yesLabel);
        confirmMessage.setButtonText(QMessageBox::No, noLabel);

        return QMessageBox::Yes == confirmMessage.exec();
    }

    virtual bool javaScriptPrompt(QWebFrame *frame,
                                  const QString &msg,
                                  const QString &defaultValue,
                                  QString *result)
    {
        Q_UNUSED(frame);

        bool okPressed = false;

        QInputDialog prompt;

        prompt.setModal(true);
        prompt.setWindowTitle(title);
        prompt.setLabelText(msg);
        prompt.setInputMode(QInputDialog::TextInput);
        prompt.setTextValue(defaultValue);
        prompt.setOkButtonText(okLabel);
        prompt.setCancelButtonText(cancelLabel);

        if (prompt.exec() == QDialog::Accepted) {
            *result = prompt.textValue();
            okPressed = true;
            return okPressed;
        }

        return okPressed;
    }

private:

    QString title;

    QString okLabel;
    QString cancelLabel;
    QString yesLabel;
    QString noLabel;

public:

    QPage();
};

#endif // PAGE_H
