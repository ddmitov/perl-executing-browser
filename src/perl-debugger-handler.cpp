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

    QString scriptToDebugFilePath =
            QDir::toNativeSeparators(selectScriptToDebugDialog
                                     .getOpenFileName(
                                         qApp->activeWindow(),
                                         "Select Perl File",
                                         QDir::currentPath(),
                                         "Perl scripts (*.pl);;All files (*)"));

    selectScriptToDebugDialog.close();
    selectScriptToDebugDialog.deleteLater();

    if (scriptToDebugFilePath.length() > 1) {
        QString browserScriptMarker =
                QString("resources") + QDir::separator() + QString("app");
        QString commandLineArguments;

        // Get command-line arguments
        // if the debugged script is not a PEB-based Perl script
        if (!scriptToDebugFilePath.contains(browserScriptMarker)) {
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
        }

        qDebug() << QDateTime::currentMSecsSinceEpoch()
                 << "msecs from epoch: file passed to Perl debugger:"
                 << scriptToDebugFilePath;

        // Signal and slot for reading the Perl debugger output:
        QObject::connect(&debuggerHandler, SIGNAL(readyReadStandardOutput()),
                         this, SLOT(qDebuggerOutputSlot()));

        // Sеt the environment for the debugged script:
        QProcessEnvironment systemEnvironment =
                QProcessEnvironment::systemEnvironment();
        systemEnvironment.insert("PERLDB_OPTS", "ReadLine=0");
        debuggerHandler.setProcessEnvironment(systemEnvironment);

        // Set the working directory to the script directory
        // if the debugged script is not a PEB-based Perl script
        if (!scriptToDebugFilePath.contains(browserScriptMarker)) {
            QFileInfo scriptAbsoluteFilePath(scriptToDebugFilePath);
            QString scriptDirectory = scriptAbsoluteFilePath.absolutePath();
            debuggerHandler.setWorkingDirectory(scriptDirectory);
        }

        debuggerHandler.setProcessChannelMode(QProcess::MergedChannels);

        debuggerHandler.start(qApp->property("perlInterpreter")
                              .toString(),
                              QStringList()
                              << "-d"
                              << scriptToDebugFilePath
                              << commandLineArguments,
                              QProcess::Unbuffered
                              | QProcess::ReadWrite);
    }
}
