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

#ifndef SCRIPT_HANDLER_H
#define SCRIPT_HANDLER_H

#include <QApplication>
#include <QProcess>

// ==============================
// SCRIPT HANDLER:
// ==============================

class QScriptHandler : public QObject
{
    Q_OBJECT

signals:

    void displayScriptOutputSignal(QString id, QString output);
    void displayScriptErrorsSignal(QString errors);

public slots:

    void qScriptOutputSlot()
    {
        QString scriptOutput = process.readAllStandardOutput();
        emit displayScriptOutputSignal(this->id, scriptOutput);
    }

    void qScriptErrorsSlot()
    {
        QString scriptErrors = process.readAllStandardError();
        emit displayScriptErrorsSignal(scriptErrors);
    }

private:

    QString scriptFullFilePath;

public:

    QScriptHandler(QJsonObject);
    QProcess process;
    QString id;
};

#endif // SCRIPT_HANDLER_H
