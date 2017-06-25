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

#ifndef Q_OS_WIN
#if ADMIN_PRIVILEGES_CHECK == 1
#include <unistd.h> // geteuid()
#endif
#endif

#ifdef Q_OS_WIN
#if ADMIN_PRIVILEGES_CHECK == 1
#include <windows.h> // isUserAdmin()
#endif
#endif

#include <qglobal.h>
#include <QApplication>
#include <QDateTime>
#include <QDebug>
#include <QJsonArray>
#include <QTextCodec>
#include <QtWidgets>

#include "main-window.h"
#include "exit-handler.h"

// ==============================
// WINDOWS USER PRIVILEGES DETECTION SUBROUTINE:
// ==============================
#ifdef Q_OS_WIN
#if ADMIN_PRIVILEGES_CHECK == 1
BOOL isUserAdmin()
{
    if (ADMIN_PRIVILEGES_CHECK == 1) {
        BOOL bResult;
        SID_IDENTIFIER_AUTHORITY ntAuthority = SECURITY_NT_AUTHORITY;
        PSID administratorsGroup;
        bResult = AllocateAndInitializeSid(
                    &ntAuthority, 2, SECURITY_BUILTIN_DOMAIN_RID,
                    DOMAIN_ALIAS_RID_ADMINS, 0, 0, 0, 0, 0, 0,
                    &administratorsGroup);
        if (bResult) {
            if (!CheckTokenMembership(NULL, administratorsGroup, &bResult)) {
                bResult = FALSE;
            }
            FreeSid(administratorsGroup);
        }
        return(bResult);
    }
}
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
    // Basic application properties:
    // ==============================
    application.setApplicationName("Perl Executing Browser");
    application.setApplicationVersion("0.5.0");
    bool startedAsRoot = false;

    // ==============================
    // Pseudo-domain:
    // ==============================
    application.setProperty("pseudoDomain", QString("local-pseudodomain"));

    // ==============================
    // UTF-8 encoding application-wide:
    // ==============================
    QTextCodec::setCodecForLocale(QTextCodec::codecForName("UTF8"));

    // ==============================
    // User privileges detection:
    // ==============================
    // Linux and Mac:
#ifndef Q_OS_WIN
#if ADMIN_PRIVILEGES_CHECK == 1
    int userEuid = geteuid();

    if (userEuid == 0) {
        startedAsRoot = true;
    }
#endif
#endif

    // Windows:
#ifdef Q_OS_WIN
#if ADMIN_PRIVILEGES_CHECK == 1
    if (isUserAdmin()) {
        startedAsRoot = true;
    }
#endif
#endif

    // ==============================
    // Binary file directory:
    // ==============================
    QDir binaryDir = QDir::toNativeSeparators(application.applicationDirPath());

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
    // Application directory:
    // ==============================
    QString applicationDirName = QDir::toNativeSeparators(
                binaryDirName + QDir::separator()
                + "resources" + QDir::separator()
                + "app");

    application.setProperty("application", applicationDirName);

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
        icon.load(":/icons/camel.png");
        QApplication::setWindowIcon(icon);
    }

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
    // closing the main window is requested using
    // the special window closing URL.
    qApp->setProperty("mainWindowCloseRequested", false);

    // Signal and slot for setting the main window title:
    QObject::connect(mainWindow.webViewWidget,
                     SIGNAL(titleChanged(QString)),
                     &mainWindow,
                     SLOT(setMainWindowTitleSlot(QString)));

    // Signal and slot for closing the main window:
    QObject::connect(&mainWindow,
                     SIGNAL(initiateMainWindowClosingSignal()),
                     mainWindow.webViewWidget->page(),
                     SLOT(qInitiateWindowClosingSlot()));

    QExitHandler exitHandler;

    // Signal and slot for actions taken before application exit:
    QObject::connect(qApp, SIGNAL(aboutToQuit()),
                     &exitHandler, SLOT(qExitApplicationSlot()));

    // ==============================
    // Started with
    // administrative privileges
    // error message:
    // ==============================
#if ADMIN_PRIVILEGES_CHECK == 1
    if (startedAsRoot == true) {
        QFileReader *resourceReader =
                new QFileReader(QString(":/html/error.html"));
        QString htmlErrorContents = resourceReader->fileContents;

        QString errorMessage = "Using "
                + application.applicationName().toLatin1() + " "
                + application.applicationVersion().toLatin1() + " "
                + "with administrative privileges is not allowed.";
        htmlErrorContents.replace("ERROR_MESSAGE", errorMessage);

        mainWindow.webViewWidget->setHtml(htmlErrorContents);

        qDebug() << "Using"
                << application.applicationName().toLatin1().constData()
                << application.applicationVersion().toLatin1().constData()
                << "with administrative privileges is not allowed.";
    }
#endif

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

        qDebug() << application.applicationName().toLatin1().constData()
                << application.applicationVersion().toLatin1().constData()
                << "started.";
        qDebug() << "Qt version:" << QT_VERSION_STR;
        qDebug() << "Executable:" << application.applicationFilePath();
        qDebug() << "No Perl interpreter is found.";
    }

    if (startedAsRoot == false and perlInterpreter.length() > 0) {
        // ==============================
        // Logging basic program information:
        // ==============================
        qDebug() << application.applicationName().toLatin1().constData()
                 << application.applicationVersion().toLatin1().constData()
                 << "started.";
        qDebug() << "Qt version:" << QT_VERSION_STR;
        qDebug() << "Executable:" << application.applicationFilePath();
        qDebug() << "PID:" << application.applicationPid();

#if ADMIN_PRIVILEGES_CHECK == 0
        qDebug() << "Administrative privileges check is disabled.";
#endif

#if ADMIN_PRIVILEGES_CHECK == 1
        qDebug() << "Administrative privileges check is enabled.";
#endif

        qDebug() << "Perl interpreter:" << perlInterpreter;
        qDebug() <<"Local pseudo-domain:"
                 << application.property("pseudoDomain").toString();

        // ==============================
        // Start page loading:
        // ==============================
        QString startPage;
        QFile startPageFile(
                    applicationDirName + QDir::separator() + "index.html");

        if (startPageFile.exists()) {
            startPage =
                    "file://" +
                    applicationDirName + QDir::separator() + "index.html";

            application.setProperty("startPage", startPage);

            mainWindow.webViewWidget->setUrl(QUrl(startPage));
        } else {
            QFileReader *resourceReader =
                    new QFileReader(QString(":/html/error.html"));
            QString htmlErrorContents = resourceReader->fileContents;

            QString errorMessage = "No start page is found.";
            htmlErrorContents.replace("ERROR_MESSAGE", errorMessage);
            mainWindow.webViewWidget->setHtml(htmlErrorContents);

            qDebug() << "No start page is found.";
        }
    }

    mainWindow.setCentralWidget(mainWindow.webViewWidget);
    mainWindow.setWindowIcon(icon);
    mainWindow.showMaximized();

    return application.exec();
}
