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

#ifndef PERLDEBUGGERHANDLER_H
#define PERLDEBUGGERHANDLER_H

#include <QApplication>
#include <QDateTime>
#include <QDebug>
#include <QDir>
#include <QFileDialog>
#include <QInputDialog>
#include <QProcess>
#include <QUrl>
#include <QUrlQuery>

// ==============================
// PERL DEBUGGER HANDLER CONSTRUCTOR:
// Implementation of an idea proposed by Valcho Nedelchev
// ==============================
class QPerlDebuggerHandler : public QObject
{
    Q_OBJECT

signals:
    void startDebuggerFormatterSignal(QUrl debuggerOutputFormatterUrl,
                                      QByteArray debuggerOutputArray);

public slots:
    void qHandleDebuggerSlot(QUrl url)
    {
        // Get a Perl debugger command:
        QUrlQuery scriptQuery(url);

        QString debuggerCommand = scriptQuery
                .queryItemValue("command", QUrl::FullyDecoded);
        debuggerCommand.replace("+", " ");

        if (debuggerHandler.isOpen()) {
            if (debuggerCommand.length() > 0) {
                qDebug() << QDateTime::currentMSecsSinceEpoch()
                         << "msecs from epoch: Perl debugger command:"
                         << debuggerCommand;

                QByteArray debuggerCommandArray;
                debuggerCommandArray.append(debuggerCommand.toLatin1());
                debuggerCommandArray.append(QString("\n").toLatin1());
                debuggerHandler.write(debuggerCommandArray);
            }
        }
    }

    void qDebuggerOutputSlot()
    {
        // Read debugger output:
        QString debuggerOutput = debuggerHandler.readAllStandardOutput();

        // Append last output of the debugger to
        // the accumulated debugger output:
        debuggerAccumulatedOutput.append(debuggerOutput);

        // qDebug() << QDateTime::currentMSecsSinceEpoch()
        //          << "msecs from epoch:"
        //          << "Perl debugger raw output:" << endl
        //          << debuggerOutput;

        // Formatting of Perl debugger output is started only after
        // the final command prompt comes out of the debugger:
        if (debuggerAccumulatedOutput.contains(QRegExp ("DB\\<\\d{1,5}\\>"))) {

            QString debuggerOutputFormatterFilePath =
                    "http://" +
                    QString(qApp->property("pseudoDomain").toString()) +
                    "/perl5dbgui/perl5dbgui.pl";

            QByteArray debuggerOutputArray;
            debuggerOutputArray.append(debuggerAccumulatedOutput.toLatin1());


            startDebuggerFormatterSignal(QUrl(debuggerOutputFormatterFilePath),
                                         debuggerOutputArray);

            // Clean any previous debugger output:
            debuggerAccumulatedOutput = "";
        }
    }
private:
    QProcess debuggerHandler;
    QString debuggerAccumulatedOutput;

public:
    QPerlDebuggerHandler();
};

#endif // PERLDEBUGGERHANDLER_H
