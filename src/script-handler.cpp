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

#include <QJsonObject>
#include <QDebug>
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

    if (scriptJsonObject["scriptRelativePath"].toString().length() > 0) {
        scriptFullFilePath =
                qApp->property("application").toString() + "/" +
                scriptJsonObject["scriptRelativePath"].toString();
    }

    QFile file(scriptFullFilePath);
    if (!file.exists()) {
        qDebug() << "File not found:" << scriptFullFilePath;
        return;
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

    scriptProcess.setWorkingDirectory(qApp->property("application").toString());

    scriptProcess.start((qApp->property("perlInterpreter").toString()),
                        QStringList()
                        << scriptFullFilePath,
                        QProcess::Unbuffered | QProcess::ReadWrite);
}
