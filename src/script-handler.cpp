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

#include <QJsonObject>
#include <QDir>

#include "script-handler.h"

// ==============================
// SCRIPT HANDLER CONSTRUCTOR:
// ==============================
QScriptHandler::QScriptHandler(QJsonObject scriptJsonObject)
    : QObject(0)
{
    if (scriptJsonObject.length() == 1) {
        qDebug() << "No script settings!";
        return;
    }

    scriptId = scriptJsonObject["id"].toString();

    if (scriptJsonObject["scriptFullPath"].toString().length() > 0) {
        scriptFullFilePath = scriptJsonObject["scriptFullPath"].toString();
        scriptFullFilePath.replace("{app}",
                                   qApp->property("application").toString());
        scriptFullFilePath = QDir::toNativeSeparators(scriptFullFilePath);
    }

    QFile file(scriptFullFilePath);
    if (!file.exists()) {
        qDebug() << "File not found:" << scriptFullFilePath;
        return;
    }

    QString requestMethod;
    if (scriptJsonObject["requestMethod"].toString().length() > 0) {
        requestMethod = scriptJsonObject["requestMethod"].toString();
    }

    QString inputData;
    if (scriptJsonObject["inputData"].toString().length() > 0) {
        inputData = scriptJsonObject["inputData"].toString();
    }

    if (scriptJsonObject["scriptExitCommand"].toString().length() > 0) {
        scriptExitCommand = scriptJsonObject["scriptExitCommand"].toString();
    }

    if (scriptJsonObject["scriptExitConfirmation"].toString().length() > 0) {
        scriptExitConfirmation =
                scriptJsonObject["scriptExitConfirmation"].toString();
    }

    // Signals and slots for local long running Perl scripts:
    QObject::connect(&scriptProcess, SIGNAL(readyReadStandardOutput()),
                     this, SLOT(qScriptOutputSlot()));
    QObject::connect(&scriptProcess, SIGNAL(readyReadStandardError()),
                     this, SLOT(qScriptErrorsSlot()));
    QObject::connect(&scriptProcess,
                     SIGNAL(finished(int, QProcess::ExitStatus)),
                     this,
                     SLOT(qScriptFinishedSlot()));

    QProcessEnvironment scriptEnvironment =
            QProcessEnvironment::systemEnvironment();

    if (requestMethod == "GET") {
        scriptEnvironment.insert("REQUEST_METHOD", "GET");
        scriptEnvironment.insert("QUERY_STRING", inputData);
    }

    if (requestMethod == "POST") {
        scriptEnvironment.insert("REQUEST_METHOD", "POST");
        scriptEnvironment.insert("CONTENT_LENGTH",
                                 QString::number(inputData.size()));
    }

    scriptProcess.setProcessEnvironment(scriptEnvironment);

    scriptProcess.setWorkingDirectory(qApp->property("application").toString());

    scriptProcess.start((qApp->property("perlInterpreter").toString()),
                        QStringList()
                        << scriptFullFilePath,
                        QProcess::Unbuffered | QProcess::ReadWrite);

    if (requestMethod == "POST") {
        QByteArray inputDataArray = inputData.toUtf8();
        inputDataArray.append(QString("\n").toLatin1());
        scriptProcess.write(inputDataArray);
    }

    qDebug()
            // << QDateTime::currentMSecsSinceEpoch()
            // << "msecs from epoch:"
            << "Script started:" << scriptFullFilePath;
}
