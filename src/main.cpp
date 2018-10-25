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
#include <QDateTime>
#include <QDebug>
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
// MESSAGE HANDLER FOR REDIRECTING
// PROGRAM MESSAGES TO A LOG FILE:
// ==============================
// Implementation of an idea proposed by Valcho Nedelchev.
void customMessageHandler(QtMsgType type,
                          const QMessageLogContext &context,
                          const QString &message)
{
    Q_UNUSED(context);
    QString dateAndTime =
            QDateTime::currentDateTime().toString("dd/MM/yyyy hh:mm:ss");
    QString text = QString("[%1] ").arg(dateAndTime);

    switch (type) {
#if QT_VERSION >= 0x050500
    case QtInfoMsg:
        text += QString("{Log} %1").arg(message);
        break;
#endif
    case QtDebugMsg:
        text += QString("{Log} %1").arg(message);
        break;
    case QtWarningMsg:
        text += QString("{Warning} %1").arg(message);
        break;
    case QtCriticalMsg:
        text += QString("{Critical} %1").arg(message);
        break;
    case QtFatalMsg:
        text += QString("{Fatal} %1").arg(message);
        abort();
        break;
    }

    // A separate log file is created for every browser session.
    // Application start date and time are appended to the binary file name.
    QFile logFile(qApp->property("logDirFullPath").toString()
                  + "/"
                  + QFileInfo(QApplication::applicationFilePath()).baseName()
                  + "-started-at-"
                  + qApp->property("applicationStartDateAndTime").toString()
                  + ".log");
    logFile.open(QIODevice::WriteOnly | QIODevice::Append | QIODevice::Text);
    QTextStream textStream(&logFile);
    textStream << text << endl;
}

// ==============================
// MAIN APPLICATION DEFINITION:
// ==============================
int main(int argc, char **argv)
{
    QApplication application(argc, argv);

    // ==============================
    // Application version:
    // ==============================
    application.setApplicationVersion("0.8.0");

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
    // Perl directory:
    // ==============================
    QString perlDirectory = browserDirectory + "/perl";

#ifdef Q_OS_LINUX
    // External 'perl' directory, if any,
    // takes precedence over embedded in an AppImage 'perl' directory:
    if (appImageDirectory.length() > 0) {
        perlDirectory = appImageDirectory + "/perl";
    }
#endif

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
    // Resources directory:
    // ==============================
    QString resourcesDirectory = browserDirectory + "/resources";

#ifdef Q_OS_LINUX
    // External 'resources' directory, if any,
    // takes precedence over embedded in an AppImage 'resources' directory:
    if (appImageDirectory.length() > 0) {
        resourcesDirectory = appImageDirectory + "/resources";
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
    // Logging:
    // ==============================
    // If 'logs' directory is found in the resources directory,
    // all program messages will be redirected to log files,
    // otherwise no log files will be created and
    // program messages may be seen inside Qt Creator during development.

    QString logDirFullPath = resourcesDirectory + "/logs";

    QDir logDir(logDirFullPath);
    if (logDir.exists()) {
        application.setProperty("logDirFullPath", logDirFullPath);

        // Application start date and time for logging:
        QString applicationStartDateAndTime =
                QDateTime::currentDateTime().toString("yyyy-MM-dd--hh-mm-ss");
        application.setProperty("applicationStartDateAndTime",
                                applicationStartDateAndTime);

        // Install message handler for redirecting all messages to a log file:
        qInstallMessageHandler(customMessageHandler);
    }

    // ==============================
    // MAIN WINDOW INITIALIZATION:
    // ==============================
    QMainBrowserWindow mainWindow;

    // Application property necessary when
    // closing the browser window is requested using
    // the special window closing URL.
    qApp->setProperty("windowCloseRequested", false);

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
    // Basic program information:
    // ==============================
    qDebug() << "Application path:" << application.applicationFilePath();
    qDebug() << "Application version:"
             << application.applicationVersion().toLatin1().constData();
    qDebug() << "Qt version:" << QT_VERSION_STR;
    qDebug() << "Perl interpreter:" << perlInterpreter;

    // ==============================
    // Window initialization:
    // ==============================
    mainWindow.setWindowIcon(icon);
    mainWindow.setCentralWidget(mainWindow.webViewWidget);

    // ==============================
    // Entry point:
    // ==============================
    bool startFileFound = false;

    QString startPageFilePath = applicationDirName + "/index.html";

    QString localServerSettingsFilePath =
             applicationDirName + "/local-server.json";

    QFile startPageFile(startPageFilePath);
    QFile localServerSettingsFile(localServerSettingsFilePath);

    // Static start page:
    if (startPageFile.exists()) {
        startFileFound = true;

        mainWindow.webViewWidget->setUrl(
                    QUrl::fromLocalFile(startPageFilePath));
        mainWindow.showMaximized();
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
                qDebug() << "Local server full path:"
                         << localServerFullPath;
            } else {
                mainWindow.qDisplayError(
                            QString("Local server file is not found."));
                qDebug() << "Local server file is not found.";
            }

            // Local server port:
            QJsonArray ports = localServerJson["ports"].toArray();

            qint16 firstPort = ports[0].toInt();
            qint16 lastPort = ports[1].toInt();

            if (firstPort == 0) {
                localServerSettingsCorrect = false;
                mainWindow.qDisplayError(
                            QString("No local server port is set."));
                qDebug() << "No local server port is set.";
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
                    qDebug() << "Local server port:" << port;
                }

                if (portScanner->portScannerError.length() > 0) {
                    mainWindow.qDisplayError(
                                portScanner->portScannerError);
                    qDebug() << "Port error:"
                             << portScanner->portScannerError;
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
                qDebug() << "Local server shutdown command:" << shutdownCommand;
            }
        }

        if (localServerSettingsCorrect == false) {
            mainWindow.qDisplayError(
                        localServerSettingsFilePath + "<br>" +
                        "is empty or malformed.");
            qDebug() << localServerSettingsFilePath
                     << " is empty or malformed.";
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

    // No entry point:
    if (startFileFound == false) {
        mainWindow.qDisplayError(
                    QString("No start page or local server is found."));
        qDebug() << "No start page or local server is found.";
    }

    return application.exec();
}
