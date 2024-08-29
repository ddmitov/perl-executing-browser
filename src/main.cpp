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
#include <QTextCodec>
#include <QtGlobal>

#include "window.h"

// ==============================
// APPLICATION DEFINITION
// ==============================
int main(int argc, char **argv)
{
    QApplication application(argc, argv);

    application.setApplicationName("Perl Executing Browser");
    application.setApplicationVersion("2.0.0");

    // UTF-8 encoding application-wide:
    QTextCodec::setCodecForLocale(QTextCodec::codecForName("UTF8"));

    // Command-line argument:
    const QStringList arguments = QCoreApplication::arguments();

    // Application directory:
    QString applicationDirectoryPath;

    if (arguments.length() > 1) {
        QFileInfo applicationDirectoryArgument(arguments.at(1));

        if (applicationDirectoryArgument.isRelative()){
            applicationDirectoryPath = QDir::currentPath() + "/app";
        }

        if (!applicationDirectoryArgument.isRelative()){
            applicationDirectoryPath = arguments.at(1);
        }

    } else {
        applicationDirectoryPath = QDir::currentPath() + "/app";
    }

    application.setProperty("appDir", applicationDirectoryPath);

    // Application icon:
    QString iconPathName = applicationDirectoryPath + "/app.png";

    QPixmap icon(32, 32);
    QFile iconFile(iconPathName);

    if (iconFile.exists()) {
        icon.load(iconPathName);
        QApplication::setWindowIcon(icon);
    } else {
        // Use the embedded default icon if no external icon file is found:
        icon.load(":/camel.png");

        application.setWindowIcon(icon);
    }

    // Start page:
    QString startPageFilePath = applicationDirectoryPath + "/index.html";
    QFile startPageFile(startPageFilePath);

    if (startPageFile.exists()) {
        QMainBrowserWindow mainWindow;

        mainWindow.mainViewWidget->setUrl(
            QUrl::fromLocalFile(startPageFilePath)
        );

        return application.exec();
    }

    if (!startPageFile.exists()) {
        QMessageBox msgBox;

        msgBox.setWindowTitle("Perl Executing Browser");
        msgBox.setText("No Perl Executing Browser start page is found.");
        msgBox.exec();

        application.exit();
    }
}
