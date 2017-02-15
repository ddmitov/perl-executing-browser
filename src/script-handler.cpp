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

#include <QDir>
#include <QInputDialog>
#include <QLineEdit>
#include <QTimer>
#include <QUrl>
#include <QUrlQuery>

#include "script-handler.h"

// ==============================
// SCRIPT HANDLER CONSTRUCTOR:
// ==============================
QScriptHandler::QScriptHandler(QUrl url, QByteArray postDataArray)
    : QObject(0)
{
    // Signals and slots for local long running Perl scripts:
    QObject::connect(&scriptProcess, SIGNAL(readyReadStandardOutput()),
                     this, SLOT(qScriptOutputSlot()));
    QObject::connect(&scriptProcess, SIGNAL(readyReadStandardError()),
                     this, SLOT(qScriptErrorsSlot()));
    QObject::connect(&scriptProcess,
                     SIGNAL(finished(int, QProcess::ExitStatus)),
                     this,
                     SLOT(qScriptFinishedSlot()));

    QUrlQuery scriptQuery(url);

    scriptFullFilePath = QDir::toNativeSeparators
            ((qApp->property("application").toString()) + url.path());

    scriptStdoutTarget = scriptQuery.queryItemValue("stdout");
    scriptQuery.removeQueryItem("stdout");
    if (scriptStdoutTarget.length() > 0) {
        qDebug() << "Script STDOUT target:" << scriptStdoutTarget;
    }

    scriptUser = url.userName();

    if (scriptUser.length() > 0) {
        if (scriptUser == "interactive") {
            scriptId = url.password() + "@" + url.path();

            scriptCloseCommand =
                    scriptQuery.queryItemValue("close_command");
            if (scriptCloseCommand.length() == 0) {
                qDebug() << "Close command is not defined"
                         << "for interactive script:"
                         << scriptFullFilePath;
            }

            scriptCloseConfirmation =
                    scriptQuery.queryItemValue("close_confirmation");
            if (scriptCloseConfirmation.length() == 0) {
                qDebug() << "Close confirmation is not defined"
                         << "for interactive script:"
                         << scriptFullFilePath;
            }
        }
    }

    QString postData(postDataArray);

    QProcessEnvironment scriptEnvironment =
            QProcessEnvironment::systemEnvironment();

    if (scriptQuery.toString().length() > 0) {
        scriptEnvironment.insert("REQUEST_METHOD", "GET");
        scriptEnvironment.insert("QUERY_STRING", scriptQuery.toString());
        // qDebug() << "Query string:" << queryString;
    }

    if (postData.length() > 0) {
        scriptEnvironment.insert("REQUEST_METHOD", "POST");
        QString postDataSize = QString::number(postData.size());
        scriptEnvironment.insert("CONTENT_LENGTH", postDataSize);
        // qDebug() << "POST data:" << postData;
    }

    scriptProcess.setProcessEnvironment(scriptEnvironment);

    if (scriptUser != "root") {
        scriptProcess.start((qApp->property("perlInterpreter").toString()),
                            QStringList()
                            << scriptFullFilePath,
                            QProcess::Unbuffered | QProcess::ReadWrite);

        if (postData.length() > 0) {
            scriptProcess.write(postDataArray);
        }
    }

#ifdef Q_OS_LINUX
#if ADMIN_PRIVILEGES_CHECK == 0
    if (scriptUser == "root") {
        QString scriptCommadLineArgument;

        if (postData.length() > 0) {
            scriptCommadLineArgument = postData;
        }

        if (scriptQuery.toString().length() > 0) {
            scriptCommadLineArgument = scriptQuery.toString();
        }

//        scriptHandler.start(QString("pkexec"),
//                            QStringList()
//                            << qApp->property("perlInterpreter").toString()
//                            << scriptFullFilePath
//                            << scriptCommadLineArgument,
//                            QProcess::Unbuffered | QProcess::ReadWrite);

//        scriptHandler.start(QString("gksudo"),
//                            QStringList()
//                            << "-D"
//                            + qApp->applicationName().toLatin1()
//                            << "--"
//                            << qApp->property("perlInterpreter").toString()
//                            << scriptFullFilePath
//                            << scriptCommadLineArgument,
//                            QProcess::Unbuffered | QProcess::ReadWrite);

        if (qApp->property("rootPassword").toString().length() == 0) {
            bool ok;
            QString input =
                    QInputDialog::getText(
                        qApp->activeWindow(),
                        "Root Password",
                        "Please enter your Linux root password:",
                        QLineEdit::Password,
                        "",
                        &ok);

            if (ok && !input.isEmpty()) {
                qApp->setProperty("rootPassword", input);

                int maximumTimeMilliseconds = 300 * 1000 ;
                QTimer::singleShot(maximumTimeMilliseconds,
                                   this, SLOT(qRootPasswordTimeoutSlot()));
            }
        }

        if (qApp->property("rootPassword").toString().length() > 0) {
            QProcess echo;
            echo.setStandardOutputProcess(&scriptProcess);
            echo.start(QString("echo"),
                       QStringList()
                       << qApp->property("rootPassword").toString(),
                       QProcess::Unbuffered | QProcess::ReadWrite);
            echo.waitForFinished();
            echo.close();

            scriptProcess.start(QString("sudo"),
                                QStringList()
                                << "--stdin"
                                << "--prompt="
                                << "--"
                                << qApp->property("perlInterpreter").toString()
                                << scriptFullFilePath
                                << scriptCommadLineArgument,
                                QProcess::Unbuffered | QProcess::ReadWrite);
        }
    }
#endif
#endif

    qDebug() << QDateTime::currentMSecsSinceEpoch()
            << "msecs from epoch: script started:" << scriptFullFilePath;
}
