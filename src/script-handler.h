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

#ifndef SCRIPT_HANDLER_H
#define SCRIPT_HANDLER_H

#include <QApplication>
#include <QDebug>
#include <QFileDialog>
#include <QProcess>

// ==============================
// SCRIPT HANDLER
// ==============================
class QScriptHandler : public QObject
{
    Q_OBJECT

signals:

    void displayScriptOutputSignal(QString id, QString output);

public slots:

    // Filesystem dialogs:
    QString displayInodeDialog(QString inputType, QString dialogTitle)
    {
        QFileDialog inodesDialog(qApp->activeWindow());

        inodesDialog.setParent(qApp->activeWindow());
        inodesDialog.setOption(QFileDialog::DontUseNativeDialog);
        inodesDialog.setWindowModality(Qt::WindowModal);
        inodesDialog.setViewMode(QFileDialog::Detail);

        inodesDialog.setWindowTitle(dialogTitle);

        if (inputType == "existing-file") {
            inodesDialog.setFileMode(QFileDialog::AnyFile);
        }

        if (inputType == "new-file") {
            inodesDialog.setAcceptMode(QFileDialog::AcceptSave);
        }

        if (inputType == "directory") {
            inodesDialog.setFileMode(QFileDialog::Directory);
        }

        QString selectedInode;

        if (inodesDialog.exec()) {
            QStringList selectedInodes = inodesDialog.selectedFiles();

            if (selectedInodes.isEmpty()) {
                selectedInode = "";
            }

            if (!selectedInodes.isEmpty()) {
                selectedInode = selectedInodes[0];
            }
        }

        inodesDialog.close();
        inodesDialog.deleteLater();

        return selectedInode;
    }

    // Perl script STDOUT slot:
    void qScriptOutputSlot()
    {
        QString scriptOutput = process.readAllStandardOutput();

        emit displayScriptOutputSignal(this->id, scriptOutput);
    }

    // Perl script STDERR slot:
    void qScriptErrorsSlot()
    {
        QString scriptError = process.readAllStandardError();

        scriptError.replace("\"", " ");
        scriptError.replace("\n", " ");

        qDebug() << scriptError;
    }

private:

    QString id;

public:

    QScriptHandler(QString, QJsonObject);

    QProcess process;
};

#endif // SCRIPT_HANDLER_H
