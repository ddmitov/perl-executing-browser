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

#include <QApplication>
#include <QDateTime>
#include <QDebug>
#include <QTextCodec>
#include <QtGlobal>
#include <QtWidgets>

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
    QFile logFile(QDir::toNativeSeparators
                  (qApp->property("logDirFullPath").toString()
                   + QDir::separator()
                   + QFileInfo(QApplication::applicationFilePath()).baseName()
                   + "-started-at-"
                   + qApp->property("applicationStartDateAndTime").toString()
                   + ".log"));
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
    application.setApplicationVersion("0.6.0");

    // ==============================
    // Basic program information:
    // ==============================
    qDebug() << "Application path:" << application.applicationFilePath();
    qDebug() << "Application version:"
             << application.applicationVersion().toLatin1().constData();
    qDebug() << "Qt version:" << QT_VERSION_STR;

    // ==============================
    // UTF-8 encoding application-wide:
    // ==============================
    QTextCodec::setCodecForLocale(QTextCodec::codecForName("UTF8"));

    // ==============================
    // Binary file directory:
    // ==============================
    QDir binaryDir = QDir::toNativeSeparators(application.applicationDirPath());

#ifdef Q_OS_LINUX
    QByteArray appImageEnvVariable = qgetenv("APPIMAGE");
    if (appImageEnvVariable.length() > 0) {
        QFileInfo appImageFileInfo =
                QFileInfo(QString::fromLatin1(appImageEnvVariable));
        binaryDir = appImageFileInfo.path();
    }
#endif

#ifdef Q_OS_MAC
    if (BUNDLE == 1) {
        binaryDir.cdUp();
        binaryDir.cdUp();
    }
#endif

    QString binaryDirName = binaryDir.absolutePath().toLatin1();

    // ==============================
    // Perl interpreter:
    // ==============================
    QString perlExecutable;

#ifndef Q_OS_WIN
    perlExecutable = "perl";
#endif

#ifdef Q_OS_WIN
    perlExecutable = "perl.exe";
#endif

    QString perlInterpreter;
    QString privatePerlInterpreterFullPath = QDir::toNativeSeparators(
                binaryDirName + QDir::separator()
                + "perl" + QDir::separator()
                + "bin" + QDir::separator()
                + perlExecutable);

    QFile privatePerlInterpreterFile(privatePerlInterpreterFullPath);
    if (!privatePerlInterpreterFile.exists()) {
        perlInterpreter = "perl";
    } else {
        perlInterpreter = privatePerlInterpreterFullPath;
    }

    application.setProperty("perlInterpreter", perlInterpreter);

    // ==============================
    // PERL5LIB directory:
    // ==============================
    QString perlLibDirString = QDir::toNativeSeparators(
                binaryDirName + QDir::separator()
                + "perl" + QDir::separator()
                + "lib");
    QByteArray perlLibDirArray = perlLibDirString.toLatin1();

    qputenv("PERL5LIB", perlLibDirArray);

    // ==============================
    // Application icon:
    // ==============================
    QString iconPathName = QDir::toNativeSeparators(
                binaryDirName + QDir::separator()
                + "resources" + QDir::separator()
                + "app.png");

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
    // Application directory:
    // ==============================
    QString applicationDirName = QDir::toNativeSeparators(
                binaryDirName + QDir::separator()
                + "resources" + QDir::separator()
                + "app");

    application.setProperty("application", applicationDirName);

    // ==============================
    // Data directory:
    // ==============================
    QString dataDirName = QDir::toNativeSeparators(
                binaryDirName + QDir::separator()
                + "resources" + QDir::separator()
                + "data");
    QByteArray dataDirNameArray = dataDirName.toLatin1();

    qputenv("PEB_DATA_DIR", dataDirNameArray);

    // ==============================
    // Logging:
    // ==============================
    // If 'logs' directory is found in the directory of the browser binary,
    // all program messages will be redirected to log files,
    // otherwise no log files will be created and
    // program messages could be seen inside Qt Creator.
    QString logDirFullPath = binaryDirName + QDir::separator() + "logs";
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
    // Missing Perl interpreter error message:
    // ==============================
    if (perlInterpreter.length() == 0) {
        QFileReader *resourceReader =
                new QFileReader(QString(":/html/error.html"));
        QString htmlErrorContents = resourceReader->fileContents;

        QString errorMessage = privatePerlInterpreterFullPath + "<br>"
                + "is not found and "
                + "no Perl interpreter is available on PATH.";
        htmlErrorContents.replace("ERROR_MESSAGE", errorMessage);

        mainWindow.webViewWidget->setHtml(htmlErrorContents);

        qDebug() << "No Perl interpreter is found.";
    }

    if (perlInterpreter.length() > 0) {
        qDebug() << "Perl interpreter:" << perlInterpreter;

        // ==============================
        // Entry point:
        // ==============================
        mainWindow.setWindowIcon(icon);
        mainWindow.setCentralWidget(mainWindow.webViewWidget);

        bool startFileFound = false;

        QString startPageFilePath =
                applicationDirName + QDir::separator() + "index.html";
        QString localServerSettingsFilePath =
                applicationDirName + QDir::separator() + "local-server.json";

        QFile startPageFile(startPageFilePath);
        QFile localServerSettingsFile(localServerSettingsFilePath);

        // Static start page:
        if (startPageFile.exists()) {
            startFileFound = true;
            QString startPage = "file://" + startPageFilePath;

            mainWindow.webViewWidget->setUrl(QUrl(startPage));
            mainWindow.showMaximized();
        }

        // Local server:
        if ((!startPageFile.exists()) and localServerSettingsFile.exists()) {
            startFileFound = true;

            QString localServerFullPath;
            QString port;
            QStringList localServerCommandLine;

            QFileReader *localServerSettingsReader =
                    new QFileReader(localServerSettingsFilePath);
            QString localServerSettings =
                    localServerSettingsReader->fileContents;

            QJsonDocument localServerJsonDocument =
                QJsonDocument::fromJson(localServerSettings.toUtf8());

            if (!localServerJsonDocument.isNull()) {
                QJsonObject localServerJson =
                    localServerJsonDocument.object();

                if (!localServerJson.isEmpty()) {
                    // Local server full path:
                    QString localServerFullPathSetting =
                            applicationDirName + QDir::separator() +
                            localServerJson["filename"].toString();

                    QFile localServerFile(localServerFullPathSetting);

                    if (!localServerFile.exists()) {
                        mainWindow.qDisplayError(
                                    QString("Local server file is not found."));
                        qDebug() << "Local server file is not found.";
                    }

                    if (localServerFile.exists()) {
                        localServerFullPath = localServerFullPathSetting;
                        localServerCommandLine.append(localServerFullPath);
                        qDebug() << "Local server full path:"
                                 << localServerFullPath;
                    }

                    // Local server port
                    // Single port:
                    if (!localServerJson["port"].toString().contains("-")) {
                        QPortScanner *portScanner =
                                new QPortScanner(
                                    localServerJson["port"].toInt(),
                                    localServerJson["port"].toInt());

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

                    // Port range:
                    if (localServerJson["port"].toString().contains("-")) {
                        QStringList ports =
                                localServerJson["port"].toString().split("-");

                        qint16 startPort = ports.takeFirst().toInt();
                        qint16 endPort = ports.takeLast().toInt();

                        QPortScanner *portScanner =
                                new QPortScanner(startPort, endPort);

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

                    if (port.length() > 0) {
                        // Local server command line arguments.
                        // Local server port must be defined at this point!
                        QJsonArray commandLineArgumentsArray =
                                localServerJson["command-line-arguments"]
                                .toArray();
                        foreach (QVariant argument, commandLineArgumentsArray) {
                            QString argumentString = argument.toString();
                            argumentString.replace("#PORT#", port);
                            localServerCommandLine.append(argumentString);
                        }

                        // Local server shutdown command:
                        QString shutdownCommand =
                                localServerJson["shutdown_command"].toString();
                        if (shutdownCommand.length() > 0) {;
                            application.setProperty("shutdown_command",
                                                    shutdownCommand);

                            qDebug() << "Local server shutdown command:"
                                     << shutdownCommand;
                        }
                    }
                }

                if (localServerJson.isEmpty()) {
                    mainWindow.qDisplayError(
                                localServerSettingsFilePath + "<br>" +
                                "is malformed.");
                    qDebug() << localServerSettingsFilePath
                             << " is malformed.";
                }
            }

            if (localServerJsonDocument.isNull()) {
                mainWindow.qDisplayError(
                            localServerSettingsFilePath + "<br>" +
                            "is empty.");
                qDebug() << localServerSettingsFilePath
                         << " is empty.";
            }

            // Local server has to be started as
            // a detached process for its proper operation:
            if (localServerFullPath.length() > 0 and port.length() > 0) {
                QProcess localServer;
                localServer.startDetached (
                            qApp->property("perlInterpreter").toString(),
                            localServerCommandLine);

                // Local server is pinged until ready.
                // Local server index page is loaded
                // only after local server is up and running.
                mainWindow.localServerTimer = new QTimer();
                QObject::connect(mainWindow.localServerTimer, SIGNAL (timeout()),
                                 &mainWindow, SLOT(qLocalServerPingSlot()));
                mainWindow.localServerTimer->start(1000);
            }
        }

        // No entry point:
        if (startFileFound == false) {
            mainWindow.qDisplayError(QString("No start page is found."));
            qDebug() << "No start page is found.";
        }
    }

    return application.exec();
}
