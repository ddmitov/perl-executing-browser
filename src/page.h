/*
 Perl Executing Browser QtWebEngine

 This program is free software;
 you can redistribute it and/or modify it under the terms of the
 GNU Lesser General Public License,
 as published by the Free Software Foundation;
 either version 3 of the License, or (at your option) any later version.
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY;
 without even the implied warranty of MERCHANTABILITY or
 FITNESS FOR A PARTICULAR PURPOSE.
 Dimitar D. Mitov, 2013 - 2024
 Valcho Nedelchev, 2014 - 2016
 https://github.com/ddmitov/perl-executing-browser
*/

#ifndef PAGE_H
#define PAGE_H

#include <QDebug>
#include <QJsonDocument>
#include <QJsonObject>
#include <QWebEnginePage>

#include "script-handler.h"

// ==============================
// WEB PAGE CLASS DEFINITION
// ==============================
class QPage : public QWebEnginePage
{
    Q_OBJECT

public slots:

    // Start Perl Script:
    void qStartScript(QString scriptObjectName)
    {
        QPage::runJavaScript(
            "JSON.stringify(" + scriptObjectName + ")",
            0,
            [=]
            (QVariant scriptSettings)
        {
            QJsonDocument scriptJsonDocument =
                QJsonDocument::fromJson(scriptSettings.toString().toUtf8());

            if (!scriptJsonDocument.isEmpty()) {
                QJsonObject scriptJsonObject = scriptJsonDocument.object();

                QScriptHandler *scriptHandler =
                        new QScriptHandler(scriptObjectName, scriptJsonObject);

                QObject::connect(
                    scriptHandler,
                    SIGNAL(displayScriptOutputSignal(QString, QString)),
                    this,
                    SLOT(qDisplayScriptOutputSlot(QString, QString))
                );
            }
        }
        );
    }

    // Perl script STDOUT slot:
    void qDisplayScriptOutputSlot(QString id, QString output)
    {
        QPage::runJavaScript(id + ".stdoutFunction('" + output + "')", 0);
    }

protected:

    // Navigation:
    bool acceptNavigationRequest(const QUrl &url,
                                 QWebEnginePage::NavigationType navType,
                                 bool isMainFrame
                                 ) override
    {
        Q_UNUSED(isMainFrame);

        // No access to web pages:
        if (url.scheme() != "file") {
            return false;
        }

        // Start Perl script
        // when pseudo link is clicked or
        // when form is submitted to a pseudo link:
        if (url.scheme() == "file" and url.fileName().contains(".script")) {
            if (navType == QWebEnginePage::NavigationTypeLinkClicked) {
                qStartScript(url.fileName().replace(".script", ""));

                return false;
            }

            if (navType == QWebEnginePage::NavigationTypeFormSubmitted) {
                qStartScript(url.fileName().replace(".script", ""));

                return false;
            }
        }

        return true;
    }

    // Redirect JavaScript console messages to the STDERR of PEB:
    virtual void javaScriptConsoleMessage(
            QWebEnginePage::JavaScriptConsoleMessageLevel level,
            const QString &message,
            int lineNumber,
            const QString &sourceID)
    override
    {
        if (level == QWebEnginePage::InfoMessageLevel) {
            qInfo() << sourceID
                    << "Line"
                    << lineNumber
                    << message;
        }

        if (level == QWebEnginePage::WarningMessageLevel) {
            qWarning() << sourceID
                       << "Line"
                       << lineNumber
                       << message;
        }

        if (level == QWebEnginePage::ErrorMessageLevel) {
            qDebug() << sourceID
                     << "Line"
                     << lineNumber
                     << message;
        }
    }

    // Disable JavaScript Alert:
    virtual void javaScriptAlert(const QUrl &url, const QString &msg)
    override
    {
        Q_UNUSED(url);
        Q_UNUSED(msg);

        qInfo() << "JavaScript Alert is disabled.";
    }

    // Disable JavaScript Confirm:
    virtual bool javaScriptConfirm(const QUrl &url, const QString &msg)
    override
    {
        Q_UNUSED(url);
        Q_UNUSED(msg);

        qInfo() << "JavaScript Confirm is disabled.";

        return false;
    }

    // Disable JavaScript Prompt:
    virtual bool javaScriptPrompt(const QUrl &url,
                                  const QString &msg,
                                  const QString &defaultValue,
                                  QString *result)
    override
    {
        Q_UNUSED(url);
        Q_UNUSED(msg);
        Q_UNUSED(defaultValue);
        Q_UNUSED(result);

        qInfo() << "JavaScript Prompt is disabled.";

        return false;
    }

public:

    QPage();

};

#endif // PAGE_H
