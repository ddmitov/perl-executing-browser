/*
 Perl Executing Browser, v. 0.1

 This program is free software;
 you can redistribute it and/or modify it under the terms of the
 GNU General Public License, as published by the Free Software Foundation;
 either version 3 of the License, or (at your option) any later version.
 This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
 without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 Dimitar D. Mitov, 2013 - 2014, ddmitov (at) yahoo (dot) com
 Valcho Nedelchev, 2014
*/

#include <QApplication>
#include <QShortcut>
#include <QDesktopServices>
#include <QDateTime>
#include <QTranslator>
#include <QDebug>

#include <qglobal.h>
#include "peb.h"
#include <iostream> // for std::cout

#ifndef Q_OS_WIN
#include <unistd.h> // for isatty()
#endif

#if QT_VERSION >= 0x050000
// Qt5 code:
#include <QtPrintSupport/QPrinter>
#include <QtPrintSupport/QPrintDialog>
#else
// Qt4 code:
#include <QPrinter>
#include <QPrintDialog>
#endif


// Global variables:
// Application start date and time for filenames of per-session log files:
static QString applicationStartForLogFileName =
        QDateTime::currentDateTime().toString ("yyyy-MM-dd--hh-mm-ss");

// Dynamic global list of all scripts, that are started and still running in any given moment:
QStringList startedScripts;


// Custom message handler for redirecting all debug messages to a log file:
#if QT_VERSION >= 0x050000
// Qt5 code:
void customMessageHandler (QtMsgType type, const QMessageLogContext &context,
                           const QString &message)
#else
// Qt4 code:
void customMessageHandler (QtMsgType type, const char* message)
#endif
{
#if QT_VERSION >= 0x050000
    Q_UNUSED (context);
#endif
    QString dateAndTime = QDateTime::currentDateTime().toString ("dd/MM/yyyy hh:mm:ss");
    QString text = QString ("[%1] ").arg (dateAndTime);

    switch (type)
    {
    case QtDebugMsg:
        text += QString ("{Log} %1").arg (message);
        break;
    case QtWarningMsg:
        text += QString ("{Warning} %1").arg (message);
        break;
    case QtCriticalMsg:
        text += QString ("{Critical} %1").arg (message);
        break;
    case QtFatalMsg:
        text += QString ("{Fatal} %1").arg (message);
        abort();
        break;
    }

   if ((qApp->property ("logMode").toString()) == "single_file") {
       QFile logFile (QDir::toNativeSeparators
                      ((qApp->property ("logDirFullPath").toString())+
                       QDir::separator()+
                       (qApp->property ("logPrefix").toString())+
                       ".log"));
       logFile.open (QIODevice::WriteOnly | QIODevice::Append | QIODevice::Text);
       QTextStream textStream (&logFile);
       textStream << text << endl;
   }

   if ((qApp->property ("logMode").toString()) == "per_session_file") {
       QFile logFile (QDir::toNativeSeparators
                      ((qApp->property ("logDirFullPath").toString())+
                       QDir::separator()+
                       (qApp->property ("logPrefix").toString())+
                       "-started-at-"+
                       applicationStartForLogFileName+
                       ".log"));
       logFile.open (QIODevice::WriteOnly | QIODevice::Append | QIODevice::Text);
       QTextStream textStream (&logFile);
       textStream << text << endl;
   }
}


int main (int argc, char** argv)
{

    QApplication application (argc, argv);

    // Use UTF-8 encoding within the application:
#if QT_VERSION >= 0x050000
    QTextCodec::setCodecForLocale (QTextCodec::codecForName ("UTF8"));
#else
    QTextCodec::setCodecForCStrings (QTextCodec::codecForName ("UTF8"));
#endif

    // Basic application variables:
    application.setApplicationName ("Perl Executing Browser");
    application.setApplicationVersion ("0.1");

    // SETTINGS:
    // Settings file:
    QDir settingsDir = QDir::toNativeSeparators (application.applicationDirPath());
#ifdef Q_OS_MAC
    if (BUNDLE == 1) {
        settingsDir.cdUp();
        settingsDir.cdUp();
    }
#endif
    QString settingsDirName = settingsDir.absolutePath().toLatin1();
    QString settingsFileName = QDir::toNativeSeparators
            (settingsDirName+QDir::separator()+"peb.ini");

    application.setProperty ("settingsFileName", settingsFileName);
    QFile settingsFile (settingsFileName);

    // Check if settings file exists:
    if (!settingsFile.exists()) {
        QMessageBox msgBox;
        msgBox.setWindowModality (Qt::WindowModal);
        msgBox.setIcon (QMessageBox::Critical);
        msgBox.setWindowTitle (QMessageBox::tr ("Missing configuration file"));
        msgBox.setText (QMessageBox::tr ("Configuration file<br>")+
                        settingsFileName+
                        QMessageBox::tr ("<br>is missing.<br>Please restore it."));
        msgBox.setDefaultButton (QMessageBox::Ok);
        msgBox.exec();

        return 1;
        QApplication::exit();
    }

    // Define INI file format for storing settings:
    QSettings settings (settingsFileName, QSettings::IniFormat);

    // ROOT DIRECTORY:
    QString rootDirName;
    QString rootDirNameSetting = settings.value ("root/root").toString();
    if (rootDirNameSetting == "current") {
        rootDirName = settingsDirName;
    } else {
        rootDirName = QDir::toNativeSeparators (rootDirNameSetting);
    }
    if (!rootDirName.endsWith (QDir::separator())) {
        rootDirName.append (QDir::separator());
    }
    application.setProperty ("rootDirName", rootDirName);

    // ENVIRONMENT:
    // Folders to add to PATH:
    QStringList pathToAddList;
    int pathSize = settings.beginReadArray("environment/path");
    for (int index = 0; index < pathSize; ++index) {
        settings.setArrayIndex (index);
        QString pathSetting = settings.value ("name").toString();
        pathToAddList.append (pathSetting);
    }
    settings.endArray();
    application.setProperty ("pathToAddList", pathToAddList);

    // PERLLIB:
    QString perlLibSetting = settings.value ("environment/perllib").toString();
    QDir perlLibDir (perlLibSetting);
    QString perlLib;
    if (perlLibDir.isRelative()) {
        perlLib = QDir::toNativeSeparators (rootDirName+perlLibSetting);
    }
    if (perlLibDir.isAbsolute()) {
        perlLib = QDir::toNativeSeparators (perlLibSetting);
    }
    application.setProperty ("perlLib", perlLib);

    // PERL INTERPRETER:
    QString perlInterpreterSetting = settings.value ("interpreters/perl").toString();
    QDir interpreterFile (perlInterpreterSetting);
    QString perlInterpreter;
    if (interpreterFile.isRelative()) {
        perlInterpreter = QDir::toNativeSeparators (rootDirName+perlInterpreterSetting);
    }
    if (interpreterFile.isAbsolute()) {
        perlInterpreter = QDir::toNativeSeparators (perlInterpreterSetting);
    }
    application.setProperty ("perlInterpreter", perlInterpreter);

    // SCRIPTS:
    // Timeout for CGI scripts (not long-running ones):
    QString scriptTimeout = settings.value ("scripts/script_timeout").toString();
    application.setProperty ("scriptTimeout", scriptTimeout);

    // Display or hide STDERR from scripts - 'enable' or 'disable';
    QString displayStderr = settings.value ("scripts/display_stderr").toString();
    application.setProperty ("displayStderr", displayStderr);

    // PERL DEBUGGER:
    // Perl debugger HTML template:
    QString debuggerHtmlTemplateSetting = settings.value (
                "perl_debugger/debugger_html_template").toString();
    QString debuggerHtmlTemplate;
    QFileInfo debuggerHtmlTemplateFile (debuggerHtmlTemplateSetting);
    if (debuggerHtmlTemplateFile.isRelative()) {
        debuggerHtmlTemplate = QDir::toNativeSeparators (
                    rootDirName+debuggerHtmlTemplateSetting);
    }
    if (debuggerHtmlTemplateFile.isAbsolute()) {
        debuggerHtmlTemplate = QDir::toNativeSeparators (debuggerHtmlTemplateSetting);
    }
    application.setProperty ("debuggerHtmlTemplate", debuggerHtmlTemplate);

    // SOURCE VIEWER:
    // Path to the selected source viewer:
    QString sourceViewerSetting =
            settings.value ("source_viewer/source_viewer").toString();
    QFileInfo sourceViewerFile (sourceViewerSetting);
    QString sourceViewer;
    if (sourceViewerFile.isRelative()) {
        sourceViewer = QDir::toNativeSeparators (
                    rootDirName+sourceViewerSetting);
    }
    if (sourceViewerFile.isAbsolute()) {
        sourceViewer = QDir::toNativeSeparators (sourceViewerSetting);
    }
    application.setProperty ("sourceViewer", sourceViewer);

    // Optional source viewer command line arguments.
    // They will be given to the source viewer whenever it is started by the browser.
    QString sourceViewerArgumentsSetting =
            settings.value ("source_viewer/source_viewer_arguments").toString();
    sourceViewerArgumentsSetting.replace ("\n", "");
    QStringList sourceViewerArguments;
    sourceViewerArguments = sourceViewerArgumentsSetting.split(" ");
    application.setProperty ("sourceViewerArgumentsSetting", sourceViewerArguments);

    // NETWORKING:
    // User agent:
    QString userAgent = settings.value ("networking/user_agent").toString();
    application.setProperty ("userAgent", userAgent);

    // Allowed domains:
    QStringList allowedDomainsList;
    int domainsSize = settings.beginReadArray("networking/allowed_domains");
    for (int index = 0; index < domainsSize; ++index) {
        settings.setArrayIndex (index);
        QString pathSetting = settings.value ("name").toString();
        allowedDomainsList.append (pathSetting);
    }
    settings.endArray();
    application.setProperty ("allowedDomainsList", allowedDomainsList);

    // GUI:
    // Start page - path must be relative to the PEB root directory:
    // HTML file or script are equally usable as a start page:
    QString startPagePath = settings.value ("gui/start_page").toString();
    QString startPage = QDir::toNativeSeparators (rootDirName+startPagePath);
    application.setProperty ("startPagePath", startPagePath);
    application.setProperty ("startPage", startPage);

    // Window size - 'maximized', 'fullscreen' or numeric value like
    // '800x600' or '1024x756' etc.:
    QString windowSize = settings.value ("gui/window_size").toString();
    int fixedWidth;
    int fixedHeight;
    if (windowSize != "maximized" or windowSize != "fullscreen") {
        fixedWidth = windowSize.section ("x", 0, 0) .toInt();
        fixedHeight = windowSize.section ("x", 1, 1) .toInt();
        application.setProperty ("fixedWidth", fixedWidth);
        application.setProperty ("fixedHeight", fixedHeight);
    }
    application.setProperty ("windowSize", windowSize);

    // Stay on top of all other windows - 'enable' or 'disable':
    QString stayOnTop = settings.value ("gui/stay_on_top") .toString();
    application.setProperty ("stayOnTop", stayOnTop);

    // Browser title -'dynamic' or 'My Favorite Title'
    // 'dynamic' title is taken from every HTML <title> tag.
    QString browserTitle = settings.value ("gui/browser_title").toString();
    application.setProperty ("browserTitle", browserTitle);

    // Right click context menu - 'enable' or 'disable':
    QString contextMenu = settings.value ("gui/context_menu").toString();
    application.setProperty ("contextMenu", contextMenu);

    // Web Inspector from context menu - 'enable' or 'disable':
    QString webInspector = settings.value ("gui/web_inspector").toString();
    application.setProperty ("webInspector", webInspector);

    // Icon:
    QString iconPathNameSetting = settings.value ("gui/icon").toString();
    QString iconPathName =
            QDir::toNativeSeparators (rootDirName+iconPathNameSetting);
    QPixmap icon;
    icon.load (iconPathName);
    application.setProperty ("iconPathName", iconPathName);

    // THEMES:
    // Name of the current GUI theme:
    QString defaultTheme = settings.value ("themes/default_theme").toString();
    application.setProperty ("defaultTheme", defaultTheme);

    // Directory of the current GUI theme:
    QString defaultThemeDirectorySetting =
            settings.value ("themes/default_theme_directory").toString();
    QString defaultThemeDirectory;
    QDir defaultThemeDir (defaultThemeDirectorySetting);
    if (defaultThemeDir.isRelative()) {
        defaultThemeDirectory = QDir::toNativeSeparators (
                    rootDirName+defaultThemeDirectorySetting);
    }
    if (defaultThemeDir.isAbsolute()) {
        defaultThemeDirectory = QDir::toNativeSeparators (defaultThemeDirectorySetting);
    }
    application.setProperty ("defaultThemeDirectory", defaultThemeDirectory);

    // Directory for all GUI themes:
    QString allThemesDirectorySetting =
            settings.value ("themes/all_themes_directory").toString();
    QString allThemesDirectory;
    QDir allThemesDir (allThemesDirectorySetting);
    if (allThemesDir.isRelative()) {
        allThemesDirectory = QDir::toNativeSeparators (rootDirName+allThemesDirectorySetting);
    }
    if (allThemesDir.isAbsolute()) {
        allThemesDirectory = QDir::toNativeSeparators (allThemesDirectorySetting);
    }
    application.setProperty ("allThemesDirectory", allThemesDirectory);

    // TRANSLATIONS:
    // Current translation:
    QString defaultTranslation =
            settings.value ("translations/default_translation").toString();
    application.setProperty ("defaultTranslation", defaultTranslation);

    // Directory for all translations:
    QString allTranslationsDirectorySetting =
            settings.value ("translations/all_translations_directory").toString();
    QDir translationsDir (allTranslationsDirectorySetting);
    QString allTranslationsDirectory;
    if (translationsDir.isRelative()) {
        allTranslationsDirectory = QDir::toNativeSeparators (
                    rootDirName+allTranslationsDirectorySetting);
    }
    if (translationsDir.isAbsolute()) {
        allTranslationsDirectory = QDir::toNativeSeparators (allTranslationsDirectorySetting);
    }
    application.setProperty ("allTranslationsDirectory", allTranslationsDirectory);

    // HELP:
    // Help directory:
    QString helpDirectorySetting =
            settings.value ("help/help_directory").toString();
    QDir helpDir (helpDirectorySetting);
    QString helpDirectory;
    if (helpDir.isRelative()) {
        helpDirectory = QDir::toNativeSeparators (rootDirName+helpDirectorySetting);
    }
    if (helpDir.isAbsolute()) {
        helpDirectory = QDir::toNativeSeparators (helpDirectorySetting);
    }
    application.setProperty ("helpDirectory", helpDirectory);

    // SYSTEM TRAY:
    // System tray icon - 'enable' or 'disable':
    QString systrayIcon = settings.value ("system_tray/systray_icon").toString();
    application.setProperty ("systrayIcon", systrayIcon);

    // Double-clicking the system tray icon can quit the program or minimize all of it's windows.
    // User is asked for confirmation before quitting the program.
    // Available options: 'quit' or 'minimize_all_windows'
    QString systrayIconDoubleClickAction =
            settings.value ("system_tray/systray_icon_double_click_action").toString();
    application.setProperty ("systrayIconDoubleClickAction", systrayIconDoubleClickAction);

    // LOGGING:
    // Logging - 'enable' or 'disable':
    QString logging = settings.value ("logging/logging").toString();
    application.setProperty ("logging", logging);

    // Logging mode - 'per_session_file' or 'single_file'.
    // 'single_file' means that only one single log file is created.
    // 'per_session' means that a separate log file is created for every browser ssession.
    // Application start date and time are appended to the file name in this scenario.
    QString logMode = settings.value ("logging/logging_mode").toString();
    application.setProperty ("logMode", logMode);

    // Log files directory:
    QString logDirName = settings.value ("logging/logging_directory").toString();
    QDir logDir (logDirName);
    QString logDirFullPath;
    if (!logDir.exists ()) {
       logDir.mkpath(".");
    }
    if (logDir.isRelative()) {
        logDirFullPath = QDir::toNativeSeparators (rootDirName+logDirName);
    }
    if (logDir.isAbsolute()) {
        logDirFullPath = QDir::toNativeSeparators (logDirName);
    }
    application.setProperty ("logDirFullPath", logDirFullPath);

    // Log filename prefix:
    QString logPrefix = settings.value ("logging/logging_prefix").toString();
    application.setProperty ("logPrefix", logPrefix);

    // Command line arguments overwrite configuration file settings with the same name:
    QStringList arguments = application.arguments();
    foreach (QString argument, arguments) {
        if (argument.contains ("--fullscreen") or argument.contains ("-F")) {
            windowSize = "fullscreen";
        }
        if (argument.contains ("--maximized") or argument.contains ("-M")) {
            fixedWidth = 1;
            fixedHeight = 1;
            windowSize = "maximized";
        }
    }

    // TRANSLATION:
    QTranslator translator;
    if (defaultTranslation != "none") {
        translator.load (defaultTranslation, allTranslationsDirectory);
    }
    application.installTranslator (&translator);

    // Install custom message handler for redirecting all debug messages to a log file:
    if ((qApp->property ("logging").toString()) == "enable") {
#if QT_VERSION >= 0x050000
        // Qt5 code:
        qInstallMessageHandler (customMessageHandler);
#else
        // Qt4 code:
        qInstallMsgHandler (customMessageHandler);
#endif
    }

    // Get current date and time for the log file and the command line output:
    QString applicationStartForLogContents = QDateTime::currentDateTime().toString ("dd.MM.yyyy hh:mm:ss");

    // Get command line arguments:
    //QStringList arguments = QCoreApplication::arguments();

    // Display command line help and exit:
    foreach (QString argument, arguments){
        if (argument.contains ("--help") or argument.contains ("-H")) {
            std::cout << " " << std::endl;
            std::cout << application.applicationName().toLatin1().constData()
                      << " v." << application.applicationVersion().toLatin1().constData()
                      << " started on: "
                      << applicationStartForLogContents.toLatin1().constData() << std::endl;
            std::cout << "Application file path: "
                      << (QDir::toNativeSeparators (
                              QApplication::applicationFilePath()).toLatin1().constData())
                      << std::endl;
            std::cout << "Qt WebKit version: " << QTWEBKIT_VERSION_STR << std::endl;
            std::cout << "Qt version: " << QT_VERSION_STR << std::endl;
            std::cout << " " << std::endl;
            std::cout << "Usage:" << std::endl;
            std::cout << "  peb --option=value -o=value" << std::endl;
            std::cout << " " << std::endl;
            std::cout << "Command line options:" << std::endl;
            std::cout << "  --fullscreen    -F    start browser in fullscreen mode"
                      << std::endl;
            std::cout << "  --maximized     -M    start browser in a maximized window"
                      << std::endl;
            std::cout << "  --help          -H    this help"
                      << std::endl;
            std::cout << " " << std::endl;
            if ((qApp->property ("logging").toString()) == "enable") {
                QString dateTimeString =
                        QDateTime::currentDateTime().toString ("dd.MM.yyyy hh:mm:ss");
                qDebug() << application.applicationName().toLatin1().constData()
                         << application.applicationVersion().toLatin1().constData()
                         << "displayed help and terminated normally on:"
                         << dateTimeString;
                qDebug() << "===============";
            }
            return 1;
            QApplication::exit();
        }
    }

    // Set an empty, transparent icon for message boxes in case no icon file is found:
    QPixmap emptyTransparentIcon (16, 16);
    emptyTransparentIcon.fill (Qt::transparent);
    QApplication::setWindowIcon (QIcon (emptyTransparentIcon));

    // Check if default theme file exists, if not - copy it from themes folder:
    if (!QFile::exists (defaultThemeDirectory+
                        QDir::separator()+
                        "current.css")) {
        QFile::copy (allThemesDirectory+QDir::separator()+defaultTheme,
                     defaultThemeDirectory+QDir::separator()+"current.css");
    }

    // Log basic program information:
    qDebug() << "";
    qDebug() << application.applicationName().toLatin1().constData()
             << "version"
             << application.applicationVersion().toLatin1().constData()
             << "started on:"
             << applicationStartForLogContents.toLatin1().constData();
    qDebug() << "Application file path:"
             << QDir::toNativeSeparators (QApplication::applicationFilePath())
                .toLatin1().constData();
    QString allArguments;
    foreach (QString argument, arguments){
        allArguments.append (argument);
        allArguments.append (" ");
    }
    allArguments.replace (QRegExp ("\\s$"), "");
    qDebug() << "Command line:" << allArguments.toLatin1().constData();
    qDebug() << "Qt WebKit version:" << QTWEBKIT_VERSION_STR;
    qDebug() << "Qt version:" << QT_VERSION_STR;
    qDebug() << "License:"
             << QLibraryInfo::licensedProducts().toLatin1().constData();
    qDebug() << "Libraries Path:"
             << QLibraryInfo::location (QLibraryInfo::LibrariesPath).toLatin1().constData();

    // Prevent starting the program as root - part 1 (Linux and Mac only):
#ifndef Q_OS_WIN
    int userEuid;
    userEuid = geteuid();

    if (userEuid == 0) {
        qDebug() << "";
        qDebug() << "Program started with root privileges. Aborting!";
        qDebug() << "Please start again with normal user privileges.";
    }
#endif

    qDebug() << "";

#ifndef Q_OS_WIN
    // Detect if the program is started from terminal (Linux and Mac only).
    // If the browser is started from terminal, it will start another copy of itself and
    // close the first one. This is necessary for a working interaction with the Perl debugger.
    if (isatty (fileno (stdin))) {

        if (userEuid > 0) {
            qDebug() << "Started from terminal with normal user privileges.";
            qDebug() << "Will start another instance of the program and quit this one.";
            qDebug() << "";
        }

        if ((qApp->property ("logging").toString()) == "enable") {
            std::cout << " " << std::endl;
            std::cout << application.applicationName().toLatin1().constData()
                      << " v." << application.applicationVersion().toLatin1().constData()
                      << " started on:"
                      << applicationStartForLogContents.toLatin1().constData() << std::endl;
            std::cout << "Application file path: "
                      << (QDir::toNativeSeparators (
                              QApplication::applicationFilePath()).toLatin1().constData())
                      << std::endl;
            std::cout << "Command line: "
                      << allArguments.toLatin1().constData() << std::endl;
            std::cout << "Qt WebKit version: " << QTWEBKIT_VERSION_STR << std::endl;
            std::cout << "Qt version: " << QT_VERSION_STR << std::endl;
            std::cout << "License: " << QLibraryInfo::licensedProducts()
                         .toLatin1().constData() << std::endl;
            std::cout << "Libraries Path: "
                      << QLibraryInfo::location (QLibraryInfo::LibrariesPath)
                         .toLatin1().constData() << std::endl;

            if (userEuid == 0) {
                std::cout << "Program started with root privileges. Aborting!" << std::endl;
                std::cout << " " << std::endl;
                return 1;
                QApplication::exit();
            } else {
                std::cout << "Started from terminal with normal user privileges." << std::endl;
                std::cout << "Will start another instance of the program and quit this one."
                          << std::endl;
                std::cout << " " << std::endl;
            }
        }

        // Prevent starting the program as root - part 2:
        if (userEuid == 0) {
            return 1;
            QApplication::exit();
        }

        // Fork another instance of the browser:
        int pid = fork();

        if (pid < 0) {
            // Report error and exit:
            qDebug() << "PID less than zero. Aborting.";
            return 1;
            QApplication::exit();
        }

        if (pid == 0) {
            // Detach all standard I/O descriptors:
            close (0);
            close (1);
            close (2);
            // Enter a new session:
            setsid();
            // New instance is now detached from terminal:
            QProcess anotherInstance;
            anotherInstance.startDetached (
                        QApplication::applicationFilePath(), arguments);
            if (anotherInstance.waitForStarted (-1)) {
                return 1;
                QApplication::exit();
            }
        } else {
            // The parent instance should be closed now:
            return 1;
            QApplication::exit();
        }
    } else {
        if (userEuid > 0) {
            qDebug() << "Started without terminal or inside Qt Creator with user privileges.";
        }
    }

    // Prevent starting the program as root - part 3:
    if (userEuid == 0) {
        QMessageBox msgBox;
        msgBox.setWindowModality (Qt::WindowModal);
        msgBox.setIcon (QMessageBox::Critical);
        msgBox.setWindowTitle (QMessageBox::tr ("Started as root"));
        msgBox.setText (QMessageBox::tr ("Browser was started as root.<br>")+
                        QMessageBox::tr ("This is definitely not a good idea!<br>")+
                        QMessageBox::tr ("Going to quit now."));
        msgBox.setDefaultButton (QMessageBox::Ok);
        msgBox.exec();

        return 1;
        QApplication::exit();
    }
#endif

    qDebug() << "===============";

    // Screen resolution:
    int screenWidth = QDesktopWidget().screen()->rect().width();
    int screenHeight = QDesktopWidget().screen()->rect().height();
    qDebug() << "SCREEN RESOLUTION:" << screenWidth << "x" << screenHeight;

    // Log all settings:
    qDebug() << "===============";
    qDebug() << "GENERAL SETTINGS:";
    qDebug() << "===============";
    qDebug() << "Root folder:" << QDir::toNativeSeparators (rootDirName);
    qDebug() << "Settings file name:" << settingsFileName;

    qDebug() << "===============";
    qDebug() << "ENVIRONMENT SETTINGS:";
    qDebug() << "===============";
    qDebug() << "Folders to add to PATH:";
    foreach (QString pathEntry, pathToAddList) {
        qDebug() << pathEntry;
    }

    qDebug() << "===============";
    qDebug() << "PERL SETTINGS:";
    qDebug() << "===============";
    qDebug() << "PERLLIB folder:" << perlLib;
    qDebug() << "Perl interpreter" << perlInterpreter;

    qDebug() << "===============";
    qDebug() << "SCRIPTS SETTINGS:";
    qDebug() << "===============";
    qDebug() << "Script Timeout:" << scriptTimeout;
    qDebug() << "Display STDERR from scripts:" << displayStderr;

    if (PERL_DEBUGGER_INTERACTION == 1) {
        qDebug() << "===============";
        qDebug() << "DEBUGGER SETTINGS:";
        qDebug() << "===============";
        qDebug() << "Debugger HTML template:" << debuggerHtmlTemplate;
    }

    qDebug() << "===============";
    qDebug() << "SOURCE VIEWER SETTINGS:";
    qDebug() << "===============";
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
    qDebug() << "Window size:" << windowSize;
    qDebug() << "Stay on top:" << stayOnTop;
    qDebug() << "Browser title:" << browserTitle;
    qDebug() << "Context menu:" << contextMenu;
    qDebug() << "Web Inspector from context menu:" << webInspector;
    qDebug() << "Application icon:" << iconPathName;
    qDebug() << "Default theme:" << defaultTheme;
    qDebug() << "Default theme directory:" << defaultThemeDirectory;
    qDebug() << "All themes directory:" << allThemesDirectory;
    qDebug() << "Default translation:" << defaultTranslation;
    qDebug() << "Translations directory:" << allTranslationsDirectory;
    qDebug() << "System tray icon:" << systrayIcon;
    qDebug() << "System tray icon double-click action:"
             << systrayIconDoubleClickAction;

    qDebug() << "===============";
    qDebug() << "LOGGING SETTINGS:";
    qDebug() << "===============";
    qDebug() << "Logging:" << logging;
    qDebug() << "Logging mode:" << logMode;
    qDebug() << "Logfiles directory:" << logDirFullPath;
    qDebug() << "Logfiles prefix:" << logPrefix;
    qDebug() << "===============";

    // Check if start page exists:
    QFile startPageFile (startPage);
    if (!startPageFile.exists()) {
        qDebug() << "Start page is missing.";
        qDebug() << "Please select a start page.";
        qDebug() << "Exiting.";
        qDebug() << "===============";

        QMessageBox msgBox;
        msgBox.setWindowModality (Qt::WindowModal);
        msgBox.setIcon (QMessageBox::Critical);
        msgBox.setWindowTitle (QMessageBox::tr ("Missing start page"));
        msgBox.setText (QMessageBox::tr (
                            "Start page is missing.<br>Please select a start page."));
        msgBox.setDefaultButton (QMessageBox::Ok);
        msgBox.exec();

        return 1;
        QApplication::exit();
    }

    // Set application window icon from an external file:
    QApplication::setWindowIcon (icon);

    // Initialize the main GUI class:
    TopLevel toplevel;

    QObject::connect (qApp, SIGNAL (lastWindowClosed()),
                      &toplevel, SLOT (quitApplicationSlot()));

    toplevel.setWindowIcon (icon);
    toplevel.loadStartPageSlot();
    toplevel.show();

    // Initialize the system tray icon class:
    TrayIcon trayicon;

    if (systrayIcon == "enable") {
        QObject::connect (trayicon.aboutAction, SIGNAL (triggered()),
                          &toplevel, SLOT (aboutSlot()));

        QObject::connect (trayicon.quitAction, SIGNAL (triggered()),
                          &toplevel, SLOT (quitApplicationSlot()));

        QObject::connect (&toplevel, SIGNAL (trayIconHideSignal()),
                          &trayicon, SLOT (trayIconHideSlot()));
    }

    return application.exec();

}


FileDetector::FileDetector()
    : QObject (0)
{

    // Regular expressions for file type detection by shebang line:
    perlShebang.setPattern ("#!/.{1,}perl");

    // Regular expressions for file type detection by extension:
    htmlExtensions.setPattern ("htm");
    htmlExtensions.setCaseSensitivity (Qt::CaseInsensitive);

    cssExtension.setPattern ("css");
    cssExtension.setCaseSensitivity (Qt::CaseInsensitive);

    jsExtension.setPattern ("js");
    jsExtension.setCaseSensitivity (Qt::CaseInsensitive);

    pngExtension.setPattern ("png");
    pngExtension.setCaseSensitivity (Qt::CaseInsensitive);

    jpgExtensions.setPattern ("jpe{0,1}g");
    jpgExtensions.setCaseSensitivity (Qt::CaseInsensitive);

    gifExtension.setPattern ("gif");
    gifExtension.setCaseSensitivity (Qt::CaseInsensitive);

    plExtension.setPattern ("pl");
    plExtension.setCaseSensitivity (Qt::CaseInsensitive);

}


TrayIcon::TrayIcon()
    : QSystemTrayIcon(0)
{

    if ((qApp->property ("systrayIcon").toString()) == "enable") {
        trayIcon = new QSystemTrayIcon();
        QString iconPathName = qApp->property ("iconPathName").toString();
        QPixmap icon;
        icon.load (iconPathName);
        trayIcon->setIcon (icon);
        trayIcon->setToolTip ("Camel Calf");

        QObject::connect (trayIcon, SIGNAL (activated (QSystemTrayIcon::ActivationReason)),
                          this, SLOT (trayIconActivatedSlot (QSystemTrayIcon::ActivationReason)));

        aboutAction = new QAction (tr ("&About"), this);

        aboutQtAction = new QAction (tr ("About Q&t"), this);
        QObject::connect (aboutQtAction, SIGNAL (triggered()),
                          qApp, SLOT (aboutQt()));

        quitAction = new QAction (tr ("&Quit"), this);

        trayIconMenu = new QMenu();
        trayIcon->setContextMenu (trayIconMenu);
        trayIconMenu->addAction (aboutAction);
        trayIconMenu->addAction (aboutQtAction);
        trayIconMenu->addSeparator();
        trayIconMenu->addAction (quitAction);
        trayIcon->show();
    }

}


Page::Page()
    : QWebPage(0)
{

    QWebSettings::globalSettings()->
            setDefaultTextEncoding (QString ("utf-8"));
    QWebSettings::globalSettings()->
            setAttribute (QWebSettings::PluginsEnabled, true);
    QWebSettings::globalSettings()->
            setAttribute (QWebSettings::JavascriptEnabled, true);
    QWebSettings::globalSettings()->
            setAttribute (QWebSettings::JavascriptCanOpenWindows, true);
    QWebSettings::globalSettings()->
            setAttribute (QWebSettings::SpatialNavigationEnabled, true);
    QWebSettings::globalSettings()->
            setAttribute (QWebSettings::LinksIncludedInFocusChain, true);
    QWebSettings::globalSettings()->
            setAttribute (QWebSettings::AutoLoadImages, true);
    if ((qApp->property ("webInspector").toString()) == "enable") {
        QWebSettings::globalSettings()->
                setAttribute (QWebSettings::DeveloperExtrasEnabled, true);
    }
    QWebSettings::globalSettings()->
            setAttribute (QWebSettings::PrivateBrowsingEnabled, true);
    QWebSettings::globalSettings()->
            setAttribute (QWebSettings::LocalContentCanAccessFileUrls, true);
    QWebSettings::globalSettings()->
            setAttribute (QWebSettings::LocalContentCanAccessRemoteUrls, true);
    QWebSettings::setMaximumPagesInCache (0);
    QWebSettings::setObjectCacheCapacities (0, 0, 0);

    QObject::connect (&scriptHandler, SIGNAL (readyReadStandardOutput()),
                       this, SLOT (scriptOutputSlot()));
    QObject::connect (&scriptHandler, SIGNAL (readyReadStandardError()),
                       this, SLOT (scriptErrorSlot()));
    QObject::connect (&scriptHandler, SIGNAL (finished (int, QProcess::ExitStatus)),
                       this, SLOT (scriptFinishedSlot()));

    if (PERL_DEBUGGER_INTERACTION == 1) {
        QObject::connect (&debuggerHandler, SIGNAL (readyReadStandardOutput()),
                          this, SLOT (debuggerOutputSlot()));

        QObject::connect (this, SIGNAL (sourceCodeForDebuggerReadySignal()),
                          this, SLOT (displaySourceCodeAndDebuggerOutputSlot()));

        QObject::connect (&debuggerSyntaxHighlighter, SIGNAL (finished (int, QProcess::ExitStatus)),
                          this, SLOT (debuggerSyntaxHighlighterReadySlot()));
    }

    // SAFE ENVIRONMENT FOR ALL LOCAL SCRIPTS:
    QStringList systemEnvironment =
            QProcessEnvironment::systemEnvironment().toStringList();

    foreach (QString environmentVariable, systemEnvironment) {
        QStringList environmentVariableList = environmentVariable.split ("=");
        QString environmentVariableName = environmentVariableList.first();
        if (!allowedEnvironmentVariables.contains (environmentVariableName)) {
            scriptEnvironment.remove (environmentVariable);
        } else {
            scriptEnvironment.insert (
                        environmentVariableList.first(), environmentVariableList[1]);
        }
    }

    // DOCUMENT_ROOT:
    scriptEnvironment.remove ("DOCUMENT_ROOT");
    scriptEnvironment.insert ("DOCUMENT_ROOT", qApp->property ("rootDirName").toString());

    // PERLLIB:
    scriptEnvironment.remove ("PERLLIB");
    scriptEnvironment.insert ("PERLLIB", qApp->property ("perlLib").toString());

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
    foreach (QString pathEntry, qApp->property ("pathToAddList").toString()) {
        QDir pathDir (pathEntry);
        if (pathDir.exists()) {
            if (pathDir.isRelative()) {
                pathEntry = QDir::toNativeSeparators (qApp->property ("rootDirName").toString()
                                                      +pathEntry);
            }
            if (pathDir.isAbsolute()) {
                pathEntry = QDir::toNativeSeparators (pathEntry);
            }
            path.append (pathEntry);
            path.append (pathSeparator);
        }
    }

#ifndef Q_OS_WIN // Linux and Mac
    scriptEnvironment.remove ("PATH");
    scriptEnvironment.insert ("PATH", path);
#endif
#ifdef Q_OS_WIN // Windows
    scriptEnvironment.remove ("Path");
    scriptEnvironment.insert ("Path", path);
#endif

    // Source viewer mandatory, or minimal, command line:
    sourceViewerMandatoryCommandLine.append (
                (qApp->property ("sourceViewer").toString()));
    if ((qApp->property ("sourceViewerArguments").toStringList()).length() > 1) {
        foreach (QString argument,
                 (qApp->property ("sourceViewerArguments").toStringList())) {
            sourceViewerMandatoryCommandLine.append (argument);
        }
    }

    // Default frame for local content:
    targetFrame = Page::mainFrame();

    // Icon for dialogs:
    QString iconPathName = qApp->property ("icon").toString();
    icon.load (iconPathName);

}


TopLevel::TopLevel ()
    : QWebView(0)
{

    // Configure keyboard shortcuts - main window:
    QShortcut* minimizeShortcut = new QShortcut (Qt::Key_Escape, this);
    QObject::connect (minimizeShortcut, SIGNAL (activated()),
                      this, SLOT (minimizeSlot()));

    QShortcut* maximizeShortcut = new QShortcut (QKeySequence ("Ctrl+M"), this);
    QObject::connect (maximizeShortcut, SIGNAL (activated()),
                      this, SLOT (maximizeSlot()));

    QShortcut* toggleFullScreenShortcut = new QShortcut (Qt::Key_F11, this);
    QObject::connect (toggleFullScreenShortcut, SIGNAL (activated()),
                      this, SLOT (toggleFullScreenSlot()));

    QShortcut* homeShortcut = new QShortcut (Qt::Key_F12, this);
    QObject::connect (homeShortcut, SIGNAL (activated()),
                      this, SLOT (loadStartPageSlot()));

    QShortcut* reloadShortcut = new QShortcut (QKeySequence ("Ctrl+R"), this);
    QObject::connect (reloadShortcut, SIGNAL (activated()),
                      this, SLOT (reloadSlot()));

    QShortcut* printShortcut = new QShortcut (QKeySequence ("Ctrl+P"), this);
    QObject::connect (printShortcut, SIGNAL (activated()),
                      this, SLOT (printSlot()));

    QShortcut* closeAppShortcut = new QShortcut (QKeySequence ("Ctrl+X"), this);
    QObject::connect (closeAppShortcut, SIGNAL (activated()),
                      this, SLOT (quitApplicationSlot()));

    // Configure screen appearance:
    if ((qApp->property ("fixedWidth").toInt()) > 100 and
            (qApp->property ("fixedHeight").toInt()) > 100) {
        setFixedSize ((qApp->property ("fixedWidth").toInt()),
                      (qApp->property ("fixedHeight").toInt()));
        QRect screenRect = QDesktopWidget().screen()->rect();
        move (QPoint (screenRect.width() / 2 - width() / 2,
                      screenRect.height() / 2 - height() / 2));
    } else {
        showMaximized();
    }

    if ((qApp->property ("windowSize").toString()) == "maximized") {
        showMaximized();
    }
    if ((qApp->property ("windowSize").toString()) == "fullscreen") {
        showFullScreen();
    }
    if ((qApp->property ("stayOnTop").toString()) == "enable") {
        setWindowFlags (Qt::WindowStaysOnTopHint);
    }
    if ((qApp->property ("browserTitle").toString()) != "dynamic") {
        setWindowTitle ((qApp->property ("browserTitle").toString()));
    }
    if ((qApp->property ("contextMenu").toString()) == "disable") {
        setContextMenuPolicy (Qt::NoContextMenu);
    }

    mainPage = new Page();

    QObject::connect (mainPage, SIGNAL (closeWindowSignal()),
                          this, SLOT (close()));

    // Connect signals and slots - main window:
    QObject::connect (mainPage, SIGNAL (displayErrorsSignal (QString)),
                      this, SLOT (displayErrorsSlot (QString)));

    QObject::connect (this, SIGNAL (selectThemeSignal()),
                      mainPage, SLOT (selectThemeSlot()));

    QObject::connect (mainPage, SIGNAL (printPreviewSignal()),
                      this, SLOT (startPrintPreviewSlot()));
    QObject::connect (mainPage, SIGNAL (printSignal()),
                      this, SLOT (printSlot()));
    QObject::connect (mainPage, SIGNAL (saveAsPdfSignal()),
                      this, SLOT (saveAsPdfSlot()));

    QObject::connect (mainPage, SIGNAL (reloadSignal()),
                      this, SLOT (reloadSlot()));

    QObject::connect (mainPage, SIGNAL (quitFromURLSignal()),
                      this, SLOT (quitApplicationSlot()));

    if ((qApp->property ("browserTitle").toString()) == "dynamic") {
        QObject::connect (mainPage, SIGNAL (loadFinished (bool)),
                          this, SLOT (pageLoadedDynamicTitleSlot (bool)));
    } else {
        QObject::connect (mainPage, SIGNAL (loadFinished (bool)),
                          this, SLOT (pageLoadedStaticTitleSlot (bool)));
    }

    setPage (mainPage);

    // Use modified Network Access Manager with every window of the program:
    ModifiedNetworkAccessManager* nam = new ModifiedNetworkAccessManager();
    mainPage->setNetworkAccessManager (nam);

    QObject::connect (nam, SIGNAL (startScriptSignal (QUrl, QByteArray)),
                      mainPage, SLOT (startScriptSlot (QUrl, QByteArray)));

    if (PERL_DEBUGGER_INTERACTION == 1) {
        QObject::connect (nam, SIGNAL (startPerlDebuggerSignal (QUrl)),
                          mainPage, SLOT (startPerlDebuggerSlot (QUrl)));
    }

    // Disable history:
    QWebHistory* history = mainPage->history();
    history->setMaximumItemCount (0);

    // Cookies and HTTPS support:
    QNetworkCookieJar* jar = new QNetworkCookieJar;
    nam->setCookieJar (jar);
    QObject::connect (nam, SIGNAL (sslErrors (QNetworkReply*, QList<QSslError>)),
                      this, SLOT (sslErrors (QNetworkReply*, QList<QSslError>)));

    // Configure scroll bars:
    mainPage->mainFrame()->setScrollBarPolicy (Qt::Horizontal, Qt::ScrollBarAsNeeded);
    mainPage->mainFrame()->setScrollBarPolicy (Qt::Vertical, Qt::ScrollBarAsNeeded);

    // Context menu settings:
    mainPage->action (QWebPage::SetTextDirectionLeftToRight)->setVisible (false);
    mainPage->action (QWebPage::SetTextDirectionRightToLeft)->setVisible (false);

    mainPage->action (QWebPage::Back)->setVisible (false);
    mainPage->action (QWebPage::Forward)->setVisible (false);
    mainPage->action (QWebPage::Reload)->setVisible (false);
    mainPage->action (QWebPage::Stop)->setVisible (false);

    mainPage->action (QWebPage::OpenLink)->setVisible (false);
    mainPage->action (QWebPage::CopyLinkToClipboard)->setVisible (false);
    mainPage->action (QWebPage::OpenLinkInNewWindow)->setVisible (false);
    mainPage->action (QWebPage::DownloadLinkToDisk)->setVisible (false);
    mainPage->action (QWebPage::OpenFrameInNewWindow)->setVisible (false);

    mainPage->action (QWebPage::CopyImageUrlToClipboard)->setVisible (false);
    mainPage->action (QWebPage::CopyImageToClipboard)->setVisible (false);
    mainPage->action (QWebPage::OpenImageInNewWindow)->setVisible (true);
    mainPage->action (QWebPage::DownloadImageToDisk)->setVisible (false);

    // Icon for windows:
    QString iconPathName = qApp->property ("iconPathName").toString();
    icon.load (iconPathName);

}

// Manage clicking of links:
bool Page::acceptNavigationRequest (QWebFrame* frame,
                                    const QNetworkRequest &request,
                                    QWebPage::NavigationType navigationType)
{

    // Select folder to add to the PATH environment variable:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
         request.url().scheme().contains ("addtopath")) {

        QFileDialog addToPathDialog;
        addToPathDialog.setFileMode (QFileDialog::AnyFile);
        addToPathDialog.setViewMode (QFileDialog::Detail);
        addToPathDialog.setWindowModality (Qt::WindowModal);
        addToPathDialog.setWindowIcon (icon);
        QString pathFolderString = addToPathDialog.getExistingDirectory
                (0, tr ("Select folder to add to PATH"), QDir::currentPath());
        addToPathDialog.close();
        addToPathDialog.deleteLater();

        qDebug() << "Folder to add to PATH:" << pathFolderString;
        qDebug() << "===============";

        // Open the settings file:
        QSettings pathFoldersSetting ((qApp->property ("settingsFileName").toString()),
                                      QSettings::IniFormat);

        // Get list of all folders on the current PATH:
       QStringList currentPathList;
       int pathArraySize = pathFoldersSetting.beginReadArray("environment/path");
       for (int index = 0; index < pathArraySize; ++index) {
       pathFoldersSetting.setArrayIndex (index);
       QString pathSetting = pathFoldersSetting.value ("name").toString();
       currentPathList.append (pathSetting);
       }
       pathFoldersSetting.endArray();

       // Append the new folder name to
       // the list of all folders on the current PATH:
       currentPathList.append (pathFolderString);

        // Append the new folder name in the
        // appropriate section of the settings file:
        pathFoldersSetting.beginWriteArray ("environment/path");
        pathFoldersSetting.setArrayIndex (pathArraySize);
        pathFoldersSetting.setValue ("name", pathFolderString);
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
            QDir pathDir (pathEntry);
            if (pathDir.exists()) {
                if (pathDir.isRelative()) {
                    pathEntry = QDir::toNativeSeparators (
                                (qApp->property ("rootDirName").toString())+
                                pathEntry);
                }
                if (pathDir.isAbsolute()) {
                    pathEntry = QDir::toNativeSeparators (pathEntry);
                }
                path.append (pathEntry);
                path.append (pathSeparator);
            }
        }

        // Insert the new browser-specific PATH variable into
        // the environment of the browser and all local scripts executed by the browser:
#ifndef Q_OS_WIN // Unix-based or similar operating systems
        qputenv ("PATH", path);
        scriptEnvironment.insert ("PATH", path);
#else // Windows
        qputenv ("Path", path);
        scriptEnvironment.insert ("Path", path);
#endif

        return false;
    }

    // Select Perl interpreter:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
         request.url().scheme().contains ("selectperl")) {

        QFileDialog dialog;
        dialog.setFileMode (QFileDialog::AnyFile);
        dialog.setViewMode (QFileDialog::Detail);
        dialog.setWindowModality (Qt::WindowModal);
        dialog.setWindowIcon (icon);
        QString perlInterpreter = dialog.getOpenFileName
                (0, tr ("Select Perl Interpreter"),
                 QDir::currentPath(), tr ("All files (*)"));
        dialog.close();
        dialog.deleteLater();

        if (perlInterpreter.length() > 0) {
            QSettings perlInterpreterSetting ((qApp->property ("settingsFileName").toString()),
                                              QSettings::IniFormat);
            perlInterpreterSetting.setValue ("interpreters/perl", perlInterpreter);
            perlInterpreterSetting.sync();

            qDebug() << "Selected Perl interpreter:" << perlInterpreter;

            QFileDialog selectPerlLibDialog;
            selectPerlLibDialog.setFileMode (QFileDialog::AnyFile);
            selectPerlLibDialog.setViewMode (QFileDialog::Detail);
            selectPerlLibDialog.setWindowModality (Qt::WindowModal);
            selectPerlLibDialog.setWindowIcon (icon);
            QString perlLibFolderName = selectPerlLibDialog.getExistingDirectory
                    (0, tr ("Select PERLLIB"), QDir::currentPath());
            selectPerlLibDialog.close();
            selectPerlLibDialog.deleteLater();

            QSettings perlLibSetting ((qApp->property ("settingsFileName").toString()),
                                      QSettings::IniFormat);
            perlLibSetting.setValue ("environment/perllib", perlLibFolderName);
            perlLibSetting.sync();

            qDebug() << "Selected PERLLIB:" << perlLibFolderName;
            qDebug() << "===============";
        }

        return false;
    }

    // Set predefined theme:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
         request.url().scheme().contains ("settheme")) {

        QString theme = request.url()
                .toString (QUrl::RemoveScheme)
                .replace ("//", "");;

        setThemeSlot (theme);

        return false;
    }


    // Select another theme:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
         request.url().scheme().contains ("selecttheme")) {

        selectThemeSlot();

        return false;
    }

    // Invoke 'Open file' dialog from URL:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
         request.url().scheme().contains ("openfile")) {

        QFileDialog dialog;
        dialog.setFileMode (QFileDialog::AnyFile);
        dialog.setViewMode (QFileDialog::Detail);
        dialog.setWindowModality (Qt::WindowModal);
        dialog.setWindowIcon (icon);
        QString fileNameToOpenString = dialog.getOpenFileName
                (0, tr ("Select File"),
                 QDir::currentPath(), tr ("All files (*)"));
        dialog.close();
        dialog.deleteLater();

        QByteArray fileName;
        fileName.append (fileNameToOpenString);
        scriptEnvironment.insert ("FILE_TO_OPEN", fileName);

        qDebug() << "File to open:" << QDir::toNativeSeparators (fileName);
        qDebug() << "===============";

        return false;
    }

    // Invoke 'New file' dialog from URL:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
         request.url().scheme().contains ("newfile")) {

        QFileDialog dialog;
        dialog.setFileMode (QFileDialog::AnyFile);
        dialog.setViewMode (QFileDialog::Detail);
        dialog.setWindowModality (Qt::WindowModal);
        dialog.setWindowIcon (icon);
        QString fileNameToOpenString = dialog.getSaveFileName
                (0, tr ("Create New File"),
                 QDir::currentPath(), tr ("All files (*)"));
        if (fileNameToOpenString.isEmpty())
            return false;
        dialog.close();
        dialog.deleteLater();

        QByteArray fileName;
        fileName.append (fileNameToOpenString);
        scriptEnvironment.insert ("FILE_TO_CREATE", fileName);

        qDebug() << "New file:" << QDir::toNativeSeparators (fileName);
        qDebug() << "===============";

        return false;
    }

    // Invoke 'Open folder' dialog from URL:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
         request.url().scheme().contains ("openfolder")) {

        QFileDialog dialog;
        dialog.setFileMode (QFileDialog::AnyFile);
        dialog.setViewMode (QFileDialog::Detail);
        dialog.setWindowModality (Qt::WindowModal);
        dialog.setWindowIcon (icon);
        QString folderNameToOpenString = dialog.getExistingDirectory
                (0, tr ("Select Folder"), QDir::currentPath());
        dialog.close();
        dialog.deleteLater();

        QByteArray folderName;
        folderName.append (folderNameToOpenString);
        scriptEnvironment.insert ("FOLDER_TO_OPEN", folderName);

        qDebug() << "Folder to open:" << QDir::toNativeSeparators (folderName);
        qDebug() << "===============";

        return false;
    }

#ifndef QT_NO_PRINTER
    // Print preview from URL:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
         request.url().scheme().contains ("printpreview")) {

        emit printPreviewSignal();

        return false;
    }

    // Print page from URL:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
         request.url().scheme().contains ("printing")) {

        emit printSignal();

        return false;
    }

    // Save as PDF from URL:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            request.url().scheme().contains ("pdf")) {

        emit saveAsPdfSignal();

        return false;
    }
#endif

    // Close window from URL:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
         request.url().scheme().contains ("closewindow")) {

        qDebug() << "Close window requested from URL.";
        qDebug() << "===============";

        emit closeWindowSignal();

        return false;
    }

    // Quit application from URL:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
         request.url().scheme().contains ("quit")) {

        qDebug() << "Application termination requested from URL.";
        emit quitFromURLSignal();

        return false;
    }

    // Perl debugger interaction.
    // Implementation of an idea proposed by Valcho Nedelchev.
    if (PERL_DEBUGGER_INTERACTION == 1) {

        if (navigationType == QWebPage::NavigationTypeLinkClicked and
                request.url().scheme().contains ("perl-debugger")) {

            if (Page::mainFrame()->childFrames().contains (frame)) {
                targetFrame = frame;
            }

            // Select a Perl script for debugging:
            if (request.url().toString().contains ("select-file")) {
                QFileDialog dialog;
                dialog.setFileMode (QFileDialog::ExistingFile);
                dialog.setViewMode (QFileDialog::Detail);
                dialog.setWindowModality (Qt::WindowModal);
                dialog.setWindowIcon (icon);
                QString scriptToDebug = dialog.getOpenFileName
                        (0, tr ("Select Perl File"), QDir::currentPath(),
                         tr ("Perl scripts (*.pl);;Perl modules (*.pm);;CGI scripts (*.cgi);;All files (*)"));
                dialog.close();
                dialog.deleteLater();

                if (scriptToDebug.length() > 1) {
                    QUrl scriptToDebugUrl (QUrl::fromLocalFile (scriptToDebug));
                    QString debuggerQueryString = request.url().toString (QUrl::RemoveScheme
                                                                          | QUrl::RemoveAuthority
                                                                          | QUrl::RemovePath)
                            .replace ("?", "")
                            .replace ("command=", "");
#if QT_VERSION >= 0x050000
                    QUrlQuery debuggerQuery;
                    debuggerQuery.addQueryItem (QString ("command"),
                                                QString (debuggerQueryString));
                    scriptToDebugUrl.setQuery (debuggerQuery);
#else
                    scriptToDebugUrl
                            .addQueryItem (QString ("command"),
                                           QString (debuggerQueryString));
#endif
                    qDebug() << "Perl Debugger URL:" << scriptToDebugUrl.toString();
                    qDebug() << "===============";

                    // Create new window, if requested,
                    // but only after a Perl script for debugging has been selected:
                    if ((!Page::mainFrame()->childFrames().contains (frame) and
                         (!request.url().toString().contains ("restart")))) {
                        debuggerNewWindow = new TopLevel ();
                        QString iconPathName = qApp->property ("iconPathName").toString();
                        QPixmap icon;
                        icon.load (iconPathName);
                        debuggerNewWindow->setWindowIcon (icon);
                        debuggerNewWindow->setAttribute (Qt::WA_DeleteOnClose, true);
                        debuggerNewWindow->setUrl (scriptToDebugUrl);
                        debuggerNewWindow->show();
                        debuggerNewWindow->raise();
                    }

                    if (Page::mainFrame()->childFrames().contains (frame) or
                            (request.url().toString().contains ("restart"))) {

                        // Clear these variables before starting a new session
                        // with a new file to debug. This is necessary for
                        // synchronizing debugger output and highlighted source.
                        debuggerSourceToHighlightFilePath = "";
                        debuggerLineInfoLastLine = "";

                        // Close open handler from a previous debugger session:
                        debuggerHandler.close();

                        startPerlDebuggerSlot (scriptToDebugUrl);
                    }

                    return false;
                } else {
                    return false;
                }
            }
        }

        // Transmit requests to Perl debugger (within the same page):
        if (navigationType == QWebPage::NavigationTypeFormSubmitted and
                request.url().scheme().contains ("perl-debugger")) {

            targetFrame = frame;
            startPerlDebuggerSlot (request.url());

            return false;
        }
    }

    // Load local content in the same window:
    QRegExp htmlExtensions ("\\.htm");
    htmlExtensions.setCaseSensitivity (Qt::CaseInsensitive);

    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            (QUrl (PEB_DOMAIN)).isParentOf (request.url()) and
            (Page::mainFrame()->childFrames().contains (frame))) {

        if (!request.url().path().contains (htmlExtensions)) {
            targetFrame = frame;
            frame->load (request.url());
        }

        if (request.url().path().contains (htmlExtensions)) {

            QString relativeFilePath = request.url()
                    .toString (QUrl::RemoveScheme
                               | QUrl::RemoveAuthority
                               | QUrl::RemoveFragment);
            QString fullFilePath = (qApp->property ("rootDirName").toString())+
                    relativeFilePath;
            checkFileExistenceSlot (fullFilePath);

            frame->load (QUrl::fromLocalFile
                         (QDir::toNativeSeparators
                          ((qApp->property ("rootDirName").toString())+
                           request.url().toString (
                               QUrl::RemoveScheme | QUrl::RemoveAuthority))));

            return false;
        }
    }

    // Open allowed network content in the same window:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            (Page::mainFrame()->childFrames().contains (frame)) and
            ((qApp->property ("allowedDomainsList").toStringList())
             .contains (request.url().authority()))) {

        qDebug() << "Allowed network link in the same window:" << request.url().toString();
        qDebug() << "===============";

        frame->load (request.url());

        return false;
    }

    // Open allowed network content in a new window:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            (!Page::mainFrame()->childFrames().contains (frame)) and
            ((qApp->property ("allowedDomainsList").toStringList())
             .contains (request.url().authority()))) {

        qDebug() << "Allowed network link in a new window:" << request.url().toString();
        qDebug() << "===============";

        newWindow = new TopLevel ();
        QString iconPathName = qApp->property ("iconPathName").toString();
        QPixmap icon;
        icon.load (iconPathName);
        newWindow->setWindowIcon (icon);
        newWindow->setAttribute (Qt::WA_DeleteOnClose, true);
        newWindow->setUrl (request.url());
        newWindow->show();

        return false;
    }

    return QWebPage::acceptNavigationRequest (frame, request, navigationType);
}
