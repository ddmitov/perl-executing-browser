/*
 Perl Executing Browser, v. 0.1

 This program is free software;
 you can redistribute it and/or modify it under the terms of the
 GNU General Public License, as published by the Free Software Foundation;
 either version 3 of the License, or (at your option) any later version.
 This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
 without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 Dimitar D. Mitov, 2013 - 2015, ddmitov (at) yahoo (dot) com
 Valcho Nedelchev, 2014 - 2015
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
#if QT_VERSION >= 0x050000
// Qt5 code:
void customMessageHandler(QtMsgType type, const QMessageLogContext &context,
                          const QString &message)
{
    Q_UNUSED(context);
#else
// Qt4 code:
void customMessageHandler(QtMsgType type, const char *message)
{
#endif
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
#if QT_VERSION >= 0x050000
    QTextCodec::setCodecForLocale(QTextCodec::codecForName("UTF8"));
#else
    QTextCodec::setCodecForCStrings(QTextCodec::codecForName("UTF8"));
#endif

    // ==============================
    // GET COMMAND LINE ARGUMENTS:
    // ==============================
    QStringList commandLineArguments = QCoreApplication::arguments();
    QString allArguments;
    foreach (QString argument, commandLineArguments){
        allArguments.append(argument);
        allArguments.append(" ");
    }
    allArguments.replace(QRegExp("\\s$"), "");

    // ==============================
    // DISPLAY COMMAND LINE HELP:
    // ==============================
    foreach (QString argument, commandLineArguments){
        if (argument.contains("--help") or argument.contains("-H")) {
#ifndef Q_OS_WIN
            // Linux & Mac:
            std::cout << " " << std::endl;
            std::cout << application.applicationName().toLatin1().constData()
                      << " v." << application.applicationVersion()
                         .toLatin1().constData()
                      << std::endl;
            std::cout << "Application file path: "
                      << QDir::toNativeSeparators(
                             QApplication::applicationFilePath())
                         .toLatin1().constData()
                      << std::endl;
            std::cout << "Qt WebKit version: "
                      << QTWEBKIT_VERSION_STR << std::endl;
            std::cout << "Qt version: " << QT_VERSION_STR << std::endl;
            std::cout << " " << std::endl;
            std::cout << "Usage:" << std::endl;
            std::cout << "  peb --option=value -o=value" << std::endl;
            std::cout << " " << std::endl;
            std::cout << "Command line options:" << std::endl;
            std::cout << "  --fullscreen    -F    "
                      << "start browser in fullscreen mode"
                      << std::endl;
            std::cout << "  --maximized     -M    "
                      << "start browser in a maximized window"
                      << std::endl;
            std::cout << "  --help          -H    this help"
                      << std::endl;
            std::cout << " " << std::endl;
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
        std::cout << " " << std::endl;
        std::cout << application.applicationName().toLatin1().constData()
                  << " v." << application.applicationVersion()
                     .toLatin1().constData()
                  << std::endl;
        std::cout << "Application file path: "
                  << QDir::toNativeSeparators(
                          QApplication::applicationFilePath())
                      .toLatin1().constData()
                  << std::endl;
        std::cout << "Command line: "
                  << allArguments.toLatin1().constData() << std::endl;
        std::cout << "Qt WebKit version: " << QTWEBKIT_VERSION_STR << std::endl;
        std::cout << "Qt version: " << QT_VERSION_STR << std::endl;
        std::cout << "License: " << QLibraryInfo::licensedProducts()
                     .toLatin1().constData() << std::endl;
        std::cout << "Libraries Path: "
                  << QLibraryInfo::location(QLibraryInfo::LibrariesPath)
                     .toLatin1().constData() << std::endl;

        // Prevent starting as root from command line:
        if (userEuid == 0) {
            std::cout << "Started from terminal with root privileges. Aborting!"
                      << std::endl;
            std::cout << " " << std::endl;
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
        QString text = (QApplication::tr("Browser was started as root.<br>")
                        + QApplication::tr("This is not a good idea!<br>")
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
    // CREATE TEMPORARY FOLDERS:
    // ==============================
    // Create the main temporary folder for the current browser session:
    QString applicationTempDirectoryName = QDir::tempPath() + QDir::separator()
            + applicationBinaryName + "--" + applicationStartDateAndTime;
    application
            .setProperty("applicationTempDirectory",
                         applicationTempDirectoryName);
    QDir applicationTempDirectory(applicationTempDirectoryName);
    applicationTempDirectory.mkpath(".");

    // Create the output directory:
    QString applicationOutputDirectoryName = QDir::tempPath()
            + QDir::separator()
            + applicationBinaryName + "--" + applicationStartDateAndTime
            + QDir::separator() + "output";
    application
            .setProperty("applicationOutputDirectory",
                         applicationOutputDirectoryName);
    QDir applicationOutputDirectory(applicationOutputDirectoryName);
    applicationOutputDirectory.mkpath(".");

    // ==============================
    // EXTRACT ROOT FOLDER FROM A ZIP PACKAGE:
    // ==============================
    QStringList extractedFiles;
#if ZIP_SUPPORT == 1
    QString defaultZipPackageName = QApplication::applicationDirPath()
            + QDir::separator() + "default.peb";
    QFile defaultZipPackage(defaultZipPackageName);

    if (defaultZipPackage.exists()) {
        // Extracting root folder from a separate zip file:
        extractedFiles = JlCompress::extractDir (
                    QApplication::applicationDirPath()
                    + QDir::separator() + "default.peb",
                    applicationTempDirectoryName);

        // Extracting root folder from a zip file,
        // that was appended to the binary (!) using
        // 'cat peb-bin-only peb.zip > peb-with-data'
//        extractedFiles = JlCompress::extractDir (
//                    QApplication::applicationFilePath(),
//                    applicationTempDirectoryName);

        // Settings file from the extracted ZIP package:
        settingsDirName = applicationTempDirectoryName
                + QDir::separator() + "root";
        settingsFileName = settingsDirName + QDir::separator()
                + applicationBinaryName + ".ini";
    }
#endif

#if ZIP_SUPPORT == 2
    QString defaultZipPackageName = QApplication::applicationDirPath()
            + QDir::separator() + "default.peb";
    QFile defaultZipPackage(defaultZipPackageName);

    if (defaultZipPackage.exists()) {
        QProcess unzipper;
        unzipper.start("/usr/bin/unzip",
                       QStringList() << defaultZipPackageName
                       << "-d"
                       << applicationTempDirectoryName);
        if (!unzipper.waitForFinished())
                return false;

        // Settings file from the extracted ZIP package:
        settingsDirName = applicationTempDirectoryName
                + QDir::separator() + "root";
        settingsFileName = settingsDirName + QDir::separator()
                + applicationBinaryName + ".ini";
    }
#endif

    // ==============================
    // MANAGE APPLICATION SETTINGS:
    // ==============================
    // Settings file from the directory of the binary file
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
    QFile settingsFile(settingsFileName);

    // Check if settings file exists:
    if (!settingsFile.exists()) {
        QString title = (QApplication::tr("Missing configuration file"));
        QString text = (QApplication::tr("Configuration file<br>")
                        + settingsFileName
                        + QMessageBox::tr("<br>is missing.<br>")
                        + QMessageBox::tr("Please restore it."));
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

    // ROOT DIRECTORY SETTING:
    QString rootDirName;
    QString rootDirNameSetting = settings.value("root/root").toString();
    if (rootDirNameSetting == "current") {
        rootDirName = settingsDirName;
    } else {
        rootDirName = QDir::toNativeSeparators(rootDirNameSetting);
    }
    if (!rootDirName.endsWith(QDir::separator())) {
        rootDirName.append(QDir::separator());
    }
    application.setProperty("rootDirName", rootDirName);

    // PERL SCRIPT SETTINGS:
    // Folders to add to PATH:
    QStringList pathToAddList;
    int pathSize = settings.beginReadArray("perl/path");
    for (int index = 0; index < pathSize; ++index) {
        settings.setArrayIndex(index);
        QString pathSetting = settings.value("name").toString();
        pathToAddList.append(pathSetting);
    }
    settings.endArray();
    application.setProperty("pathToAddList", pathToAddList);

    // Perl interpreter:
    QString perlInterpreterSetting = settings.value("perl/perl").toString();
    QDir interpreterFile(perlInterpreterSetting);
    QString perlInterpreter;
    if (interpreterFile.isRelative()) {
        perlInterpreter =
                QDir::toNativeSeparators(rootDirName + perlInterpreterSetting);
    }
    if (interpreterFile.isAbsolute()) {
        perlInterpreter = QDir::toNativeSeparators(perlInterpreterSetting);
    }
    application.setProperty("perlInterpreter", perlInterpreter);

    // PERLLIB environment variable:
    QString perlLibSetting = settings.value("perl/perllib").toString();
    QDir perlLibDir(perlLibSetting);
    QString perlLib;
    if (perlLibDir.isRelative()) {
        perlLib = QDir::toNativeSeparators(rootDirName + perlLibSetting);
    }
    if (perlLibDir.isAbsolute()) {
        perlLib = QDir::toNativeSeparators(perlLibSetting);
    }
    application.setProperty("perlLib", perlLib);

    // Perl debugger output formatter:
    QString debuggerOutputFormatter;
    if (PERL_DEBUGGER_INTERACTION == 1) {
        QString debuggerOutputFormatterSetting = settings.value(
                    "perl/perl_debugger_output_formatter").toString();
        QFileInfo debuggerOutputFormatterFile(debuggerOutputFormatterSetting);
        if (debuggerOutputFormatterFile.isRelative()) {
            debuggerOutputFormatter = QDir::toNativeSeparators(
                        rootDirName + debuggerOutputFormatterSetting);
        }
        if (debuggerOutputFormatterFile.isAbsolute()) {
            debuggerOutputFormatter =
                    QDir::toNativeSeparators(debuggerOutputFormatterSetting);
        }
        application.setProperty("debuggerOutputFormatter",
                                debuggerOutputFormatter);
    }

    // Display or hide STDERR from scripts:
    QString displayStderr =
            settings.value("perl/perl_display_stderr").toString();
    application.setProperty("displayStderr", displayStderr);

    // Timeout for CGI scripts (not long-running ones):
    QString scriptTimeout =
            settings.value("perl/perl_script_timeout").toString();
    application.setProperty("scriptTimeout", scriptTimeout);

    // Source viewer script path:
    QString sourceViewerSetting =
            settings.value("perl/perl_source_viewer").toString();
    QFileInfo sourceViewerFile(sourceViewerSetting);
    QString sourceViewer;
    if (sourceViewerFile.isRelative()) {
        sourceViewer = QDir::toNativeSeparators(
                    rootDirName + sourceViewerSetting);
    }
    if (sourceViewerFile.isAbsolute()) {
        sourceViewer = QDir::toNativeSeparators(sourceViewerSetting);
    }
    application.setProperty("sourceViewer", sourceViewer);

    // Optional source viewer command line arguments.
    // They will be given to the source viewer
    // whenever it is started by the browser.
    QString sourceViewerArgumentsSetting =
            settings.value("perl/perl_source_viewer_arguments").toString();
    sourceViewerArgumentsSetting.replace("\n", "");
    QStringList sourceViewerArguments;
    sourceViewerArguments = sourceViewerArgumentsSetting.split(" ");
    application.setProperty("sourceViewerArgumentsSetting",
                            sourceViewerArguments);

    // NETWORKING:
    // User agent:
    QString userAgent = settings.value("networking/user_agent").toString();
    application.setProperty("userAgent", userAgent);

    // Allowed domains:
    QStringList allowedDomainsList;
    int domainsSize = settings.beginReadArray("networking/allowed_domains");
    for (int index = 0; index < domainsSize; ++index) {
        settings.setArrayIndex(index);
        QString pathSetting = settings.value("name").toString();
        allowedDomainsList.append(pathSetting);
    }
    settings.endArray();
    application.setProperty("allowedDomainsList", allowedDomainsList);

    // GUI:
    // Start page - path must be relative to the PEB root directory:
    // HTML file or script are equally usable as a start page:
    QString startPagePath = settings.value("gui/start_page").toString();
    QString startPage;

    if (startPagePath.length() > 0) {
        startPage = QDir::toNativeSeparators(rootDirName + startPagePath);
        application.setProperty("startPagePath", startPagePath);
        application.setProperty("startPage", startPage);
    }

    // Check if start page exists:
    QFile startPageFile(startPage);
    if (!startPageFile.exists()) {
        QString title = (QApplication::tr("Missing start page"));
        QString text = (QApplication::tr("Start page is missing.<br>")
                        + QApplication::tr("Please select a start page."));
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
    QString warnOnExit = settings.value("gui/warn_on_exit") .toString();
    application.setProperty("warnOnExit", warnOnExit);

    // Window size - 'maximized', 'fullscreen' or numeric value like
    // '800x600' or '1024x756' etc.:
    QString windowSize = settings.value("gui/window_size").toString();
    int fixedWidth;
    int fixedHeight;
    if (windowSize != "maximized" or windowSize != "fullscreen") {
        fixedWidth = windowSize.section("x", 0, 0) .toInt();
        fixedHeight = windowSize.section("x", 1, 1) .toInt();
        application.setProperty("fixedWidth", fixedWidth);
        application.setProperty("fixedHeight", fixedHeight);
    }
    application.setProperty("windowSize", windowSize);

    // Stay on top of all other windows enable/disable switch:
    QString stayOnTop = settings.value("gui/stay_on_top") .toString();
    application.setProperty("stayOnTop", stayOnTop);

    // Browser title -'dynamic' or 'My Favorite Title'
    // 'dynamic' title is taken from every HTML <title> tag.
    QString browserTitle = settings.value("gui/browser_title").toString();
    application.setProperty("browserTitle", browserTitle);

    // Right click context menu enable/disable switch:
    QString contextMenu = settings.value("gui/context_menu").toString();
    application.setProperty("contextMenu", contextMenu);

    // Keyboard shortcut for going to start page enable/disable switch:
    QString keyboardShortcutGoHome =
            settings.value("gui/keyboard_shortcut_go_home").toString();
    application.setProperty("keyboardShortcutGoHome", keyboardShortcutGoHome);

    // Keyboard shortcut for page reload enable/disable switch:
    QString keyboardShortcutReload =
            settings.value("gui/keyboard_shortcut_reload").toString();
    application.setProperty("keyboardShortcutReload", keyboardShortcutReload);

    // Web Inspector from context menu enable/disable switch:
    QString webInspector = settings.value("gui/web_inspector").toString();
    application.setProperty("webInspector", webInspector);

    // Icon for windows and message boxes:
    QString iconPathNameSetting = settings.value("gui/icon").toString();
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
    QString qtStyleSetting = settings.value("gui/qt_style").toString();
    QString qtStyle;
    QStringList availableStyles = QStyleFactory::keys();
    foreach (QString availableStyle, availableStyles) {
        if (availableStyle == qtStyleSetting) {
            qtStyle = availableStyle;
            application.setStyle(QStyleFactory::create(qtStyle));
        }
    }

    // System tray icon enable/disable switch:
    QString systrayIcon = settings.value("gui/systray_icon").toString();
    application.setProperty("systrayIcon", systrayIcon);

    // System tray icon file:
    // This setting was created to circumvent Qt bug QTBUG-35832 -
    // inability to display transparent background of
    // system tray icons in Qt5 on Linux.
    // An icon without a transparent background should be used as
    // a systray icon when the binary is compiled using Qt5 for Linux.
    QString systrayIconPathNameSetting =
            settings.value("gui/systray_icon_file").toString();
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

    // Name of the default GUI theme:
    QString defaultTheme = settings.value("gui/theme_default").toString();
    application.setProperty("defaultTheme", defaultTheme);

    // Directory of the default GUI theme:
    QString defaultThemeDirectorySetting =
            settings.value("gui/theme_default_directory").toString();
    application.setProperty("defaultThemeDirectoryName",
                            defaultThemeDirectorySetting);
    QString defaultThemeDirectory = QDir::toNativeSeparators(
                rootDirName + defaultThemeDirectorySetting);
    application.setProperty("defaultThemeDirectoryFullPath",
                            defaultThemeDirectory);

    // Directory for all GUI themes:
    QString allThemesDirectorySetting =
            settings.value("gui/themes_directory").toString();
    QString allThemesDirectory;
    QDir allThemesDir(allThemesDirectorySetting);
    if (allThemesDir.isRelative()) {
        allThemesDirectory =
                QDir::toNativeSeparators(rootDirName
                                         + allThemesDirectorySetting);
    }
    if (allThemesDir.isAbsolute()) {
        allThemesDirectory =
                QDir::toNativeSeparators(allThemesDirectorySetting);
    }
    application.setProperty("allThemesDirectory", allThemesDirectory);

    // Check if default theme file exists, if not - copy it from themes folder:
    if (!QFile::exists(defaultThemeDirectory
                       + QDir::separator()
                       + "current.css")) {
        QFile::copy(allThemesDirectory + QDir::separator() + defaultTheme,
                    defaultThemeDirectory + QDir::separator() + "current.css");
    }

    // Default translation:
    QString defaultTranslation =
            settings.value("gui/translation_default").toString();
    application.setProperty("defaultTranslation", defaultTranslation);

    // Directory for all translations:
    QString allTranslationsDirectorySetting =
            settings.value("gui/translations_directory").toString();
    QDir translationsDir(allTranslationsDirectorySetting);
    QString allTranslationsDirectory;
    if (translationsDir.isRelative()) {
        allTranslationsDirectory = QDir::toNativeSeparators(
                    rootDirName + allTranslationsDirectorySetting);
    }
    if (translationsDir.isAbsolute()) {
        allTranslationsDirectory =
                QDir::toNativeSeparators(allTranslationsDirectorySetting);
    }
    application.setProperty("allTranslationsDirectory",
                            allTranslationsDirectory);

    // Install default translation, if any:
    QTranslator translator;
    if (defaultTranslation != "none") {
        translator.load(defaultTranslation, allTranslationsDirectory);
    }
    application.installTranslator(&translator);

    // Help directory:
    QString helpDirectorySetting =
            settings.value("gui/help_directory").toString();
    QDir helpDir(helpDirectorySetting);
    QString helpDirectory;
    if (helpDir.isRelative()) {
        helpDirectory =
                QDir::toNativeSeparators(rootDirName + helpDirectorySetting);
    }
    if (helpDir.isAbsolute()) {
        helpDirectory = QDir::toNativeSeparators(helpDirectorySetting);
    }
    application.setProperty("helpDirectory", helpDirectory);

    // LOGGING:
    // Logging enable/disable switch:
    QString logging = settings.value("logging/logging").toString();
    application.setProperty("logging", logging);

    // Install message handler for redirecting all debug messages to a log file:
    if ((qApp->property("logging").toString()) == "enable") {
#if QT_VERSION >= 0x050000
        // Qt5 code:
        qInstallMessageHandler(customMessageHandler);
#else
        // Qt4 code:
        qInstallMsgHandler(customMessageHandler);
#endif
    }

    // Logging mode - 'per_session_file' or 'single_file'.
    // 'single_file' means that only one single log file is created.
    // 'per_session' means that a separate log file is
    // created for every browser session. Application start date and time are
    // appended to the file name in this scenario.
    QString logMode = settings.value("logging/logging_mode").toString();
    application.setProperty("logMode", logMode);

    // Log files directory:
    QString logDirName = settings.value("logging/logging_directory").toString();
    QDir logDir(logDirName);
    QString logDirFullPath;
    if (!logDir.exists()) {
        logDir.mkpath(".");
    }
    if (logDir.isRelative()) {
        logDirFullPath = QDir::toNativeSeparators(rootDirName + logDirName);
    }
    if (logDir.isAbsolute()) {
        logDirFullPath = QDir::toNativeSeparators(logDirName);
    }
    application.setProperty("logDirFullPath", logDirFullPath);

    // Log filename prefix:
    QString logPrefix = settings.value("logging/logging_prefix").toString();
    application.setProperty("logPrefix", logPrefix);

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
        if (argument.contains("--maximized") or argument.contains("-M")) {
            fixedWidth = 1;
            fixedHeight = 1;
            windowSize = "maximized";
            application.setProperty("windowSize", windowSize);
        }
    }

    // ==============================
    // LOG ALL SETTINGS:
    // ==============================
    // Log basic program information:
    qDebug() << "";
    qDebug() << application.applicationName().toLatin1().constData()
             << "version"
             << application.applicationVersion().toLatin1().constData()
             << "started.";
    qDebug() << "Application file path:"
             << QDir::toNativeSeparators(QApplication::applicationFilePath())
                .toLatin1().constData();
    qDebug() << "Command line:" << allArguments.toLatin1().constData();
    qDebug() << "Qt WebKit version:" << QTWEBKIT_VERSION_STR;
    qDebug() << "Qt version:" << QT_VERSION_STR;
    qDebug() << "License:"
             << QLibraryInfo::licensedProducts().toLatin1().constData();
    qDebug() << "Libraries Path:"
             << QLibraryInfo::location(QLibraryInfo::LibrariesPath)
                .toLatin1().constData();
    qDebug() << "";

    qDebug() << "===============";
    qDebug() << "BASIC SETTINGS:";
    qDebug() << "===============";
    qDebug() << "Root folder:" << QDir::toNativeSeparators(rootDirName);
    qDebug() << "Temporary folder:" << applicationTempDirectoryName;
    qDebug() << "Settings file name:" << settingsFileName;

    qDebug() << "===============";
    qDebug() << "PERL SETTINGS:";
    qDebug() << "===============";
    qDebug() << "Folders to add to PATH:";
    foreach (QString pathEntry, pathToAddList) {
        qDebug() << pathEntry;
    }
    qDebug() << "Perl interpreter" << perlInterpreter;
    qDebug() << "PERLLIB folder:" << perlLib;
    if (PERL_DEBUGGER_INTERACTION == 1) {
        qDebug() << "Debugger output formatter:" << debuggerOutputFormatter;
    }
    qDebug() << "Display STDERR from scripts:" << displayStderr;
    qDebug() << "Script Timeout:" << scriptTimeout;
    qDebug() << "Source viewer:" << sourceViewer;
    qDebug() << "Source viewer arguments:" << sourceViewerArguments;

    qDebug() << "===============";
    qDebug() << "NETWORKING SETTINGS:";
    qDebug() << "===============";
    qDebug() << "User Agent:" << userAgent;
    qDebug() << "Allowed domain names:";
    foreach (QString allowedDomainsListEntry, allowedDomainsList) {
        qDebug() << allowedDomainsListEntry;
    }

    qDebug() << "===============";
    qDebug() << "GUI SETTINGS:";
    qDebug() << "===============";
    qDebug() << "Start page:" << startPagePath;
    qDebug() << "Warn on exit:" << warnOnExit;
    // Get screen resolution:
    int screenWidth = QDesktopWidget().screen()->rect().width();
    int screenHeight = QDesktopWidget().screen()->rect().height();
    qDebug() << "Screen resolution:" << screenWidth << "x" << screenHeight;
    qDebug() << "Window size:" << windowSize;
    qDebug() << "Stay on top:" << stayOnTop;
    qDebug() << "Browser title:" << browserTitle;
    qDebug() << "Context menu:" << contextMenu;
    qDebug() << "Keyboard shortcut for going to start page:"
             << keyboardShortcutGoHome;
    qDebug() << "Keyboard shortcut for page reload:" << keyboardShortcutReload;
    qDebug() << "Windows and dialogs icon file:" << iconPathName;
    if (qtStyle.length() > 0) {
        qDebug() << "Global Qt style:" << qtStyle;
    }
    qDebug() << "Default theme:" << defaultTheme;
    qDebug() << "Default theme directory:" << defaultThemeDirectory;
    qDebug() << "All themes directory:" << allThemesDirectory;
    qDebug() << "Default translation:" << defaultTranslation;
    qDebug() << "Translations directory:" << allTranslationsDirectory;
    qDebug() << "Help and error messages directory:" << helpDirectory;
    qDebug() << "System tray icon switch:" << systrayIcon;
    qDebug() << "System tray icon file:" << systrayIconPathName;
    qDebug() << "Web Inspector from context menu:" << webInspector;

    qDebug() << "===============";
    qDebug() << "LOGGING SETTINGS:";
    qDebug() << "===============";
    qDebug() << "Logging:" << logging;
    qDebug() << "Logging mode:" << logMode;
    qDebug() << "Logfiles directory:" << logDirFullPath;
    qDebug() << "Logfiles prefix:" << logPrefix;
    qDebug() << "===============";

    if (extractedFiles.length() > 0) {
        qDebug() << "ZIP package found.";
        qDebug() << "Extracted directories and files:";
        foreach (QString extractedFile, extractedFiles) {
            qDebug() << extractedFile;
        }
        qDebug() << "===============";
    }

    // ==============================
    // MAIN GUI CLASS INITIALIZATION:
    // ==============================
    QTopLevel toplevel;

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

        QObject::connect(trayIcon.quitAction, SIGNAL(triggered()),
                         &toplevel, SLOT(qExitApplicationSlot()));

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
    // Regular expressions for file type detection by shebang line:
    perlShebang.setPattern("#!/.{1,}perl");

    // Regular expressions for file type detection by extension:
    htmlExtensions.setPattern("htm");
    htmlExtensions.setCaseSensitivity(Qt::CaseInsensitive);

    cssExtension.setPattern("css");
    cssExtension.setCaseSensitivity(Qt::CaseInsensitive);

    jsExtension.setPattern("js");
    jsExtension.setCaseSensitivity(Qt::CaseInsensitive);

    svgExtension.setPattern("svg");
    svgExtension.setCaseSensitivity(Qt::CaseInsensitive);

    ttfExtension.setPattern("ttf");
    ttfExtension.setCaseSensitivity(Qt::CaseInsensitive);

    eotExtension.setPattern("eot");
    eotExtension.setCaseSensitivity(Qt::CaseInsensitive);

    woff2Extension.setPattern("woff2");
    woff2Extension.setCaseSensitivity(Qt::CaseInsensitive);

    woffExtension.setPattern("woff");
    woffExtension.setCaseSensitivity(Qt::CaseInsensitive);

    pngExtension.setPattern("png");
    pngExtension.setCaseSensitivity(Qt::CaseInsensitive);

    jpgExtensions.setPattern("jpe{0,1}g");
    jpgExtensions.setCaseSensitivity(Qt::CaseInsensitive);

    gifExtension.setPattern("gif");
    gifExtension.setCaseSensitivity(Qt::CaseInsensitive);

    plExtension.setPattern("pl");
    plExtension.setCaseSensitivity(Qt::CaseInsensitive);
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

        QObject::connect(trayIcon,
                         SIGNAL(activated(QSystemTrayIcon::ActivationReason)),
                         this,
                         SLOT(qTrayIconActivatedSlot(
                                  QSystemTrayIcon::ActivationReason)));

        aboutAction = new QAction(tr("&About"), this);

        aboutQtAction = new QAction(tr("About Q&t"), this);
        QObject::connect(aboutQtAction, SIGNAL(triggered()),
                         qApp, SLOT(aboutQt()));

        quitAction = new QAction(tr("&Quit"), this);

        trayIconMenu = new QMenu();
        trayIcon->setContextMenu(trayIconMenu);
        trayIconMenu->addAction(aboutAction);
        trayIconMenu->addAction(aboutQtAction);
        trayIconMenu->addSeparator();
        trayIconMenu->addAction(quitAction);
        trayIcon->show();
    }
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

    // SAFE ENVIRONMENT FOR ALL LOCAL SCRIPTS:
    QStringList systemEnvironment =
            QProcessEnvironment::systemEnvironment().toStringList();

    foreach (QString environmentVariable, systemEnvironment) {
        QStringList environmentVariableList = environmentVariable.split("=");
        QString environmentVariableName = environmentVariableList.first();
        if (!allowedEnvironmentVariables.contains(environmentVariableName)) {
            scriptEnvironment.remove(environmentVariable);
        } else {
            scriptEnvironment.insert(
                        environmentVariableList.first(),
                        environmentVariableList[1]);
        }
    }

    // DOCUMENT_ROOT:
    scriptEnvironment.remove("DOCUMENT_ROOT");
    scriptEnvironment.insert("DOCUMENT_ROOT",
                             qApp->property("rootDirName").toString());

    // PERLLIB:
    scriptEnvironment.remove("PERLLIB");
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
        QDir pathDir(pathEntry);
        if (pathDir.exists()) {
            if (pathDir.isRelative()) {
                pathEntry = QDir::toNativeSeparators(
                            qApp->property("rootDirName").toString()
                            + pathEntry);
            }
            if (pathDir.isAbsolute()) {
                pathEntry = QDir::toNativeSeparators(pathEntry);
            }
            path.append(pathEntry);
            path.append(pathSeparator);
        }
    }

#ifndef Q_OS_WIN // Linux and Mac
    scriptEnvironment.remove("PATH");
    scriptEnvironment.insert("PATH", path);
#endif
#ifdef Q_OS_WIN // Windows
    scriptEnvironment.remove("Path");
    scriptEnvironment.insert("Path", path);
#endif

    // Source viewer mandatory, or minimal, command line:
    sourceViewerMandatoryCommandLine.append(
                (qApp->property("sourceViewer").toString()));
    if ((qApp->property("sourceViewerArguments").toStringList()).length() > 1) {
        foreach (QString argument,
                 (qApp->property("sourceViewerArguments").toStringList())) {
            sourceViewerMandatoryCommandLine.append(argument);
        }
    }

    runningScriptsInCurrentWindowList.clear();

    debuggerJustStarted = false;

    // Default frame for local content:
    targetFrame = QPage::mainFrame();

    // Icon for dialogs:
    icon.load(qApp->property("iconPathName").toString());

    // Internally compiled jQuery necessary for JavaScript bridges:
    QFile file;
    file.setFileName(":/scripts/jquery-1-11-1-min.js");
    file.open(QIODevice::ReadOnly);
    jQuery = file.readAll();
    file.close();

    jQuery.append("\n");
    jQuery.append("var qt = {'jQuery': jQuery.noConflict(true)};");
    jQuery.append("null");
}

// ==============================
// WEB VIEW CLASS CONSTRUCTOR:
// ==============================
QTopLevel::QTopLevel()
    : QWebView(0)
{
    // Configure keyboard shortcuts - main window:
    QShortcut *minimizeShortcut = new QShortcut(Qt::Key_Escape, this);
    QObject::connect(minimizeShortcut, SIGNAL(activated()),
                     this, SLOT(qMinimizeSlot()));

    QShortcut *maximizeShortcut = new QShortcut(QKeySequence("Ctrl+M"), this);
    QObject::connect(maximizeShortcut, SIGNAL(activated()),
                     this, SLOT(qMaximizeSlot()));

    QShortcut *toggleFullScreenShortcut = new QShortcut(Qt::Key_F11, this);
    QObject::connect(toggleFullScreenShortcut, SIGNAL(activated()),
                     this, SLOT(qToggleFullScreenSlot()));

    if ((qApp->property("keyboardShortcutGoHome").toString()) == "enable") {
        QShortcut *homeShortcut = new QShortcut(Qt::Key_F12, this);
        QObject::connect(homeShortcut, SIGNAL(activated()),
                         this, SLOT(qLoadStartPageSlot()));
    }

    if ((qApp->property("keyboardShortcutReload").toString()) == "enable") {
        QShortcut *reloadShortcut = new QShortcut(QKeySequence("Ctrl+R"), this);
        QObject::connect(reloadShortcut, SIGNAL(activated()),
                         this, SLOT(qReloadSlot()));
    }

    QShortcut *printShortcut = new QShortcut(QKeySequence("Ctrl+P"), this);
    QObject::connect(printShortcut, SIGNAL(activated()),
                     this, SLOT(qPrintSlot()));

    QShortcut *closeAppShortcut = new QShortcut(QKeySequence("Ctrl+Q"), this);
    QObject::connect(closeAppShortcut, SIGNAL(activated()),
                     this, SLOT(qExitApplicationSlot()));

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
    if ((qApp->property("stayOnTop").toString()) == "enable") {
        setWindowFlags(Qt::WindowStaysOnTopHint);
    }
    if ((qApp->property("browserTitle").toString()) != "dynamic") {
        setWindowTitle((qApp->property("browserTitle").toString()));
    }
    if ((qApp->property("contextMenu").toString()) == "disable") {
        setContextMenuPolicy(Qt::NoContextMenu);
    }

    mainPage = new QPage();

    QObject::connect(mainPage, SIGNAL(closeWindowSignal()),
                     this, SLOT(close()));

    // Connect signals and slots - main window:
    QObject::connect(mainPage, SIGNAL(displayErrorsSignal(QString)),
                     this, SLOT(qDisplayErrorsSlot(QString)));

    QObject::connect(this, SIGNAL(selectThemeSignal()),
                     mainPage, SLOT(qThemeSelectorSlot()));

    QObject::connect(mainPage, SIGNAL(printPreviewSignal()),
                     this, SLOT(qStartPrintPreviewSlot()));
    QObject::connect(mainPage, SIGNAL(printSignal()),
                     this, SLOT(qPrintSlot()));
    QObject::connect(mainPage, SIGNAL(saveAsPdfSignal()),
                     this, SLOT(qSaveAsPdfSlot()));

    QObject::connect(mainPage, SIGNAL(reloadSignal()),
                     this, SLOT(qReloadSlot()));

    QObject::connect(mainPage, SIGNAL(quitFromURLSignal()),
                     this, SLOT(qExitApplicationSlot()));

    if ((qApp->property("browserTitle").toString()) == "dynamic") {
        QObject::connect(mainPage, SIGNAL(loadFinished(bool)),
                         this, SLOT(qPageLoadedDynamicTitleSlot(bool)));
    }

    setPage(mainPage);

    // Use modified Network Access Manager with every window of the program:
    ModifiedNetworkAccessManager *networkAccessManager =
            new ModifiedNetworkAccessManager();
    mainPage->setNetworkAccessManager(networkAccessManager);

    QObject::connect(networkAccessManager,
                     SIGNAL(startScriptSignal(QUrl, QByteArray)),
                     mainPage,
                     SLOT(qStartScriptSlot(QUrl, QByteArray)));

    if (PERL_DEBUGGER_INTERACTION == 1) {
        QObject::connect(networkAccessManager,
                         SIGNAL(startPerlDebuggerSignal(QUrl)),
                         mainPage,
                         SLOT(qStartPerlDebuggerSlot(QUrl)));
    }

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
// MANAGE CLICKING OF LINKS:
// ==============================
bool QPage::acceptNavigationRequest(QWebFrame *frame,
                                   const QNetworkRequest &request,
                                   QWebPage::NavigationType navigationType)
{

    // Select folder to add to the PATH environment variable:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            request.url().scheme().contains("addtopath")) {

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

        // Open the settings file:
        QSettings pathFoldersSetting((qApp->property("settingsFileName")
                                      .toString()),
                                     QSettings::IniFormat);

        // Get list of all folders on the current PATH:
        QStringList currentPathList;
        int pathArraySize = pathFoldersSetting
                .beginReadArray("environment/path");
        for (int index = 0; index < pathArraySize; ++index) {
            pathFoldersSetting.setArrayIndex(index);
            QString pathSetting = pathFoldersSetting.value("name").toString();
            currentPathList.append(pathSetting);
        }
        pathFoldersSetting.endArray();

        // Append the new folder name to
        // the list of all folders on the current PATH:
        currentPathList.append(pathFolderString);

        // Append the new folder name in the
        // appropriate section of the settings file:
        pathFoldersSetting.beginWriteArray("environment/path");
        pathFoldersSetting.setArrayIndex(pathArraySize);
        pathFoldersSetting.setValue("name", pathFolderString);
        pathFoldersSetting.endArray();

        // Define separator between PATH folders:
        QByteArray path;
        QString pathSeparator;
#if defined (Q_OS_LINUX) or defined (Q_OS_MAC) // Linux and Mac
        pathSeparator = ":";
#endif
#ifdef Q_OS_WIN // Windows
        pathSeparator = ";";
#endif

        // Add all browser-specific folders to PATH,
        // but first check if these directories exist,
        // then resolve all relative paths, if any:
        foreach (QString pathEntry, currentPathList) {
            QDir pathDir(pathEntry);
            if (pathDir.exists()) {
                if (pathDir.isRelative()) {
                    pathEntry = QDir::toNativeSeparators(
                                (qApp->property("rootDirName").toString())
                                + pathEntry);
                }
                if (pathDir.isAbsolute()) {
                    pathEntry = QDir::toNativeSeparators(pathEntry);
                }
                path.append(pathEntry);
                path.append(pathSeparator);
            }
        }

        // Insert the new browser-specific PATH variable into
        // the environment of the browser and
        // all local scripts executed by the browser:
#ifndef Q_OS_WIN // Unix-based or similar operating systems
        qputenv("PATH", path);
        scriptEnvironment.insert("PATH", path);
#else // Windows
        qputenv("Path", path);
        scriptEnvironment.insert("Path", path);
#endif

        return false;
    }

    // Select Perl interpreter:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            request.url().scheme().contains("selectperl")) {

        QFileDialog selectPerlInterpreterDialog (qApp->activeWindow());
        selectPerlInterpreterDialog.setFileMode(QFileDialog::AnyFile);
        selectPerlInterpreterDialog.setViewMode(QFileDialog::Detail);
        selectPerlInterpreterDialog.setWindowModality(Qt::WindowModal);
        QString perlInterpreter = selectPerlInterpreterDialog.getOpenFileName
                (qApp->activeWindow(), tr("Select Perl Interpreter"),
                 QDir::currentPath(), tr("All files (*)"));
        selectPerlInterpreterDialog.close();
        selectPerlInterpreterDialog.deleteLater();

        if (perlInterpreter.length() > 0) {
            QSettings perlInterpreterSetting(
                        (qApp->property("settingsFileName").toString()),
                        QSettings::IniFormat);
            perlInterpreterSetting.setValue("interpreters/perl",
                                            perlInterpreter);
            perlInterpreterSetting.sync();

            qDebug() << "Selected Perl interpreter:" << perlInterpreter;

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

            QSettings perlLibSetting((qApp->property("settingsFileName").
                                      toString()),
                                     QSettings::IniFormat);
            perlLibSetting.setValue("environment/perllib", perlLibFolderName);
            perlLibSetting.sync();

            qDebug() << "Selected PERLLIB:" << perlLibFolderName;
            qDebug() << "===============";
        }

        return false;
    }

    // Set predefined theme:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            request.url().scheme().contains("settheme")) {

        QString theme = request.url()
                .toString(QUrl::RemoveScheme)
                .replace("//", "");

        qThemeSetterSlot(theme);

        return false;
    }


    // Select another theme:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            request.url().scheme().contains("selecttheme")) {

        qThemeSelectorSlot();

        return false;
    }

    // Invoke 'Open file' dialog from URL:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            request.url().scheme().contains("openfile")) {

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
            currentFrame()->evaluateJavaScript(jQuery);
            QString javaScript = "qt.jQuery(\"#ExistingFileSelection\").html(\""
                    + fileNameToOpenString + "\");";
            currentFrame()->evaluateJavaScript(javaScript + "; null");

            qDebug() << "File to open:" << QDir::toNativeSeparators(fileName);
            qDebug() << "===============";
        }

        return false;
    }

    // Invoke 'New file' dialog from URL:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            request.url().scheme().contains("newfile")) {

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
            currentFrame()->evaluateJavaScript(jQuery);
            QString javaScript = "qt.jQuery(\"#NewFileSelection\").html(\""
                    + fileNameToCreateString + "\");";
            currentFrame()->evaluateJavaScript(javaScript + "; null");

            qDebug() << "New file:" << QDir::toNativeSeparators(fileName);
            qDebug() << "===============";
        }

        return false;
    }

    // Invoke 'Open folder' dialog from URL:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            request.url().scheme().contains("openfolder")) {

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
            currentFrame()->evaluateJavaScript(jQuery);
            QString javaScript = "qt.jQuery(\"#FolderSelection\").html(\""
                    + folderNameToOpenString + "\");";
            currentFrame()->evaluateJavaScript(javaScript + "; null");

            qDebug() << "Folder to open:" << QDir::toNativeSeparators(folderName);
            qDebug() << "===============";
        }

        return false;
    }

#ifndef QT_NO_PRINTER
    // Print preview from URL:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            request.url().scheme().contains("printpreview")) {

        emit printPreviewSignal();

        return false;
    }

    // Print page from URL:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            request.url().scheme().contains("printing")) {

        emit printSignal();

        return false;
    }

    // Save as PDF from URL:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            request.url().scheme().contains("pdf")) {

        emit saveAsPdfSignal();

        return false;
    }
#endif

    // Close window from URL:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            request.url().scheme().contains("closewindow")) {

        qDebug() << "Close window requested from URL.";
        qDebug() << "===============";

        emit closeWindowSignal();

        return false;
    }

    // Quit application from URL:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            request.url().scheme().contains("quit")) {

        qDebug() << "Application termination requested from URL.";
        emit quitFromURLSignal();

        return false;
    }

    // Perl debugger interaction.
    // Implementation of an idea proposed by Valcho Nedelchev.
    if (PERL_DEBUGGER_INTERACTION == 1) {

        if (navigationType == QWebPage::NavigationTypeLinkClicked and
                request.url().scheme().contains("perl-debugger")) {

            if (QPage::mainFrame()->childFrames().contains(frame)) {
                targetFrame = frame;
            }

            // Select a Perl script for debugging:
            if (request.url().toString().contains("select-file")) {

                QFileDialog selectScriptToDebugDialog (qApp->activeWindow());
                selectScriptToDebugDialog
                        .setFileMode(QFileDialog::ExistingFile);
                selectScriptToDebugDialog.setViewMode(QFileDialog::Detail);
                selectScriptToDebugDialog.setWindowModality(Qt::WindowModal);
                selectScriptToDebugDialog.setWindowIcon(icon);
                QString scriptToDebug = selectScriptToDebugDialog
                        .getOpenFileName
                        (qApp->activeWindow(),
                         tr("Select Perl File"),
                         QDir::currentPath(),
                         tr("Perl scripts (*.pl);;")
                         + tr("Perl modules (*.pm);;")
                         + tr("CGI scripts (*.cgi);;")
                         + tr("All files (*)"));
                selectScriptToDebugDialog.close();
                selectScriptToDebugDialog.deleteLater();

                if (scriptToDebug.length() > 1) {
                    QUrl scriptToDebugUrl(QUrl::fromLocalFile(scriptToDebug));
                    QString debuggerQueryString =
                            request.url().toString(QUrl::RemoveScheme
                                                   | QUrl::RemoveAuthority
                                                   | QUrl::RemovePath)
                            .replace("?", "")
                            .replace("command=", "");
#if QT_VERSION >= 0x050000
                    QUrlQuery debuggerQuery;
                    debuggerQuery.addQueryItem(QString("command"),
                                               QString(debuggerQueryString));
                    scriptToDebugUrl.setQuery(debuggerQuery);
#else
                    scriptToDebugUrl
                            .addQueryItem(QString("command"),
                                          QString(debuggerQueryString));
#endif
                    qDebug() << "Perl Debugger URL:"
                             << scriptToDebugUrl.toString();
                    qDebug() << "===============";

                    // Create new window, if requested, but only after
                    // a Perl script for debugging has been selected:
                    if ((!QPage::mainFrame()->childFrames().contains(frame) and
                         (!request.url().toString().contains("restart")))) {
                        debuggerNewWindow = new QTopLevel();
                        QString iconPathName =
                                qApp->property("iconPathName").toString();
                        QPixmap icon;
                        icon.load(iconPathName);
                        debuggerNewWindow->setWindowIcon(icon);
                        debuggerNewWindow->setAttribute(
                                    Qt::WA_DeleteOnClose, true);
                        debuggerNewWindow->setUrl(scriptToDebugUrl);
                        debuggerNewWindow->show();
                        debuggerNewWindow->raise();
                    }

                    if (QPage::mainFrame()->childFrames().contains(frame) or
                            (request.url().toString().contains("restart"))) {

                        // Close open handler from a previous debugger session:
                        debuggerHandler.close();

                        qStartPerlDebuggerSlot(scriptToDebugUrl);
                    }

                    return false;
                } else {
                    return false;
                }
            }
        }

        // Transmit requests to Perl debugger (within the same page):
        if (navigationType == QWebPage::NavigationTypeFormSubmitted and
                request.url().scheme().contains("perl-debugger")) {

            targetFrame = frame;
            qStartPerlDebuggerSlot(request.url());

            return false;
        }
    }

    QRegExp htmlExtensions("\\.htm");
    htmlExtensions.setCaseSensitivity(Qt::CaseInsensitive);

    // Open local content in the same window:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            (QUrl(PSEUDO_DOMAIN)).isParentOf(request.url()) and
            (QPage::mainFrame()->childFrames().contains(frame) or
             QPage::mainFrame()->childFrames().isEmpty())) {

        // Start local script in the same window:
        if (!request.url().path().contains(htmlExtensions)) {
            targetFrame = frame;

            QByteArray emptyPostDataArray;
            qStartScriptSlot(request.url(), emptyPostDataArray);
            return false;
        }

        // Load local HTML page in the same window:
        if (request.url().path().contains(htmlExtensions)) {

            QString relativeFilePath = request.url()
                    .toString(QUrl::RemoveScheme
                              | QUrl::RemoveAuthority
                              | QUrl::RemoveFragment);
            QString fullFilePath = (qApp->property("rootDirName").toString())
                    + relativeFilePath;
            qCheckFileExistenceSlot(fullFilePath);

            frame->load(QUrl::fromLocalFile
                        (QDir::toNativeSeparators
                         ((qApp->property("rootDirName").toString())
                          + request.url().toString(
                              QUrl::RemoveScheme | QUrl::RemoveAuthority))));

            return false;
        }
    }

    // Load local HTML page in a new window:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            (QUrl(PSEUDO_DOMAIN)).isParentOf(request.url()) and
            (!QPage::mainFrame()->childFrames().contains(frame))) {

        if (request.url().path().contains(htmlExtensions)) {
            qDebug() << "Local HTML page in a new window:"
                     << request.url().toString();
            qDebug() << "===============";

            QString relativeFilePath = request.url()
                    .toString(QUrl::RemoveScheme
                              | QUrl::RemoveAuthority
                              | QUrl::RemoveFragment);
            QString fullFilePath = (qApp->property("rootDirName").toString())
                    + relativeFilePath;
            qCheckFileExistenceSlot(fullFilePath);

            newWindow = new QTopLevel();
            QString iconPathName = qApp->property("iconPathName").toString();
            QPixmap icon;
            icon.load(iconPathName);
            newWindow->setWindowIcon(icon);
            newWindow->setAttribute(Qt::WA_DeleteOnClose, true);

            newWindow->load(QUrl::fromLocalFile
                            (QDir::toNativeSeparators
                             ((qApp->property("rootDirName").toString())
                              + request.url().toString(
                                  QUrl::RemoveScheme
                                  | QUrl::RemoveAuthority))));

            newWindow->show();
            return false;
        }
    }

    // Open allowed network content in the same window:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            (QPage::mainFrame()->childFrames().contains(frame)) and
            ((qApp->property("allowedDomainsList").toStringList())
             .contains(request.url().authority()))) {

        qDebug() << "Allowed network link in the same window:"
                 << request.url().toString();
        qDebug() << "===============";

        frame->load(request.url());

        return false;
    }

    // Open allowed network content in a new window:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            (!QPage::mainFrame()->childFrames().contains(frame)) and
            ((qApp->property("allowedDomainsList").toStringList())
             .contains(request.url().authority()))) {

        qDebug() << "Allowed network link in a new window:"
                 << request.url().toString();
        qDebug() << "===============";

        newWindow = new QTopLevel();
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
