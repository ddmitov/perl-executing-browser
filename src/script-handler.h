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

#ifndef SCRIPTHANDLER_H
#define SCRIPTHANDLER_H

#include <QApplication>
#include <QDateTime>
#include <QDebug>
#include <QProcess>

// ==============================
// SCRIPT HANDLER:
// ==============================
class QScriptHandler : public QObject
{
    Q_OBJECT

signals:
    void displayScriptOutputSignal(QString output, QString scriptStdoutTarget);
    void scriptFinishedSignal(QString scriptAccumulatedOutput,
                              QString scriptAccumulatedErrors,
                              QString scriptId,
                              QString scriptFullFilePath,
                              QString scriptStdoutTarget);

public slots:
    void qScriptOutputSlot()
    {
        QString output = scriptProcess.readAllStandardOutput();
        scriptAccumulatedOutput.append(output);

        qDebug() << QDateTime::currentMSecsSinceEpoch()
                << "msecs from epoch: output from" << scriptFullFilePath;

        // Handling 'script closed' confirmation:
        if (output == scriptCloseConfirmation) {
            qDebug() << QDateTime::currentMSecsSinceEpoch()
                    << "msecs from epoch:"
                    << "interactive script terminated normally:"
                    << scriptFullFilePath;
        } else {
            if (scriptStdoutTarget.length() > 0) {
                emit displayScriptOutputSignal(output, scriptStdoutTarget);
            }
        }
    }

    void qScriptErrorsSlot()
    {
        QString scriptErrors = scriptProcess.readAllStandardError();
        scriptAccumulatedErrors.append(scriptErrors);
        scriptAccumulatedErrors.append("\n");

        qDebug() << QDateTime::currentMSecsSinceEpoch()
                << "msecs from epoch: errors from" << scriptFullFilePath;
        // qDebug() << "Script errors:" << scriptErrors;
    }

    void qScriptFinishedSlot()
    {
        emit scriptFinishedSignal(scriptAccumulatedOutput,
                                  scriptAccumulatedErrors,
                                  scriptId,
                                  scriptFullFilePath,
                                  scriptStdoutTarget);

        scriptProcess.close();

        qDebug() << QDateTime::currentMSecsSinceEpoch()
                << "msecs from epoch: script finished:" << scriptFullFilePath;
    }

    void qRootPasswordTimeoutSlot()
    {
        qApp->setProperty("rootPassword", "");
    }

public:
    QScriptHandler(QUrl url, QByteArray postDataArray);
    QString scriptId;
    QString scriptFullFilePath;
    QProcess scriptProcess;
    QString scriptAccumulatedOutput;
    QString scriptAccumulatedErrors;
    QString scriptCloseCommand;
    QString scriptCloseConfirmation;

private:
    QString scriptStdoutTarget;
    QString scriptUser;
};

#endif // SCRIPTHANDLER_H
