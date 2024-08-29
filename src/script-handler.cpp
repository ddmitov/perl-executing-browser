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

#include <QApplication>
#include <QJsonObject>
#include <QRegularExpressionMatchIterator>

#include "script-handler.h"

// ==============================
// SCRIPT HANDLER CONSTRUCTOR
// ==============================
QScriptHandler::QScriptHandler(QString scriptId, QJsonObject scriptJsonObject)
    : QObject(0)
{
    // Script ID:
    id = scriptId;

    // Script full path:
    QString scriptFullFilePath =
            qApp->property("appDir").toString() + "/" +
            scriptJsonObject["scriptRelativePath"].toString();

    // Signals and slots for script STDOUT and STDERR:
    QObject::connect(
        &process,
        SIGNAL(readyReadStandardOutput()),
        this,
        SLOT(qScriptOutputSlot())
    );

    QObject::connect(
        &process,
        SIGNAL(readyReadStandardError()),
        this,
        SLOT(qScriptErrorsSlot())
    );

    // Script working directory:
    process.setWorkingDirectory(qApp->property("appDir").toString());

    // Perl interpreter:
    QString perlInterpreterSetting =
            scriptJsonObject["perlInterpreter"].toString();

    QString perlInterpreter;

    if (perlInterpreterSetting.length() > 0) {
        perlInterpreter =
            qApp->property("appDir").toString() + '/' +
            scriptJsonObject["perlInterpreter"].toString();
    }

    if (perlInterpreterSetting.length() == 0) {
        perlInterpreter = "perl";
    }

    // Start script:
    process.start(
        perlInterpreter,
        QStringList() << scriptFullFilePath,
        QProcess::Unbuffered | QProcess::ReadWrite
    );

    // Get script input, if any:
    QString scriptInput = scriptJsonObject["scriptInput"].toString();

    // Define regular expressions for file and directory selection tags:
    QStringList tags;

    tags.append("(\\{\"(existing-file)\":\"([a-zA-Z0-9\\s]{1,})\"\\})");
    tags.append("(\\{\"(new-file)\":\"([a-zA-Z0-9\\s]{1,})\"\\})");
    tags.append("(\\{\"(directory)\":\"([a-zA-Z0-9\\s]{1,})\"\\})");

    // Process script input, if any:
    if (scriptInput.length() > 0) {
        // Replace file and directory selection tags
        // with user-selected files and directories:
        foreach (QString tag, tags) {
            QRegularExpression tagRegExp(tag);

            QRegularExpressionMatchIterator regExpIterator =
                    tagRegExp.globalMatch(scriptInput);

            while (regExpIterator.hasNext()) {
                QRegularExpressionMatch match = regExpIterator.next();

                QString extractedTag = match.captured(1);
                QString inputType    = match.captured(2);
                QString dialogTitle  = match.captured(3);

                QString replacement = displayInodeDialog(
                    inputType,
                    dialogTitle
                );

                scriptInput.replace(
                    scriptInput.indexOf(extractedTag),
                    extractedTag.size(),
                    replacement
                );
            }
        }

        // Write script input to script STDIN:
        if (process.isOpen()) {
            process.write(scriptInput.toUtf8());
            process.write(QString("\n").toLatin1());
        }
    }
}
