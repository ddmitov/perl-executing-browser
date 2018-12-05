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

#include <QtWidgets/QApplication>
#include <QTextCodec>
#include <QtGlobal>

#include "port-scanner.h"

#if QT_VERSION < QT_VERSION_CHECK(5, 6, 0)
#include "webkit-main-window.h"
#endif

#if QT_VERSION > QT_VERSION_CHECK(5, 5, 0)
#if ANNULEN_QTWEBKIT == 0
#include "webengine-main-window.h"
#endif

#if ANNULEN_QTWEBKIT == 1
#include "webkit-main-window.h"
#endif
#endif

// ==============================
// MAIN APPLICATION DEFINITION:
// ==============================
int main(int argc, char **argv)
{
    QApplication application(argc, argv);

    // ==============================
    // Application version:
    // ==============================
    application.setApplicationVersion("0.9.0");

    // ==============================
    // UTF-8 encoding application-wide:
    // ==============================
    QTextCodec::setCodecForLocale(QTextCodec::codecForName("UTF8"));

    // ==============================
    // Directory of the browser executable:
    // ==============================
    QDir executableDirectory = application.applicationDirPath();

#ifdef Q_OS_MAC
    if (BUNDLE == 1) {
        executableDirectory.cdUp();
        executableDirectory.cdUp();
    }
#endif

    QString browserDirectory = executableDirectory.absolutePath().toLatin1();

#ifdef Q_OS_LINUX
    QString appImageDirectory;
    QByteArray appImageEnvVariable = qgetenv("APPIMAGE");

    if (appImageEnvVariable.length() > 0) {
        appImageDirectory =
                QFileInfo(QString::fromLatin1(appImageEnvVariable)).path();
    }
#endif

    // ==============================
    // Resources directory:
    // ==============================
    QString resourcesDirectory;

#ifndef Q_OS_LINUX
    resourcesDirectory = browserDirectory + "/resources";
#endif

#ifdef Q_OS_LINUX
    if (appImageDirectory.length() == 0) {
        resourcesDirectory = browserDirectory + "/resources";
    }

    if (appImageDirectory.length() > 0) {
        if (QDir(browserDirectory + "/resources").exists()) {
            resourcesDirectory = browserDirectory + "/resources";
        } else {
            resourcesDirectory = appImageDirectory + "/resources";
        }
    }
#endif

    // ==============================
    // Application directory:
    // ==============================
    QString applicationDirName = resourcesDirectory + "/app";

    application.setProperty("application", applicationDirName);

    // ==============================
    // Data directory:
    // ==============================
    QString dataDirName = resourcesDirectory + "/data";

    qputenv("PEB_DATA_DIR", dataDirName.toLatin1());

    // ==============================
    // Perl directory:
    // ==============================
    QString perlDirectory = applicationDirName + "/perl";

    // ==============================
    // Perl interpreter:
    // ==============================
    QString perlExecutable;

#ifndef Q_OS_WIN
    perlExecutable = "perl";
#endif

#ifdef Q_OS_WIN
    perlExecutable = "wperl.exe";
#endif

    QString perlInterpreter;

    QString privatePerlInterpreterFullPath =
                perlDirectory + "/bin/" + perlExecutable;

    if (QFile(privatePerlInterpreterFullPath).exists()) {
        perlInterpreter = privatePerlInterpreterFullPath;
    } else {
        // Perl on PATH is used if no private Perl interpreter is found:
        perlInterpreter = perlExecutable;
    }

    application.setProperty("perlInterpreter", perlInterpreter);

    // ==============================
    // PERL5LIB directory:
    // ==============================
    QString perlLibDirString = perlDirectory + "/lib";
    QByteArray perlLibDirArray = perlLibDirString.toLatin1();

    qputenv("PERL5LIB", perlLibDirArray);

    // ==============================
    // Application icon:
    // ==============================
    QString iconPathName = resourcesDirectory + "/app.png";

    QPixmap icon(32, 32);
    QFile iconFile(iconPathName);
    if (iconFile.exists()) {
        icon.load(iconPathName);
        QApplication::setWindowIcon(icon);
    } else {
        // Set the embedded default icon
        // in case no external icon file is found:
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

#if QT_VERSION >= QT_VERSION_CHECK(5, 6, 0)
    if (ANNULEN_QTWEBKIT == 0) {
        // Signal and slot for fullscreen video:
        QObject::connect(mainWindow.webViewWidget->page(),
                         SIGNAL(fullScreenRequested(QWebEngineFullScreenRequest)),
                         &mainWindow,
                         SLOT(qGoFullscreen(QWebEngineFullScreenRequest)));
    }
#endif

    // Signal and slot for closing the main window:
    QObject::connect(&mainWindow,
                     SIGNAL(startMainWindowClosingSignal()),
                     mainWindow.webViewWidget->page(),
                     SLOT(qStartWindowClosingSlot()));

    // Signal and slot for actions taken before application exit:
    QObject::connect(qApp, SIGNAL(aboutToQuit()),
                     &mainWindow, SLOT(qExitApplicationSlot()));

    // ==============================
    // Start file:
    // ==============================
    bool startFileFound = false;

    QString startPageFilePath = applicationDirName + "/index.html";

    QString localServerSettingsFilePath =
             applicationDirName + "/local-server.json";

    QFile startPageFile(startPageFilePath);
    QFile localServerSettingsFile(localServerSettingsFilePath);

    // Local file:
    if (startPageFile.exists()) {
        startFileFound = true;

        mainWindow.webViewWidget->setUrl(
                    QUrl::fromLocalFile(startPageFilePath));
    }

    // Local server:
    if ((!startPageFile.exists()) and localServerSettingsFile.exists()) {
        startFileFound = true;
        bool localServerSettingsCorrect = false;

        QString localServerFullPath;
        QString port;
        QStringList localServerCommandLine;

        QFileReader *localServerSettingsReader =
                new QFileReader(localServerSettingsFilePath);
        QString localServerSettings =
                localServerSettingsReader->fileContents;

        QJsonDocument localServerJsonDocument =
                QJsonDocument::fromJson(localServerSettings.toUtf8());

        QJsonObject localServerJson;

        if (!localServerJsonDocument.isNull()) {
            localServerJson = localServerJsonDocument.object();
            if (!localServerJson.isEmpty()) {
                localServerSettingsCorrect = true;
            }
        }

        if (localServerSettingsCorrect == true) {
            // Local server full path:
            QString localServerFullPathSetting =
                    applicationDirName + "/" +
                    localServerJson["file"].toString();

            QFile localServerFile(localServerFullPathSetting);

            if (localServerFile.exists()) {
                localServerFullPath = localServerFullPathSetting;
                localServerCommandLine.append(localServerFullPath);
            } else {
                mainWindow.qDisplayError(
                            QString("Local server file is not found."));
            }

            // Local server port:
            QJsonArray ports = localServerJson["ports"].toArray();

            qint16 firstPort = ports[0].toInt();
            qint16 lastPort = ports[1].toInt();

            if (firstPort == 0) {
                localServerSettingsCorrect = false;
                mainWindow.qDisplayError(
                            QString("No local server port is set."));
            }

            if (firstPort > 0) {
                if (lastPort == 0) {
                    lastPort = firstPort;
                }

                QPortScanner *portScanner =
                        new QPortScanner(firstPort, lastPort);

                if (portScanner->portScannerError.length() == 0) {
                    port = QString::number(portScanner->port);
                    application.setProperty("port", port);
                }

                if (portScanner->portScannerError.length() > 0) {
                    mainWindow.qDisplayError(
                                portScanner->portScannerError);
                }
            }

            // Local server command line arguments.
            // Local server port must be defined at this point!
            QJsonArray commandLineArgumentsArray =
                    localServerJson["command-line-arguments"].toArray();
            foreach (QVariant argument, commandLineArgumentsArray) {
                QString argumentString = argument.toString();
                argumentString.replace("#PORT#", port);
                localServerCommandLine.append(argumentString);
            }

            // Local server shutdown command:
            QString shutdownCommand =
                    localServerJson["shutdown_command"].toString();
            if (shutdownCommand.length() > 0) {;
                application.setProperty("shutdown_command", shutdownCommand);
            }
        }

        if (localServerSettingsCorrect == false) {
            mainWindow.qDisplayError(
                        localServerSettingsFilePath + "<br>" +
                        "is empty or malformed.");
        }

        // Local server has to be started as
        // a detached process for its proper operation:
        if (localServerSettingsCorrect == true) {
            QProcess localServer;
            localServer.startDetached (
                        qApp->property("perlInterpreter").toString(),
                        localServerCommandLine);

            // Local server is pinged every second until ready,
            // but after 5 seconds of being unaivailable,
            // a timeout message is displayed.
            // If local server is up and running for less than 5 seconds,
            // its index page is loaded.
            mainWindow.localServerTester = new QTimer();
            QObject::connect(mainWindow.localServerTester, SIGNAL (timeout()),
                             &mainWindow, SLOT(qLocalServerPingSlot()));
            mainWindow.localServerTester->start(1000);
        }
    }

    // No start file:
    if (startFileFound == false) {
        mainWindow.qDisplayError(
                    QString("No start page or local server is found."));
    }

    return application.exec();
}
