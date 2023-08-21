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

#include <QJsonObject>

#include "script_handler.h"

// ==============================
// SCRIPT HANDLER CONSTRUCTOR:
// ==============================

QScriptHandler::QScriptHandler(QJsonObject scriptJsonObject)
    : QObject(0)
{
    scriptFullFilePath =
        qApp->property("appDir").toString()
        + "/"
        + scriptJsonObject["scriptRelativePath"].toString();

    QObject::connect(&process,
                     SIGNAL(readyReadStandardOutput()),
                     this,
                     SLOT(qScriptOutputSlot()));

    QObject::connect(&process,
                     SIGNAL(readyReadStandardError()),
                     this,
                     SLOT(qScriptErrorsSlot()));

    process.setWorkingDirectory(qApp->property("appDir").toString());

    process.start((qApp->property("perlInterpreter").toString()),
                  QStringList() << scriptFullFilePath,
                  QProcess::Unbuffered | QProcess::ReadWrite);
}
