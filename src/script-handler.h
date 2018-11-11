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

#ifndef SCRIPTHANDLER_H
#define SCRIPTHANDLER_H

#include <QApplication>
#include <QProcess>

// ==============================
// SCRIPT HANDLER:
// ==============================
class QScriptHandler : public QObject
{
    Q_OBJECT

signals:
    void displayScriptOutputSignal(QString scriptId,
                                   QString output);
    void scriptFinishedSignal(QString scriptId,
                              QString scriptFullFilePath,
                              QString scriptAccumulatedErrors);

public slots:
    void qScriptOutputSlot()
    {
        QString output = scriptProcess.readAllStandardOutput();
        scriptAccumulatedOutput.append(output);

        emit displayScriptOutputSignal(scriptId, output);
    }

    void qScriptErrorsSlot()
    {
        QString scriptErrors = scriptProcess.readAllStandardError();
        scriptAccumulatedErrors.append(scriptErrors);
        scriptAccumulatedErrors.append("\n");
    }

    void qScriptFinishedSlot()
    {
        emit scriptFinishedSignal(scriptId,
                                  scriptFullFilePath,
                                  scriptAccumulatedErrors);

        scriptProcess.close();
    }

public:
    QScriptHandler(QJsonObject);
    QProcess scriptProcess;
    QString scriptId;
    QString scriptFullFilePath;
    QString scriptAccumulatedOutput;
    QString scriptAccumulatedErrors;
};

#endif // SCRIPTHANDLER_H
