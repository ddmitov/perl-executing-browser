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

#include "perl-debugger-handler.h"

// ==============================
// PERL DEBUGGER HANDLER CLASS CONSTRUCTOR:
// Implementation of an idea proposed by Valcho Nedelchev
// ==============================
QPerlDebuggerHandler::QPerlDebuggerHandler()
    : QObject(0)
{
    // Select a Perl script for debugging:
    QFileDialog selectScriptToDebugDialog(qApp->activeWindow());
    selectScriptToDebugDialog
            .setFileMode(QFileDialog::ExistingFile);
    selectScriptToDebugDialog
            .setViewMode(QFileDialog::Detail);
    selectScriptToDebugDialog
            .setWindowModality(Qt::WindowModal);

    QString scriptToDebug = selectScriptToDebugDialog
            .getOpenFileName
            (qApp->activeWindow(), "Select Perl File",
             QDir::currentPath(), "Perl scripts (*.pl);;All files (*)");

    selectScriptToDebugDialog.close();
    selectScriptToDebugDialog.deleteLater();

    QString commandLineArguments;

    if (scriptToDebug.length() > 1) {
        scriptToDebug = QDir::toNativeSeparators(scriptToDebug);

        // Get all command-line arguments for the debugged Perl script:
        bool ok;
        QString input =
                QInputDialog::getText(
                    qApp->activeWindow(),
                    "Command Line",
                    "Enter all command line arguments, if any:",
                    QLineEdit::Normal,
                    "",
                    &ok);

        if (ok && !input.isEmpty()) {
            commandLineArguments = input;
        }

        qDebug() << QDateTime::currentMSecsSinceEpoch()
                 << "msecs from epoch: file passed to Perl debugger:"
                 << scriptToDebug;
    }

    // Signal and slot for reading the Perl debugger output:
    QObject::connect(&debuggerHandler, SIGNAL(readyReadStandardOutput()),
                     this, SLOT(qDebuggerOutputSlot()));

    // Sеt the environment for the debugged script:
    QProcessEnvironment systemEnvironment =
            QProcessEnvironment::systemEnvironment();
    systemEnvironment.insert("PERLDB_OPTS", "ReadLine=0");
    debuggerHandler.setProcessEnvironment(systemEnvironment);

    QFileInfo scriptAbsoluteFilePath(scriptToDebug);
    QString scriptDirectory = scriptAbsoluteFilePath.absolutePath();
    debuggerHandler.setWorkingDirectory(scriptDirectory);

    debuggerHandler.setProcessChannelMode(QProcess::MergedChannels);

    debuggerHandler.start(qApp->property("perlInterpreter")
                          .toString(),
                          QStringList()
                          << "-d"
                          << scriptToDebug
                          << commandLineArguments,
                          QProcess::Unbuffered
                          | QProcess::ReadWrite);
}
