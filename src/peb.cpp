/*
 Perl Executing Browser, v. 0.1

 This program is free software;
 you can redistribute it and/or modify it under the terms of the
 GNU General Public License, as published by the Free Software Foundation;
 either version 3 of the License, or (at your option) any later version.
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY;
 without even the implied warranty of MERCHANTABILITY or
 FITNESS FOR A PARTICULAR PURPOSE.
 Dimitar D. Mitov, 2013 - 2016, ddmitov (at) yahoo (dot) com
 Valcho Nedelchev, 2014 - 2016
*/

#include <QApplication>
#include <QShortcut>
#include <QDateTime>
#include <QTranslator>
#include <QStyleFactory>
#include <QDebug>
#include <qglobal.h>
#include "peb.h"

#if ZIP_SUPPORT == 1
#include <quazip/JlCompress.h> // for unpacking root folder from a ZIP file
#endif

#ifndef Q_OS_WIN
#include <iostream> // for std::cout
#include <unistd.h> // for isatty()
#endif

#ifdef Q_OS_WIN
#include <windows.h>
#include <stdio.h>

// ==============================
// DETECT WINDOWS USER PRIVILEGES SUBROUTINE:
// ==============================
BOOL IsUserAdmin(void)
{
    BOOL bResult;
    SID_IDENTIFIER_AUTHORITY NtAuthority = SECURITY_NT_AUTHORITY;
    PSID AdministratorsGroup;
    bResult = AllocateAndInitializeSid(
                &NtAuthority, 2, SECURITY_BUILTIN_DOMAIN_RID,
                DOMAIN_ALIAS_RID_ADMINS, 0, 0, 0, 0, 0, 0,
                &AdministratorsGroup);
    if (bResult) {
        if (!CheckTokenMembership(NULL, AdministratorsGroup, &bResult)) {
            bResult = FALSE;
        }
        FreeSid(AdministratorsGroup);
    }
    return(bResult);
}
#endif

// ==============================
// MESSAGE HANDLER FOR REDIRECTING
// ALL DEBUG MESSAGES TO A LOG FILE:
// ==============================
void customMessageHandler(QtMsgType type,
                          const QMessageLogContext &context,
                          const QString &message)
{
    Q_UNUSED(context);
    QString dateAndTime =
            QDateTime::currentDateTime().toString("dd/MM/yyyy hh:mm:ss");
    QString text = QString("[%1] ").arg(dateAndTime);

    switch (type)
    {
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

    if ((qApp->property("logMode").toString()) == "single_file") {
        QFile logFile(QDir::toNativeSeparators
                      ((qApp->property("logDirFullPath").toString())
                       + QDir::separator()
                       + (qApp->property("logPrefix").toString())
                       + ".log"));
        logFile.open(QIODevice::WriteOnly
                     | QIODevice::Append
                     | QIODevice::Text);
        QTextStream textStream(&logFile);
        textStream << text << endl;
    }

    if ((qApp->property("logMode").toString()) == "per_session_file") {
        QFile logFile(QDir::toNativeSeparators
                      ((qApp->property("logDirFullPath").toString())
                       + QDir::separator()
                       + (qApp->property("logPrefix").toString())
                       + "-started-at-"
                       + (qApp->property("applicationStartDateAndTime")
                          .toString())
                       + ".log"));
        logFile.open(QIODevice::WriteOnly
                     | QIODevice::Append
                     | QIODevice::Text);
        QTextStream textStream(&logFile);
        textStream << text << endl;
    }
}

// ==============================
// MAIN APPLICATION DEFINITION:
// ==============================
int main(int argc, char **argv)
{
    QApplication application(argc, argv);

    // ==============================
    // SET BASIC APPLICATION VARIABLES:
    // ==============================
    QString applicationName = APPLICATION_NAME;
    if (applicationName.contains("_")) {
        applicationName.replace("_", " ");
    }
    application.setApplicationName(applicationName);
    application.setApplicationVersion(APPLICATION_VERSION);

    // ==============================
    // SET UTF-8 ENCODING APPLICATION-WIDE:
    // ==============================
    // Use UTF-8 encoding within the application:
    QTextCodec::setCodecForLocale(QTextCodec::codecForName("UTF8"));

    // ==============================
    // GET COMMAND LINE ARGUMENTS:
    // ==============================
    QStringList commandLineArguments = QCoreApplication::arguments();
    QString allArguments;
    foreach (QString argument, commandLineArguments) {
        allArguments.append(argument);
        allArguments.append(" ");
    }
    allArguments.replace(QRegExp("\\s$"), "");

    // ==============================
    // DISPLAY COMMAND LINE HELP:
    // ==============================
    foreach (QString argument, commandLineArguments) {
        if (argument.contains("--help") or argument.contains("-H")) {
#ifndef Q_OS_WIN
            // Linux & Mac:
            std::cout << " " << std::endl
                      << application.applicationName().toLatin1().constData()
                      << " v." << application.applicationVersion()
                         .toLatin1().constData()
                      << std::endl
                      << "Application file path: "
                      << QDir::toNativeSeparators(
                             QApplication::applicationFilePath())
                         .toLatin1().constData()
                      << std::endl
                      << "Qt version: " << QT_VERSION_STR << std::endl
                      << " " << std::endl
                      << "Usage:" << std::endl
                      << "  peb --option=value -o=value" << std::endl
                      << " " << std::endl
                      << "Command line options:" << std::endl
                      << "  --fullscreen    -F    "
                      << "start browser in fullscreen mode"
                      << std::endl;
#ifndef Q_OS_MAC
            std::cout << "  --maximized     -M    "
                      << "start browser in a maximized window"
                      << std::endl;
#endif
            std::cout << "  --help          -H    this help"
                      << std::endl
                      << " " << std::endl;
#endif

#ifdef Q_OS_WIN
            // Windows:
            QMessageBox commandLineHelp;
            commandLineHelp.setWindowModality(Qt::WindowModal);
            commandLineHelp.setIcon(QMessageBox::Information);
            commandLineHelp.setWindowTitle(
                        (QApplication::tr("Command-Line Options")));
            commandLineHelp.setText(
                        "  --fullscreen -F<br>"
                        + (QApplication::tr(
                               "start browser in fullscreen mode"))
                        + "<br><br>"
                        + "  --maximized -M<br>"
                        + (QApplication::tr(
                               "start browser in a maximized window"))
                        + "<br><br>"
                        + "  --help -H<br>"
                        + (QApplication::tr("this help")));
            commandLineHelp.setDefaultButton(QMessageBox::Ok);
            commandLineHelp.exec();
#endif
            return 1;
            QApplication::exit();
        }
    }

    // ==============================
    // DETECT USER PRIVILEGES AND
    // APPLICATION START FROM TERMINAL:
    // ==============================
#ifndef Q_OS_WIN
    // Detect user privileges - Linux and Mac:
    int userEuid;
    userEuid = geteuid();

    // If the browser is started from terminal,
    // it will start another copy of itself and close the first one.
    // This is necessary for a working interaction with the Perl debugger.
    if (isatty(fileno(stdin))) {
        std::cout << " " << std::endl
                  << application.applicationName().toLatin1().constData()
                  << " v." << application.applicationVersion()
                     .toLatin1().constData()
                  << std::endl
                  << "Command line: "
                  << allArguments.toLatin1().constData() << std::endl
                  << "Qt version: " << QT_VERSION_STR << std::endl
                  << "License: " << QLibraryInfo::licensedProducts()
                     .toLatin1().constData() << std::endl
                  << "Libraries Path: "
                  << QLibraryInfo::location(QLibraryInfo::LibrariesPath)
                     .toLatin1().constData() << std::endl;

        // Prevent starting as root from command line:
        if (userEuid == 0) {
            std::cout << "Started from terminal with root privileges. Aborting!"
                      << std::endl
                      << " " << std::endl;
            return 1;
            QApplication::exit();
        } else {
            std::cout << "Started from terminal with normal user privileges."
                      << std::endl;
            if (PERL_DEBUGGER_INTERACTION == 1) {
                std::cout << "Will start another instance of "
                          << "the program and quit this one."
                          << std::endl;
            }
            std::cout << " " << std::endl;
        }

        if (PERL_DEBUGGER_INTERACTION == 1) {
            // Fork another instance of the browser:
            int pid = fork();

            if (pid < 0) {
                return 1;
                QApplication::exit();
            }

            if (pid == 0) {
                // Detach all standard I/O descriptors:
                close(0);
                close(1);
                close(2);
                // Enter a new session:
                setsid();
                // New instance is now detached from terminal:
                QProcess anotherInstance;
                anotherInstance.startDetached(
                            QApplication::applicationFilePath(),
                            commandLineArguments);
                if (anotherInstance.waitForStarted(-1)) {
                    return 1;
                    QApplication::exit();
                }
            } else {
                // The parent instance should be closed now:
                return 1;
                QApplication::exit();
            }
        }
    }

    // Prevent starting as root in graphical mode:
    if (userEuid == 0) {
        QString title = (QApplication::tr("Started as root"));
        QString text = (QApplication::tr("Browser was started as root.")
                        + "<br>"
                        + QApplication::tr("This is not a good idea!")
                        + "<br>"
                        + QApplication::tr("Going to quit now."));
        QMessageBox startedAsRootMessageBox;
        startedAsRootMessageBox.setWindowModality(Qt::WindowModal);
        startedAsRootMessageBox.setIcon(QMessageBox::Critical);
        startedAsRootMessageBox.setWindowTitle(title);
        startedAsRootMessageBox.setText(text);
        startedAsRootMessageBox.setDefaultButton(QMessageBox::Ok);
        startedAsRootMessageBox.exec();

        return 1;
        QApplication::exit();
    }
#endif

#ifdef Q_OS_WIN
    // Detect user privileges - Windows:
    if (IsUserAdmin()) {
        QMessageBox startedAsRootMessageBox;
        startedAsRootMessageBox.setWindowModality(Qt::WindowModal);
        startedAsRootMessageBox.setIcon(QMessageBox::Critical);
        startedAsRootMessageBox.setWindowTitle(
                    QApplication::tr(
                        "Started by administrator"));
        startedAsRootMessageBox.setText(
                    QApplication::tr(
                        "Browser was started with administrative privileges.")
                    + "<br>"
                    + QApplication::tr("This is not a good idea!")
                    + "&nbsp;"
                    + QApplication::tr("Going to quit now."));
        startedAsRootMessageBox.setDefaultButton(QMessageBox::Ok);
        startedAsRootMessageBox.exec();

        return 1;
        QApplication::exit();
    }
#endif

    // ==============================
    // DEFINE SETTINGS FILE VARIABLES:
    // ==============================
    QString settingsDirName;
    QString settingsFileName;

    // ==============================
    // GET BASIC APPLICATION INFO:
    // ==============================
    // Application start date and time for temporary folder name:
    QString applicationStartDateAndTime =
            QDateTime::currentDateTime().toString("yyyy-MM-dd--hh-mm-ss");
    application
            .setProperty("applicationStartDateAndTime",
                         applicationStartDateAndTime);

    // Get the name of the browser binary:
    QString applicationBinaryName =
            QFileInfo(QApplication::applicationFilePath()).baseName();

    // ==============================
    // CREATE TEMPORARY FOLDER:
    // ==============================
    // Create the main temporary folder for the current browser session:
    QString applicationTempDirectoryName = QDir::tempPath() + QDir::separator()
            + applicationBinaryName + "--" + applicationStartDateAndTime;
    application
            .setProperty("applicationTempDirectory",
                         applicationTempDirectoryName);
    QDir applicationTempDirectory(applicationTempDirectoryName);
    applicationTempDirectory.mkpath(".");

    // ==============================
    // EXTRACT ROOT FOLDER FROM A ZIP PACKAGE:
    // ==============================
    QStringList extractedFiles;
    QString defaultZipPackageName = QApplication::applicationDirPath()
            + QDir::separator() + applicationBinaryName + ".zip";
    QFile defaultZipPackage(defaultZipPackageName);

    // Extracting root folder from a ZIP package:
    if (defaultZipPackage.exists()) {
#if ZIP_SUPPORT == 1
        extractedFiles = JlCompress::extractDir(
                    defaultZipPackageName,
                    applicationTempDirectoryName);

        // Extracting root folder from a zip file,
        // that was appended to the binary (!) using
        // 'cat peb-bin-only peb.zip > peb-with-data'
//        extractedFiles = JlCompress::extractDir (
//                    QApplication::applicationFilePath(),
//                    applicationTempDirectoryName);
#endif

#if ZIP_SUPPORT == 2
        QProcess unzipper;
        unzipper.start("unzip",
                       QStringList() << defaultZipPackageName
                       << "-d"
                       << applicationTempDirectoryName);
        if (!unzipper.waitForFinished())
                return false;
#endif

        // Settings file from the extracted ZIP package:
        settingsDirName = applicationTempDirectoryName
                + QDir::separator() + "root";
        settingsFileName = settingsDirName + QDir::separator()
                + applicationBinaryName + ".ini";
    }

    // ==============================
    // MANAGE APPLICATION SETTINGS:
    // ==============================
    // Settings file is loaded from the directory of the binary file
    // if no settings file from a ZIP package is found:
    if (settingsDirName.length() == 0 and settingsFileName.length() == 0) {
        QDir settingsDir =
                QDir::toNativeSeparators(application.applicationDirPath());
#ifdef Q_OS_MAC
        if (BUNDLE == 1) {
            settingsDir.cdUp();
            settingsDir.cdUp();
        }
#endif
        settingsDirName = settingsDir.absolutePath().toLatin1();
        settingsFileName = QDir::toNativeSeparators
                (settingsDirName + QDir::separator()
                 + applicationBinaryName + ".ini");
    }

    application.setProperty("settingsFileName", settingsFileName);

    if (!settingsDirName.endsWith(QDir::separator())) {
        settingsDirName.append(QDir::separator());
    }
    application.setProperty("settingsDirName", settingsDirName);

    QFile settingsFile(settingsFileName);

    // Check if settings file exists:
    if (!settingsFile.exists()) {
        QString title = QApplication::tr("Missing configuration file");
        QString text = QApplication::tr("Configuration file") +
                "<br>" +
                settingsFileName +
                "<br>" +
                QApplication::tr("is missing.") +
                "<br>" +
                QApplication::tr("Please restore it.");
        QMessageBox missingConfigurationFileMessageBox;
        missingConfigurationFileMessageBox.setWindowModality(Qt::WindowModal);
        missingConfigurationFileMessageBox.setIcon(QMessageBox::Critical);
        missingConfigurationFileMessageBox.setWindowTitle(title);
        missingConfigurationFileMessageBox.setText(text);
        missingConfigurationFileMessageBox.setDefaultButton(QMessageBox::Ok);
        missingConfigurationFileMessageBox.exec();

        return 1;
        QApplication::exit();
    }

    // Define INI file format for storing settings:
    QSettings settings(settingsFileName, QSettings::IniFormat);

    // BROWSER LOGGING SETTINGS:
    // Logging enable/disable switch:
    QString logging = settings.value("browser_logging/logging").toString();
    application.setProperty("logging", logging);

    // Install message handler for redirecting all debug messages to a log file:
    if ((qApp->property("logging").toString()) == "enable") {
        qInstallMessageHandler(customMessageHandler);
    }

    // Logging mode - 'per_session_file' or 'single_file'.
    // 'single_file' means that only one single log file is created.
    // 'per_session' means that a separate log file is
    // created for every browser session. Application start date and time are
    // appended to the file name in this scenario.
    QString logMode = settings.value("browser_logging/logging_mode").toString();
    application.setProperty("logMode", logMode);

    // Log files directory:
    QString logDirName = settings
            .value("browser_logging/logging_directory").toString();
    QDir logDir(logDirName);
    QString logDirFullPath;
    if (!logDir.exists()) {
        logDir.mkpath(".");
    }
    if (logDir.isRelative()) {
        logDirFullPath = QDir::toNativeSeparators(settingsDirName + logDirName);
    }
    if (logDir.isAbsolute()) {
        logDirFullPath = QDir::toNativeSeparators(logDirName);
    }
    application.setProperty("logDirFullPath", logDirFullPath);

    // Log filename prefix:
    QString logPrefix = settings
            .value("browser_logging/logging_prefix").toString();
    application.setProperty("logPrefix", logPrefix);

    // BROWSER NETWORKING SETTINGS:
    // Allowed domains:
    QStringList allowedDomainsList;
    int domainsSize = settings
            .beginReadArray("browser_networking/allowed_domains");
    for (int index = 0; index < domainsSize; ++index) {
        settings.setArrayIndex(index);
        QString pathSetting = settings.value("name").toString();
        allowedDomainsList.append(pathSetting);
    }
    settings.endArray();
    application.setProperty("allowedDomainsList", allowedDomainsList);

    // User agent:
    QString userAgent = settings
            .value("browser_networking/user_agent").toString();
    if (userAgent.length() == 0) {
        userAgent = USER_AGENT;
    }
    application.setProperty("userAgent", userAgent);

    // BROWSER PERL SETTINGS:
    // Folders to add to PATH:
    QStringList pathToAddList;
    int pathSize = settings.beginReadArray("browser_perl/path");
    for (int index = 0; index < pathSize; ++index) {
        settings.setArrayIndex(index);
        QString pathSetting = settings.value("name").toString();

        // Get all directory names to be added on PATH of all local scripts,
        // but first check if these directories exist,
        // then resolve all relative paths, if any:
        QDir pathDir(pathSetting);
        if (pathDir.exists()) {
            if (pathDir.isRelative()) {
                pathSetting = QDir::toNativeSeparators(
                            (qApp->property("settingsDirName").toString())
                            + pathSetting);
                pathToAddList.append(pathSetting);
            }
            if (pathDir.isAbsolute()) {
                pathSetting = QDir::toNativeSeparators(pathSetting);
                pathToAddList.append(pathSetting);
            }
        }
    }

    settings.endArray();
    application.setProperty("pathToAddList", pathToAddList);

    // Perl interpreter:
    QString perlInterpreterSetting = settings
            .value("browser_perl/perl").toString();

    if (perlInterpreterSetting.length() == 0) {
        QString title =
                QApplication::tr("Missing Perl");
        QString text = QApplication::tr("No Perl interpreter is set for") +
                "<br>" +
                application.applicationDisplayName() +
                QApplication::tr(" version ") +
                application.applicationVersion();
        QMessageBox missingPerlInterpreterMessageBox;
        missingPerlInterpreterMessageBox
                .setWindowModality(Qt::WindowModal);
        missingPerlInterpreterMessageBox.setIcon(QMessageBox::Warning);
        missingPerlInterpreterMessageBox.setWindowTitle(title);
        missingPerlInterpreterMessageBox.setText(text);
        missingPerlInterpreterMessageBox
                .setDefaultButton(QMessageBox::Ok);
        missingPerlInterpreterMessageBox.exec();
    }

    QString perlInterpreter;

    if (perlInterpreterSetting == "system") {
        QProcess systemPerlTester;
        systemPerlTester.start("perl",
                               QStringList()
                               << "-e"
                               << "print $^X;");
        if (systemPerlTester.waitForFinished()) {
            QByteArray testingScriptResultArray =
                    systemPerlTester.readAllStandardOutput();
            perlInterpreter =
                    QString::fromLatin1(testingScriptResultArray);

            if (perlInterpreter.length() == 0) {
                QString title =
                        QApplication::tr("Missing Perl");
                QString text =
                        QApplication::tr(
                            "No Perl interpreter is "
                            "available on PATH for") +
                        "<br>" +
                        application.applicationDisplayName() +
                        QApplication::tr(" version ") +
                        application.applicationVersion();
                QMessageBox missingPerlInterpreterMessageBox;
                missingPerlInterpreterMessageBox
                        .setWindowModality(Qt::WindowModal);
                missingPerlInterpreterMessageBox.setIcon(QMessageBox::Warning);
                missingPerlInterpreterMessageBox.setWindowTitle(title);
                missingPerlInterpreterMessageBox.setText(text);
                missingPerlInterpreterMessageBox
                        .setDefaultButton(QMessageBox::Ok);
                missingPerlInterpreterMessageBox.exec();
            }
        }
    } else {
        QDir interpreterFile(perlInterpreterSetting);
        if (interpreterFile.isRelative()) {
            perlInterpreter =
                    QDir::toNativeSeparators(settingsDirName
                                             + perlInterpreterSetting);
        }
        if (interpreterFile.isAbsolute()) {
            perlInterpreter = QDir::toNativeSeparators(perlInterpreterSetting);
        }

        QFile perlInterpreterBinary(perlInterpreterSetting);

        if (perlInterpreterSetting.length() > 0 and
                !perlInterpreterBinary.exists()) {
            QString title =
                    QApplication::tr("Missing Perl");
            QString text =
                    QApplication::tr("Perl interpreter is missing for") +
                    "<br>" +
                    application.applicationDisplayName() +
                    QApplication::tr(" version ") +
                    application.applicationVersion();
            QMessageBox missingPerlInterpreterMessageBox;
            missingPerlInterpreterMessageBox
                    .setWindowModality(Qt::WindowModal);
            missingPerlInterpreterMessageBox.setIcon(QMessageBox::Warning);
            missingPerlInterpreterMessageBox.setWindowTitle(title);
            missingPerlInterpreterMessageBox.setText(text);
            missingPerlInterpreterMessageBox
                    .setDefaultButton(QMessageBox::Ok);
            missingPerlInterpreterMessageBox.exec();
        }
    }

    application.setProperty("perlInterpreter", perlInterpreter);

    // PERLLIB environment variable:
    QString perlLibSetting = settings.value("browser_perl/perllib").toString();
    QDir perlLibDir(perlLibSetting);
    QString perlLib;
    if (perlLibDir.isRelative()) {
        perlLib = QDir::toNativeSeparators(settingsDirName + perlLibSetting);
    }
    if (perlLibDir.isAbsolute()) {
        perlLib = QDir::toNativeSeparators(perlLibSetting);
    }
    application.setProperty("perlLib", perlLib);

    // Display or hide STDERR from scripts:
    QString displayStderr =
            settings.value("browser_perl/perl_display_stderr").toString();
    application.setProperty("displayStderr", displayStderr);

    // Timeout for CGI-like and AJAX scripts (not long-running ones):
    QString scriptTimeout =
            settings.value("browser_perl/perl_script_timeout").toString();
    application.setProperty("scriptTimeout", scriptTimeout);

    // PACKAGE GUI SETTINGS:
    // Package root directory:
    QString rootDirName;
    QString rootDirNameSetting = settings.value("package_gui/root").toString();
    if (rootDirNameSetting == "current") {
        rootDirName = settingsDirName;
    } else {
        rootDirName = QDir::toNativeSeparators(rootDirNameSetting);
    }
    if (!rootDirName.endsWith(QDir::separator())) {
        rootDirName.append(QDir::separator());
    }
    application.setProperty("rootDirName", rootDirName);

    // Start page - path must be relative to the PEB root directory:
    // HTML file or script are equally usable as a start page:
    QString startPagePath = settings.value("package_gui/start_page").toString();
    QString startPage;

    if (startPagePath.length() > 0) {
        startPage = QDir::toNativeSeparators(rootDirName + startPagePath);
        application.setProperty("startPagePath", startPagePath);
        application.setProperty("startPage", startPage);
    }

    // Check if start page exists:
    QFile startPageFile(startPage);
    if (!startPageFile.exists()) {
        QString title = QApplication::tr("Missing start page");
        QString text = QApplication::tr("Start page is missing for") +
                "<br>" +
                application.applicationDisplayName() +
                QApplication::tr(" version ") +
                application.applicationVersion();
        QMessageBox missingStartPageMessageBox;
        missingStartPageMessageBox.setWindowModality(Qt::WindowModal);
        missingStartPageMessageBox.setIcon(QMessageBox::Critical);
        missingStartPageMessageBox.setWindowTitle(title);
        missingStartPageMessageBox.setText(text);
        missingStartPageMessageBox.setDefaultButton(QMessageBox::Ok);
        missingStartPageMessageBox.exec();

        return 1;
        QApplication::exit();
    }

    // Warn on exit:
    QString warnOnExit = settings.value("package_gui/warn_on_exit") .toString();
    application.setProperty("warnOnExit", warnOnExit);

#ifndef Q_OS_MAC
    // Window size - 'maximized', 'fullscreen' or numeric value like
    // '800x600' or '1024x756' etc.:
    QString windowSize = settings.value("package_gui/window_size").toString();
    int fixedWidth;
    int fixedHeight;
    if (windowSize != "maximized" or windowSize != "fullscreen") {
        fixedWidth = windowSize.section("x", 0, 0) .toInt();
        fixedHeight = windowSize.section("x", 1, 1) .toInt();
        application.setProperty("fixedWidth", fixedWidth);
        application.setProperty("fixedHeight", fixedHeight);
    }
    application.setProperty("windowSize", windowSize);
#endif

    // Browser title -'dynamic' or 'My Favorite Title'
    // 'dynamic' title is taken from every HTML <title> tag.
    QString browserTitle = settings
            .value("package_gui/browser_title").toString();
    application.setProperty("browserTitle", browserTitle);

    // Right click context menu enable/disable switch:
    QString contextMenu = settings.value("package_gui/context_menu").toString();
    application.setProperty("contextMenu", contextMenu);

    // Going to start page enable/disable switch:
    QString goHomeCapability =
            settings.value("package_gui/go_home_capability").toString();
    application.setProperty("goHomeCapability", goHomeCapability);

    // Page reload enable/disable switch:
    QString reloadCapability =
            settings.value("package_gui/reload_capability").toString();
    application.setProperty("reloadCapability", reloadCapability);

    // Web Inspector from context menu enable/disable switch:
    QString webInspector = settings
            .value("package_gui/web_inspector").toString();
    application.setProperty("webInspector", webInspector);

    // Icon for windows and message boxes:
    QString iconPathNameSetting = settings.value("package_gui/icon").toString();
    QString iconPathName;

    if (iconPathNameSetting.length() > 0) {
        QFileInfo iconFileInfo(iconPathNameSetting);
        if (iconFileInfo.isRelative()) {
            iconPathName = QDir::toNativeSeparators(
                        rootDirName + iconPathNameSetting);
        }
        if (iconFileInfo.isAbsolute()) {
            iconPathName = QDir::toNativeSeparators(iconPathNameSetting);
        }
    }

    QFile iconFile(iconPathName);
    QPixmap icon(32, 32);
    if (iconFile.exists()) {
        application.setProperty("iconPathName", iconPathName);
        icon.load(iconPathName);
        QApplication::setWindowIcon(icon);
    } else {
        // Set an empty, transparent icon for windows and message boxes
        // in case no icon file is found:
        icon.fill(Qt::transparent);
        QApplication::setWindowIcon(icon);
    }

    // Global Qt style for the whole application:
    // Disabling default Qt style and explicitly setting another Qt style
    // may be usefull to avoid minor graphical issues and warnings.
    QString qtStyleSetting = settings.value("package_gui/qt_style").toString();
    QString qtStyle;
    QStringList availableStyles = QStyleFactory::keys();
    foreach (QString availableStyle, availableStyles) {
        if (availableStyle == qtStyleSetting) {
            qtStyle = availableStyle;
            application.setStyle(QStyleFactory::create(qtStyle));
        }
    }

    // System tray icon enable/disable switch:
    QString systrayIcon = settings.value("package_gui/systray_icon").toString();
    application.setProperty("systrayIcon", systrayIcon);

    // System tray icon file:
    // This setting was created to circumvent QTBUG-35832 -
    // inability to display transparent background of
    // system tray icons in Qt5 on Linux.
    // An icon without a transparent background should be used as
    // a systray icon when the binary is compiled for Linux.
    QString systrayIconPathNameSetting =
            settings.value("package_gui/systray_icon_file").toString();
    QString systrayIconPathName;
    // If 'icon_systray' setting is empty,
    // the window icon will be used as a systray icon.
    if (systrayIconPathNameSetting.length() == 0) {
        application.setProperty("systrayIconPathName", iconPathName);
    } else {
        QFileInfo systrayIconFileInfo(systrayIconPathNameSetting);
        if (systrayIconFileInfo.isRelative()) {
            systrayIconPathName = QDir::toNativeSeparators(
                        rootDirName + systrayIconPathNameSetting);
        }
        if (systrayIconFileInfo.isAbsolute()) {
            systrayIconPathName =
                    QDir::toNativeSeparators(systrayIconPathNameSetting);
        }
        application.setProperty("systrayIconPathName", systrayIconPathName);
    }

    // Directory of the default GUI theme:
    QString defaultThemeDirectorySetting =
            settings.value("package_gui/theme_default_directory").toString();
    application.setProperty("defaultThemeDirectoryName",
                            defaultThemeDirectorySetting);
    QString defaultThemeDirectory = QDir::toNativeSeparators(
                rootDirName + defaultThemeDirectorySetting);
    application.setProperty("defaultThemeDirectoryFullPath",
                            defaultThemeDirectory);

    // Directory for all GUI themes:
    QString allThemesDirectorySetting =
            settings.value("package_gui/themes_directory").toString();
    QString allThemesDirectory =
                QDir::toNativeSeparators(rootDirName
                                         + allThemesDirectorySetting);
    application.setProperty("allThemesDirectory", allThemesDirectory);

    // Translation:
    QString translation =
            settings.value("package_gui/translation").toString();
    QTranslator translator;
    if (translation != "none") {
        translator.load("peb_" + translation, ":/translations");
    }
    application.installTranslator(&translator);

    // ==============================
    // COMMAND LINE SETTING OVERRIDES:
    // ==============================
    // Command line arguments override
    // configuration file settings with the same name:
    foreach (QString argument, commandLineArguments) {
        if(argument.contains("--fullscreen") or argument.contains("-F")) {
            windowSize = "fullscreen";
            application.setProperty("windowSize", windowSize);
        }
#ifndef Q_OS_MAC
        if (argument.contains("--maximized") or argument.contains("-M")) {
            fixedWidth = 1;
            fixedHeight = 1;
            windowSize = "maximized";
            application.setProperty("windowSize", windowSize);
        }
#endif
    }

    // ==============================
    // LOG ALL SETTINGS:
    // ==============================
    // Log basic program information:
    qDebug() << "" << endl
             << application.applicationName().toLatin1().constData()
             << "version"
             << application.applicationVersion().toLatin1().constData()
             << "started." << endl
             << "Command line:" << allArguments.toLatin1().constData() << endl
             << "Qt version:" << QT_VERSION_STR << endl
             << "License:"
             << QLibraryInfo::licensedProducts().toLatin1().constData() << endl
             << "Libraries Path:"
             << QLibraryInfo::location(QLibraryInfo::LibrariesPath)
                .toLatin1().constData() << endl
             << "";

    qDebug() << "===============" << endl
             << "BROWSER COMPILE-TIME SETTINGS:" << endl
             << "===============" << endl
             << "Local pseudo-domain:" << PSEUDO_DOMAIN;
    if (SCRIPT_CENSORING == 0) {
        qDebug() << "Script censoring is disabled.";
    }
    if (SCRIPT_CENSORING == 1) {
        qDebug() << "Script censoring is enabled.";
    }
    if (ZIP_SUPPORT == 0) {
        qDebug() << "ZIP packages support is disabled.";
    }
    if (ZIP_SUPPORT == 1) {
        qDebug() << "ZIP packages support is enabled using internal code.";
    }
    if (ZIP_SUPPORT == 2) {
        qDebug() << "ZIP packages support is enabled using external unpacker.";
    }
    if (PERL_DEBUGGER_INTERACTION == 0) {
        qDebug() << "Perl debugger interaction is disabled.";
    }
    if (PERL_DEBUGGER_INTERACTION == 1) {
        qDebug() << "Perl debugger interaction is enabled.";
    }

    qDebug() << "===============" << endl
             << "BROWSER RUNTIME SETTINGS:" << endl
             << "===============" << endl
             << "Temporary folder:" << applicationTempDirectoryName << endl
             << "Settings file name:" << settingsFileName << endl
             << "Folders to add to PATH:";
    foreach (QString pathEntry, pathToAddList) {
        qDebug() << pathEntry;
    }
    qDebug() << "Perl interpreter" << perlInterpreter << endl
             << "PERLLIB folder:" << perlLib << endl
             << "Display STDERR from scripts:" << displayStderr << endl
             << "Script Timeout:" << scriptTimeout << endl
             << "Logging:" << logging << endl
             << "Logging mode:" << logMode << endl
             << "Logfiles directory:" << logDirFullPath << endl
             << "Logfiles prefix:" << logPrefix << endl
             << "Allowed domains:";
    foreach (QString allowedDomainsListEntry, allowedDomainsList) {
        qDebug() << allowedDomainsListEntry;
    }
    qDebug() << "User Agent:" << userAgent;

    qDebug() << "===============" << endl
             << "PACKAGE SETTINGS:" << endl
             << "===============" << endl
             << "Root folder:" << QDir::toNativeSeparators(rootDirName) << endl
             << "Start page:" << startPagePath << endl
             << "Warn on exit:" << warnOnExit;
#ifndef Q_OS_MAC
    qDebug() << "Window size:" << windowSize;
#endif
    qDebug() << "Browser title:" << browserTitle << endl
             << "Context menu:" << contextMenu << endl
             << "Go to start page capability:" << goHomeCapability << endl
             << "Page reload capability:" << reloadCapability << endl
             << "Windows and dialogs icon file:" << iconPathName;
    if (qtStyle.length() > 0) {
        qDebug() << "Available Qt styles:";
        QStringList allAvailableStyles = QStyleFactory::keys();
        foreach (QString availableStyle, allAvailableStyles) {
            qDebug() << availableStyle;
        }
        qDebug() << "Global Qt style:" << qtStyle;
    }
    qDebug() << "Default theme directory:" << defaultThemeDirectory << endl
             << "All themes directory:" << allThemesDirectory << endl
             << "Default translation:" << translation << endl
             << "System tray icon switch:" << systrayIcon << endl
             << "System tray icon file:" << systrayIconPathName << endl
             << "Web Inspector from context menu:" << webInspector << endl
             << "===============";

    if (extractedFiles.length() > 0) {
        qDebug() << "ZIP package found." << endl
                 << "Extracted directories and files:";
        foreach (QString extractedFile, extractedFiles) {
            qDebug() << extractedFile;
        }
        qDebug() << "===============";
    }

    // ==============================
    // MAIN GUI CLASS INITIALIZATION:
    // ==============================
    QWebViewWindow toplevel;

    QObject::connect(qApp, SIGNAL(lastWindowClosed()),
                     &toplevel, SLOT(qExitApplicationSlot()));

    toplevel.setWindowIcon(icon);
    toplevel.qLoadStartPageSlot();
    toplevel.show();

    // ==============================
    // SYSTEM TRAY ICON CLASS INITIALIZATION:
    // ==============================
    QTrayIcon trayIcon;
    if (systrayIcon == "enable") {
        QObject::connect(trayIcon.aboutAction, SIGNAL(triggered()),
                         &toplevel, SLOT(qAboutSlot()));

        QObject::connect(&toplevel, SIGNAL(trayIconHideSignal()),
                         &trayIcon, SLOT(qTrayIconHideSlot()));
    }

    return application.exec();
}

// ==============================
// FILE DETECTOR CLASS CONSTRUCTOR:
// ==============================
QFileDetector::QFileDetector()
    : QObject(0)
{
    perlShebang.setPattern("#!/.{1,}perl");

    // Regular expressions for file type detection by extension:
    plExtension.setPattern("pl");
    plExtension.setCaseSensitivity(Qt::CaseInsensitive);

    htmlExtensions.setPattern("htm");
    htmlExtensions.setCaseSensitivity(Qt::CaseInsensitive);

    cssExtension.setPattern("css");
    cssExtension.setCaseSensitivity(Qt::CaseInsensitive);

    jsExtension.setPattern("js");
    jsExtension.setCaseSensitivity(Qt::CaseInsensitive);

    ttfExtension.setPattern("ttf");
    ttfExtension.setCaseSensitivity(Qt::CaseInsensitive);

    eotExtension.setPattern("eot");
    eotExtension.setCaseSensitivity(Qt::CaseInsensitive);

    woffExtensions.setPattern("woff");
    woffExtensions.setCaseSensitivity(Qt::CaseInsensitive);

    svgExtension.setPattern("svg");
    svgExtension.setCaseSensitivity(Qt::CaseInsensitive);

    pngExtension.setPattern("png");
    pngExtension.setCaseSensitivity(Qt::CaseInsensitive);

    jpgExtensions.setPattern("jpe{0,1}g");
    jpgExtensions.setCaseSensitivity(Qt::CaseInsensitive);

    gifExtension.setPattern("gif");
    gifExtension.setCaseSensitivity(Qt::CaseInsensitive);
}

// ==============================
// SCRIPT ENVIRONMENT CLASS CONSTRUCTOR:
// ==============================
QScriptEnvironment::QScriptEnvironment()
    : QObject(0)
{
    // DOCUMENT_ROOT:
    scriptEnvironment.insert("DOCUMENT_ROOT",
                             qApp->property("rootDirName").toString());

    // PERLLIB:
    scriptEnvironment.insert("PERLLIB", qApp->property("perlLib").toString());

    // PATH:
    QString path;
    QString pathSeparator;
#if defined (Q_OS_LINUX) or defined (Q_OS_MAC) // Linux and Mac
    pathSeparator = ":";
#endif
#ifdef Q_OS_WIN // Windows
    pathSeparator = ";";
#endif

    // Add all browser-specific folders to the PATH of all local scripts,
    // but first check if these directories exist,
    // then resolve all relative paths, if any:
    foreach (QString pathEntry, qApp->property("pathToAddList").toString()) {
        path.append(pathEntry);
        path.append(pathSeparator);
    }

#ifndef Q_OS_WIN // Linux and Mac
    scriptEnvironment.insert("PATH", path);
#endif
#ifdef Q_OS_WIN // Windows
    scriptEnvironment.insert("Path", path);
#endif
}

// ==============================
// CUSTOM NETWORK REPLY CONSTRUCTOR:
// ==============================
struct QCustomNetworkReplyPrivate
{
    QByteArray data;
    int offset;
};

QCustomNetworkReply::QCustomNetworkReply(const QUrl &url, QString &data)
    : QNetworkReply()
{
    setFinished(true);
    open(ReadOnly | Unbuffered);

    reply = new QCustomNetworkReplyPrivate;
    reply->offset = 0;

    setUrl(url);

//    setHeader(QNetworkRequest::ContentTypeHeader,
//              QVariant("text/html; charset=UTF-8"));
    setHeader(QNetworkRequest::ContentLengthHeader,
              QVariant(reply->data.size()));
    setHeader(QNetworkRequest::LastModifiedHeader,
              QVariant(QDateTime::currentDateTimeUtc()));

    QTimer::singleShot(0, this, SIGNAL(metaDataChanged()));

    setAttribute(QNetworkRequest::HttpStatusCodeAttribute, 200);
    setAttribute(QNetworkRequest::HttpReasonPhraseAttribute, "OK");

    reply->data = data.toUtf8();

    QTimer::singleShot(0, this, SIGNAL(readyRead()));
    QTimer::singleShot(0, this, SIGNAL(finished()));
}

QCustomNetworkReply::~QCustomNetworkReply()
{
    delete reply;
}

qint64 QCustomNetworkReply::size() const
{
    return reply->data.size();
}

void QCustomNetworkReply::abort()
{
    // !!! no need to implement code here, but must be declared !!!
}

qint64 QCustomNetworkReply::bytesAvailable() const
{
    return size();
}

bool QCustomNetworkReply::isSequential() const
{
    return true;
}

qint64 QCustomNetworkReply::read(char *data, qint64 maxSize)
{
    return readData(data, maxSize);
}

qint64 QCustomNetworkReply::readData(char *data, qint64 maxSize)
{
    if (reply->offset >= reply->data.size()) {
        return -1;
    }

    qint64 number = qMin(maxSize, (qint64) reply->data.size() - reply->offset);
    memcpy(data, reply->data.constData() + reply->offset, number);
    reply->offset += number;
    return number;
}

// ==============================
// WEB PAGE CLASS CONSTRUCTOR:
// ==============================
QPage::QPage()
    : QWebPage(0)
{
    QWebSettings::globalSettings()->
            setDefaultTextEncoding(QString("utf-8"));
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::PluginsEnabled, true);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::JavascriptEnabled, true);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::JavascriptCanOpenWindows, true);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::SpatialNavigationEnabled, true);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::LinksIncludedInFocusChain, true);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::AutoLoadImages, true);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::AcceleratedCompositingEnabled, true);
    if ((qApp->property("webInspector").toString()) == "enable") {
        QWebSettings::globalSettings()->
                setAttribute(QWebSettings::DeveloperExtrasEnabled, true);
    }
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::PrivateBrowsingEnabled, true);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::LocalContentCanAccessFileUrls, true);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::LocalContentCanAccessRemoteUrls, true);
    //QWebPage::setForwardUnsupportedContent(true);
    QWebSettings::setMaximumPagesInCache(0);
    QWebSettings::setObjectCacheCapacities(0, 0, 0);

    // SIGNALS AND SLOTS FOR THE PERL DEBUGGER:
    if (PERL_DEBUGGER_INTERACTION == 1) {
        QObject::connect(&debuggerHandler, SIGNAL(readyReadStandardOutput()),
                         this, SLOT(qDebuggerOutputSlot()));

        QObject::connect(&debuggerOutputHandler,
                         SIGNAL(readyReadStandardOutput()),
                         this,
                         SLOT(qDebuggerHtmlFormatterOutputSlot()));
        QObject::connect(&debuggerOutputHandler,
                         SIGNAL(readyReadStandardError()),
                         this,
                         SLOT(qDebuggerHtmlFormatterErrorsSlot()));
        QObject::connect(&debuggerOutputHandler,
                         SIGNAL(finished(int, QProcess::ExitStatus)),
                         this,
                         SLOT(qDebuggerHtmlFormatterFinishedSlot()));

        // EXPLICIT INITIALIZATION OF IMPORTANT PERL-DEBUGGER-RELATED VALUE:
        debuggerJustStarted = false;
    }

    // SIGNALS AND SLOTS FOR ALL LOCAL PERL SCRIPTS:
    QObject::connect(&scriptHandler, SIGNAL(readyReadStandardOutput()),
                     this, SLOT(qScriptOutputSlot()));
    QObject::connect(&scriptHandler, SIGNAL(readyReadStandardError()),
                     this, SLOT(qScriptErrorsSlot()));
    QObject::connect(&scriptHandler,
                     SIGNAL(finished(int, QProcess::ExitStatus)),
                     this,
                     SLOT(qScriptFinishedSlot()));

    // SCRIPT ENVIRONMENT:
    QScriptEnvironment initialScriptEnvironment;
    scriptEnvironment = initialScriptEnvironment.scriptEnvironment;

    // DEFAULT FRAME FOR LOCAL CONTENT:
    targetFrame = QPage::mainFrame();

    // ICON FOR DIALOGS:
    icon.load(qApp->property("iconPathName").toString());

    // READ INTERNALLY COMPILED JS SCRIPT:
    QFile file;
    file.setFileName(":/scripts/js/check-user-input-before-quit.js");
    file.open(QIODevice::ReadOnly);
    checkUserInputBeforeQuitJavaScript = file.readAll();
    file.close();
}

// ==============================
// WEB VIEW CLASS CONSTRUCTOR:
// ==============================
QWebViewWindow::QWebViewWindow()
    : QWebView(0)
{
    // Configure keyboard shortcuts:
    if ((qApp->property("goHomeCapability").toString()) == "enable") {
        QShortcut *homeShortcut = new QShortcut(QKeySequence("Ctrl+H"), this);
        QObject::connect(homeShortcut, SIGNAL(activated()),
                         this, SLOT(qLoadStartPageSlot()));
    }

    if ((qApp->property("reloadCapability").toString()) == "enable") {
        QShortcut *reloadShortcut = new QShortcut(QKeySequence("Ctrl+R"), this);
        QObject::connect(reloadShortcut, SIGNAL(activated()),
                         this, SLOT(qReloadSlot()));
    }

#ifndef QT_NO_PRINTER
    QShortcut *printShortcut = new QShortcut(QKeySequence("Ctrl+P"), this);
    QObject::connect(printShortcut, SIGNAL(activated()),
                     this, SLOT(qPrintSlot()));
#endif

#ifndef Q_OS_MAC
    // Configure screen appearance:
    if ((qApp->property("fixedWidth").toInt()) > 100 and
            (qApp->property("fixedHeight").toInt()) > 100) {
        setFixedSize((qApp->property("fixedWidth").toInt()),
                     (qApp->property("fixedHeight").toInt()));
        QRect screenRect = QDesktopWidget().screen()->rect();
        move(QPoint(screenRect.width() / 2 - width() / 2,
                    screenRect.height() / 2 - height() / 2));
    } else {
        showMaximized();
    }
    if ((qApp->property("windowSize").toString()) == "maximized") {
        showMaximized();
    }
    if ((qApp->property("windowSize").toString()) == "fullscreen") {
        showFullScreen();
    }
#endif

    // Configure browser title:
    if ((qApp->property("browserTitle").toString()) != "dynamic") {
        setWindowTitle((qApp->property("browserTitle").toString()));
    }

    // Configure context menu:
    if ((qApp->property("contextMenu").toString()) == "disable") {
        setContextMenuPolicy(Qt::NoContextMenu);
    }

    mainPage = new QPage();

    // Connect signals and slots - main window:
    QObject::connect(mainPage, SIGNAL(displayErrorsSignal(QString)),
                     this, SLOT(qDisplayErrorsSlot(QString)));

    QObject::connect(mainPage, SIGNAL(printPreviewSignal()),
                     this, SLOT(qStartPrintPreviewSlot()));
    QObject::connect(mainPage, SIGNAL(printSignal()),
                     this, SLOT(qPrintSlot()));
    QObject::connect(mainPage, SIGNAL(saveAsPdfSignal()),
                     this, SLOT(qSaveAsPdfSlot()));

    QObject::connect(mainPage, SIGNAL(reloadSignal()),
                     this, SLOT(qReloadSlot()));

    if ((qApp->property("browserTitle").toString()) == "dynamic") {
        QObject::connect(mainPage, SIGNAL(loadFinished(bool)),
                         this, SLOT(qPageLoadedDynamicTitleSlot(bool)));
    }

    setPage(mainPage);

    // Use modified Network Access Manager with every window of the program:
    QModifiedNetworkAccessManager *networkAccessManager =
            new QModifiedNetworkAccessManager();
    mainPage->setNetworkAccessManager(networkAccessManager);

    QObject::connect(networkAccessManager,
                     SIGNAL(startScriptSignal(QUrl, QByteArray)),
                     mainPage,
                     SLOT(qStartScriptSlot(QUrl, QByteArray)));

    // Disable history:
    QWebHistory *history = mainPage->history();
    history->setMaximumItemCount(0);

    // Cookies and HTTPS support:
    QNetworkCookieJar *cookieJar = new QNetworkCookieJar;
    networkAccessManager->setCookieJar(cookieJar);
    QObject::connect(networkAccessManager,
                     SIGNAL(sslErrors(QNetworkReply*, QList<QSslError>)),
                     this,
                     SLOT(qSslErrorsSlot(QNetworkReply*, QList<QSslError>)));

    // Configure scroll bars:
    mainPage->mainFrame()->setScrollBarPolicy(Qt::Horizontal,
                                              Qt::ScrollBarAsNeeded);
    mainPage->mainFrame()->setScrollBarPolicy(Qt::Vertical,
                                              Qt::ScrollBarAsNeeded);

    // Context menu settings:
    mainPage->action(QWebPage::SetTextDirectionLeftToRight)->setVisible(false);
    mainPage->action(QWebPage::SetTextDirectionRightToLeft)->setVisible(false);

    mainPage->action(QWebPage::Back)->setVisible(false);
    mainPage->action(QWebPage::Forward)->setVisible(false);
    mainPage->action(QWebPage::Reload)->setVisible(false);
    mainPage->action(QWebPage::Stop)->setVisible(false);

    mainPage->action(QWebPage::OpenLink)->setVisible(false);
    mainPage->action(QWebPage::CopyLinkToClipboard)->setVisible(false);
    mainPage->action(QWebPage::OpenLinkInNewWindow)->setVisible(false);
    mainPage->action(QWebPage::DownloadLinkToDisk)->setVisible(false);
    mainPage->action(QWebPage::OpenFrameInNewWindow)->setVisible(false);

    mainPage->action(QWebPage::CopyImageUrlToClipboard)->setVisible(false);
    mainPage->action(QWebPage::CopyImageToClipboard)->setVisible(false);
    mainPage->action(QWebPage::OpenImageInNewWindow)->setVisible(true);
    mainPage->action(QWebPage::DownloadImageToDisk)->setVisible(false);

    // Icon for windows:
    icon.load(qApp->property("iconPathName").toString());

    windowClosingStarted = false;
}

// ==============================
// SYSTEM TRAY ICON CLASS CONSTRUCTOR:
// ==============================
QTrayIcon::QTrayIcon()
    : QSystemTrayIcon(0)
{
    if ((qApp->property("systrayIcon").toString()) == "enable") {
        trayIcon = new QSystemTrayIcon();
        QString iconPathName = qApp->property("systrayIconPathName").toString();
        QPixmap icon;
        icon.load(iconPathName);
        trayIcon->setIcon(icon);
        trayIcon->setToolTip(qApp->applicationName());

        aboutAction = new QAction(tr("&About"), this);

        aboutQtAction = new QAction(tr("About Q&t"), this);
        QObject::connect(aboutQtAction, SIGNAL(triggered()),
                         qApp, SLOT(aboutQt()));

        trayIconMenu = new QMenu();
        trayIcon->setContextMenu(trayIconMenu);
        trayIconMenu->addAction(aboutAction);
        trayIconMenu->addAction(aboutQtAction);
        trayIcon->show();
    }
}

// ==============================
// MANAGE CLICKING OF LINKS:
// ==============================
bool QPage::acceptNavigationRequest(QWebFrame *frame,
                                   const QNetworkRequest &request,
                                   QWebPage::NavigationType navigationType)
{
    // DISPLAY BROWSER SETTINGS:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            request.url().toString() == "about:config") {

        QString settingsUiFileName(":/html/settings.htm");
        QFile settingsUiFile(settingsUiFileName);
        settingsUiFile.open(QIODevice::ReadOnly
                              | QIODevice::Text);
        QTextStream settingsUistream(&settingsUiFile);
        QString settingsUiContents = settingsUistream.readAll();
        settingsUiFile.close();

        QString path;
        foreach (QString pathEntry,
                 qApp->property("pathToAddList").toStringList()) {
            path.append(pathEntry);
            path.append("<br>");
        }
        path.replace(QRegExp("<br>$"), "");
        if (path.length() > 0) {
            settingsUiContents.replace("[% PATH %]", path);
        } else {
            settingsUiContents.replace("[% PATH %]", "none");
        }

        settingsUiContents.replace("[% Perl interpreter %]",
                                   qApp->property("perlInterpreter")
                                   .toString());

        settingsUiContents.replace("[% PERLLIB folder %]",
                                   qApp->property("perlLib").toString());

        settingsUiContents.replace("[% Perl debugger output formatter %]",
                                   qApp->property("debuggerOutputFormatter")
                                   .toString());

        settingsUiContents.replace("[% Display STDERR %]",
                                   qApp->property("displayStderr").toString());

        frame->setHtml(settingsUiContents, QUrl(PSEUDO_DOMAIN));

        qDebug() << "Settings page requested";
        qDebug() << "===============";

        return false;
    }

    // SET BROWSER SETTINGS:
    // Set Perl interpreter:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            request.url().fileName() == "perl.setting" and
            request.url().query() == ("action=set")) {

        QFileDialog selectPerlInterpreterDialog (qApp->activeWindow());
        selectPerlInterpreterDialog.setFileMode(QFileDialog::AnyFile);
        selectPerlInterpreterDialog.setViewMode(QFileDialog::Detail);
        selectPerlInterpreterDialog.setWindowModality(Qt::WindowModal);
        QString perlInterpreter = selectPerlInterpreterDialog
                .getOpenFileName
                (qApp->activeWindow(), tr("Select Perl Interpreter"),
                 QDir::currentPath(), tr("All files (*)"));
        selectPerlInterpreterDialog.close();
        selectPerlInterpreterDialog.deleteLater();

        if (perlInterpreter.length() > 0) {
            // Save Perl interpreter setting in the settings file:
            QSettings perlInterpreterSetting(
                        (qApp->property("settingsFileName").toString()),
                        QSettings::IniFormat);
            perlInterpreterSetting
                    .setValue("browser_perl/perl", perlInterpreter);
            perlInterpreterSetting.sync();

            // Set global Perl interpreter setting:
            qApp->setProperty("perlInterpreter", perlInterpreter);

            // JavaScript bridge back to the settings page:
            QString javaScript =
                    "document.getElementById(\"setting-perl\")"
                    ".innerHTML = \"" + perlInterpreter + "\";";
            currentFrame()->evaluateJavaScript(javaScript);

            qDebug() << "Selected Perl interpreter:" << perlInterpreter;
            qDebug() << "===============";
        }

        return false;
    }

    // Set PERLLIB:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            request.url().fileName() == "perllib.setting" and
            request.url().query() == ("action=set")) {

        QFileDialog selectPerlLibDialog (qApp->activeWindow());
        selectPerlLibDialog.setFileMode(QFileDialog::AnyFile);
        selectPerlLibDialog.setViewMode(QFileDialog::Detail);
        selectPerlLibDialog.setWindowModality(Qt::WindowModal);
        QString perlLibFolderName = selectPerlLibDialog
                .getExistingDirectory(
                    qApp->activeWindow(),
                    tr("Select PERLLIB"),
                    QDir::currentPath());
        selectPerlLibDialog.close();
        selectPerlLibDialog.deleteLater();

        if (perlLibFolderName.length() > 0) {
            // Save PERLLIB setting in the settings file:
            QSettings perlLibSetting((qApp->property("settingsFileName")
                                      .toString()),
                                     QSettings::IniFormat);
            perlLibSetting.setValue("browser_perl/perllib", perlLibFolderName);
            perlLibSetting.sync();

            // Set global PERLIB setting:
            qApp->setProperty("perlLib", perlLibFolderName);

            // JavaScript bridge back to the settings page:
            QString javaScript =
                    "document.getElementById(\"setting-perllib\")"
                    ".innerHTML = \"" + perlLibFolderName + "\";";
            currentFrame()->evaluateJavaScript(javaScript);

            qDebug() << "Selected PERLLIB:" << perlLibFolderName;
            qDebug() << "===============";
        }

        return false;
    }

    // Select folder to add to the PATH environment variable:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            request.url().fileName() == "path.setting" and
            request.url().query() == ("action=add")) {

        QFileDialog addToPathDialog (qApp->activeWindow());
        addToPathDialog.setFileMode(QFileDialog::AnyFile);
        addToPathDialog.setViewMode(QFileDialog::Detail);
        addToPathDialog.setWindowModality(Qt::WindowModal);
        QString pathFolderString = addToPathDialog.getExistingDirectory(
                    qApp->activeWindow(),
                    tr("Select folder to add to PATH"),
                    QDir::currentPath());
        addToPathDialog.close();
        addToPathDialog.deleteLater();

        qDebug() << "Folder to add to PATH:" << pathFolderString;
        qDebug() << "===============";

        // Get the list of all folders on the current PATH:
        QStringList oldPathList =
                qApp->property("pathToAddList").toStringList();

        QStringList pathList;
        foreach (QString pathEntry, oldPathList) {
            pathList.append(pathEntry);
        }

        // Append the new folder name to the list of current PATH folders:
        pathList.append(pathFolderString);

        // Save the new PATH folders list in the global settings:
        qApp->setProperty("pathToAddList", pathList);

        // Open the settings file:
        QSettings pathFoldersSetting((qApp->property("settingsFileName")
                                      .toString()),
                                     QSettings::IniFormat);

        // Get the size of the PATH array in the settings file:
        int pathArraySize = pathFoldersSetting
                .beginReadArray("browser_perl/path");
         pathFoldersSetting.endArray();

        // Append the new folder name in the
        // appropriate section of the settings file:
        pathFoldersSetting.beginWriteArray("browser_perl/path");
        pathFoldersSetting.setArrayIndex(pathArraySize);
        pathFoldersSetting.setValue("name", pathFolderString);
        pathFoldersSetting.endArray();

        // Define separator between PATH folders:
        QString pathSeparator;
#if defined (Q_OS_LINUX) or defined (Q_OS_MAC) // Linux and Mac
        pathSeparator = ":";
#endif
#ifdef Q_OS_WIN // Windows
        pathSeparator = ";";
#endif

        // Put the new folder name on PATH:
        QByteArray path;
        foreach (QString pathEntry, pathList) {
            path.append(pathEntry);
            path.append(pathSeparator);
        }

        // Insert the new PATH variable into
        // the script environment of the current page:
#ifndef Q_OS_WIN // Unix-based or similar operating systems
        scriptEnvironment.insert("PATH", path);
#else // Windows
        scriptEnvironment.insert("Path", path);
#endif

        // Display the newly created PATH list on the settings page:
        QString pathToDisplay;
        foreach (QString pathEntry, pathList) {
            pathToDisplay.append(pathEntry);
            pathToDisplay.append("<br>");
        }
        pathToDisplay.replace(QRegExp("<br>$"), "");
        if (pathToDisplay.length() > 0) {
            QString javaScript =
                    "document.getElementById(\"setting-path\")"
                    ".innerHTML = \"" + pathToDisplay + "\";";
            currentFrame()->evaluateJavaScript(javaScript);
        } else {
            QString javaScript =
                    "document.getElementById(\"setting-path\")"
                    ".innerHTML = \"none\";";
            currentFrame()->evaluateJavaScript(javaScript);
        }

        return false;
    }

    // SET DEFAULT THEME:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            request.url().fileName() == "theme.function") {

        QString theme = request.url().query()
                .replace("theme=", "");

        qThemeSetterSlot(theme);

        return false;
    }

    // OPEN FILES AND FOLDERS:
    // Invoke 'Open file' dialog from URL:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            request.url().fileName() == "open-file.function") {

        QString target = request.url().query().replace("target=", "");

        QFileDialog openFileDialog (qApp->activeWindow());
        openFileDialog.setFileMode(QFileDialog::AnyFile);
        openFileDialog.setViewMode(QFileDialog::Detail);
        openFileDialog.setWindowModality(Qt::WindowModal);
        QString fileNameToOpenString = openFileDialog.getOpenFileName(
                    qApp->activeWindow(), tr("Select File"),
                    QDir::currentPath(), tr("All files (*)"));
        openFileDialog.close();
        openFileDialog.deleteLater();

        if (!fileNameToOpenString.isEmpty()) {
            QByteArray fileName;
            fileName.append(fileNameToOpenString);
            scriptEnvironment.insert("FILE_TO_OPEN", fileName);

            // JavaScript bridge back to the HTML page where request originated:
            QString javaScript = "document.getElementById(\"" +
                    target + "\").innerHTML = \"" +
                    fileNameToOpenString + "\"; null";
            currentFrame()->evaluateJavaScript(javaScript);

            qDebug() << "File to open:" << QDir::toNativeSeparators(fileName);
            qDebug() << "===============";
        }

        return false;
    }

    // Invoke 'New file' dialog from URL:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            request.url().fileName() == "new-file.function") {

        QString target = request.url().query().replace("target=", "");

        QFileDialog newFileDialog (qApp->activeWindow());
        newFileDialog.setFileMode(QFileDialog::AnyFile);
        newFileDialog.setViewMode(QFileDialog::Detail);
        newFileDialog.setWindowModality(Qt::WindowModal);
        QString fileNameToCreateString = newFileDialog.getSaveFileName(
                    qApp->activeWindow(),
                    tr("Create New File"),
                    QDir::currentPath(),
                    tr("All files (*)"));
        newFileDialog.close();
        newFileDialog.deleteLater();

        if (!fileNameToCreateString.isEmpty()) {
            QByteArray fileName;
            fileName.append(fileNameToCreateString);
            scriptEnvironment.insert("FILE_TO_CREATE", fileName);

            // JavaScript bridge back to the HTML page where request originated:
            QString javaScript = "document.getElementById(\"" +
                    target + "\").innerHTML = \"" +
                    fileNameToCreateString + "\"; null";
            currentFrame()->evaluateJavaScript(javaScript);

            qDebug() << "New file:" << QDir::toNativeSeparators(fileName);
            qDebug() << "===============";
        }

        return false;
    }

    // Invoke 'Open folder' dialog from URL:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            request.url().fileName() == "open-folder.function") {

        QString target = request.url().query().replace("target=", "");

        QFileDialog openFolderDialog (qApp->activeWindow());
        openFolderDialog.setFileMode(QFileDialog::AnyFile);
        openFolderDialog.setViewMode(QFileDialog::Detail);
        openFolderDialog.setWindowModality(Qt::WindowModal);
        QString folderNameToOpenString = openFolderDialog.getExistingDirectory(
                    qApp->activeWindow(),
                    tr("Select Folder"),
                    QDir::currentPath());
        openFolderDialog.close();
        openFolderDialog.deleteLater();

        if (!folderNameToOpenString.isEmpty()) {
            QByteArray folderName;
            folderName.append(folderNameToOpenString);
            scriptEnvironment.insert("FOLDER_TO_OPEN", folderName);

            // JavaScript bridge back to the HTML page where request originated:
            QString javaScript = "document.getElementById(\"" +
                    target + "\").innerHTML = \"" +
                    folderNameToOpenString + "\"; null";
            currentFrame()->evaluateJavaScript(javaScript);

            qDebug() << "Folder to open:"
                     << QDir::toNativeSeparators(folderName);
            qDebug() << "===============";
        }

        return false;
    }

    // PRINTING:
#ifndef QT_NO_PRINTER
    // Print preview from URL:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            request.url().fileName() == "print.function" and
            request.url().query() == ("action=preview")) {

        emit printPreviewSignal();

        return false;
    }

    // Print page from URL:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            request.url().fileName() == "print.function" and
            request.url().query() == ("action=print")) {

        emit printSignal();

        return false;
    }

    // Save as PDF from URL:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            request.url().fileName() == "print.function" and
            request.url().query() == ("action=pdf")) {

        emit saveAsPdfSignal();

        return false;
    }
#endif

    // PERL DEBUGGER INTERACTION:
    // Implementation of an idea proposed by Valcho Nedelchev.
    if (PERL_DEBUGGER_INTERACTION == 1) {
        if ((navigationType == QWebPage::NavigationTypeLinkClicked or
             navigationType == QWebPage::NavigationTypeFormSubmitted) and
                request.url().fileName() == "perl-debugger.function") {
                targetFrame = frame;

            // Select a Perl script for debugging:
            if (request.url().query().contains("action=select-file")) {

                QFileDialog selectScriptToDebugDialog (qApp->activeWindow());
                selectScriptToDebugDialog
                        .setFileMode(QFileDialog::ExistingFile);
                selectScriptToDebugDialog.setViewMode(QFileDialog::Detail);
                selectScriptToDebugDialog.setWindowModality(Qt::WindowModal);
                selectScriptToDebugDialog.setWindowIcon(icon);
                debuggerScriptToDebug = selectScriptToDebugDialog
                        .getOpenFileName
                        (qApp->activeWindow(),
                         tr("Select Perl File"),
                         QDir::currentPath(),
                         tr("Perl scripts (*.pl);;")
                         + tr("Perl modules (*.pm);;")
                         + tr("All files (*)"));
                selectScriptToDebugDialog.close();
                selectScriptToDebugDialog.deleteLater();

                if (debuggerScriptToDebug.length() > 1) {
                    qDebug() << "File to load in the Perl Debugger:"
                             << debuggerScriptToDebug;
                    qDebug() << "===============";

                    // Get Perl debugger command (if any):
                    debuggerLastCommand = request.url().query().toLatin1()
                            .replace("action=select-file", "")
                            .replace("&command=", "")
                            .replace("+", " ");

                    qDebug() << "Debugger command:"
                             << debuggerLastCommand;
                    qDebug() << "===============";

                    // Close any still open Perl debugger session:
                    debuggerHandler.close();

                    // Start the Perl debugger:
                    qStartPerlDebuggerSlot();
                    return false;
                } else {
                    return false;
                }
            }
            // Get Perl debugger command:
            debuggerLastCommand = request.url().query().toLatin1()
                    .replace("command=", "")
                    .replace("+", " ");

            qDebug() << "Debugger command:"
                     << debuggerLastCommand;
            qDebug() << "===============";

            qStartPerlDebuggerSlot();
            return false;
        }
    }

    // OPEN LOCAL CONTENT:
    QFileDetector fileDetector;

    // Open local content in the same window:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            request.url().authority() == PSEUDO_DOMAIN and
            (!request.url().path().contains("ajax")) and
            (QPage::mainFrame()->childFrames().contains(frame) or
             QPage::mainFrame()->childFrames().isEmpty())) {

        // Start local script in the same window:
        if (request.url().path()
                .contains(fileDetector.plExtension)) {
            targetFrame = frame;

            QByteArray emptyPostDataArray;
            qStartScriptSlot(request.url(), emptyPostDataArray);
            return false;
        }

        // Load local HTML page in the same window:
        if (request.url().path()
                .contains(fileDetector.htmlExtensions)) {

            QString relativeFilePath = request.url().path();
            QString fullFilePath =
                    QDir::toNativeSeparators(
                        (qApp->property("rootDirName").toString())
                        + relativeFilePath);
            QFileDetector fileDetector;
            fileDetector.qCheckFileExistence(fullFilePath);

            frame->load(QUrl::fromLocalFile(fullFilePath));

            return false;
        }
    }

    // Load local HTML page in a new window:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            request.url().authority() == PSEUDO_DOMAIN and
            (!request.url().path().contains("ajax")) and
            (!QPage::mainFrame()->childFrames().contains(frame))) {

        if (request.url().path()
                .contains(fileDetector.htmlExtensions)) {
            qDebug() << "Local HTML page in a new window:"
                     << request.url().toString();
            qDebug() << "===============";

            QString relativeFilePath = request.url().path();
            QString fullFilePath =
                    QDir::toNativeSeparators(
                        (qApp->property("rootDirName").toString())
                        + relativeFilePath);
            QFileDetector fileDetector;
            fileDetector.qCheckFileExistence(fullFilePath);

            newWindow = new QWebViewWindow();
            QString iconPathName = qApp->property("iconPathName").toString();
            QPixmap icon;
            icon.load(iconPathName);
            newWindow->setWindowIcon(icon);
            newWindow->setAttribute(Qt::WA_DeleteOnClose, true);

            newWindow->load(QUrl::fromLocalFile(fullFilePath));

            newWindow->show();
            return false;
        }
    }

    // OPEN NETWORK CONTENT:
    // Open network content in the same window:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            QPage::mainFrame()->childFrames().contains(frame) and
            (request.url().authority() != PSEUDO_DOMAIN)) {

        qDebug() << "Network link:" << request.url().toString();
        qDebug() << "===============";

        QPage::currentFrame()->load(request.url());

        return false;
    }

    // Open network content in a new window:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            (!QPage::mainFrame()->childFrames().contains(frame)) and
            (request.url().authority() != PSEUDO_DOMAIN)) {

        qDebug() << "Network link in a new window:" << request.url().toString();
        qDebug() << "===============";

        newWindow = new QWebViewWindow();
        QString iconPathName = qApp->property("iconPathName").toString();
        QPixmap icon;
        icon.load(iconPathName);
        newWindow->setWindowIcon(icon);
        newWindow->setAttribute(Qt::WA_DeleteOnClose, true);
        newWindow->setUrl(request.url());
        newWindow->show();

        return false;
    }

    return QWebPage::acceptNavigationRequest(frame, request, navigationType);
}
