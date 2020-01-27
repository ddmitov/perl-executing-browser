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
 Dimitar D. Mitov, 2013 - 2020
 Valcho Nedelchev, 2014 - 2016
 https://github.com/ddmitov/perl-executing-browser
*/

#include <QtWidgets/QApplication>
#include <QTextCodec>
#include <QtGlobal>

#include "webkit-main-window.h"

// ==============================
// MAIN APPLICATION DEFINITION:
// ==============================
int main(int argc, char **argv)
{
    QApplication application(argc, argv);

    // ==============================
    // Application version:
    // ==============================
    application.setApplicationVersion("1.1.1");

    // ==============================
    // UTF-8 encoding application-wide:
    // ==============================
    QTextCodec::setCodecForLocale(QTextCodec::codecForName("UTF8"));

    // ==============================
    // Directory of the browser executable:
    // ==============================
    QDir executableDirectory = application.applicationDirPath();
    QString browserDirectory = executableDirectory.absolutePath().toLatin1();

#ifdef Q_OS_LINUX
    QString appImageDirectory;
    QByteArray appImageEnvVariable = qgetenv("APPIMAGE");

    if (appImageEnvVariable.length() > 0) {
        appImageDirectory =
                QFileInfo(QString::fromLatin1(appImageEnvVariable)).path();
        browserDirectory = appImageDirectory;
    }
#endif

    application.setProperty("browserDir", browserDirectory);

    // ==============================
    // Application directory:
    // ==============================
    QString applicationDirName =
            executableDirectory.absolutePath().toLatin1() + "/resources/app";
    application.setProperty("appDir", applicationDirName);

    // ==============================
    // Application icon:
    // ==============================
    QString iconPathName = applicationDirName + "/app.png";

    QPixmap icon(32, 32);
    QFile iconFile(iconPathName);
    if (iconFile.exists()) {
        icon.load(iconPathName);
        QApplication::setWindowIcon(icon);
    } else {
        // Set the embedded default icon in case no external icon file is found:
        icon.load(":/icon/camel.png");
        QApplication::setWindowIcon(icon);
    }

    // ==============================
    // MAIN WINDOW INITIALIZATION:
    // ==============================
    QMainBrowserWindow mainWindow;
    mainWindow.setWindowIcon(icon);
    mainWindow.setCentralWidget(mainWindow.webViewWidget);

    // Application property used when closing the browser window is requested:
    qApp->setProperty("windowCloseRequested", false);

    // ==============================
    // Signals and slots:
    // ==============================
    // Signal and slot for setting the main window title:
    QObject::connect(mainWindow.webViewWidget,
                     SIGNAL(titleChanged(QString)),
                     &mainWindow,
                     SLOT(setMainWindowTitleSlot(QString)));

    // Signal and slot for closing the main window:
    QObject::connect(&mainWindow,
                     SIGNAL(startMainWindowClosingSignal()),
                     mainWindow.webViewWidget->page(),
                     SLOT(qStartWindowClosingSlot()));

    // ==============================
    // Start page:
    // ==============================
    QString startPageFilePath = applicationDirName + "/index.html";
    QFile startPageFile(startPageFilePath);

    if (startPageFile.exists()) {
        mainWindow.webViewWidget->setUrl(
                    QUrl::fromLocalFile(startPageFilePath));
    }

    if (!startPageFile.exists()) {
        mainWindow.qDisplayErrorSlot(QString("No start page is found."));
    }

    return application.exec();
}
