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


// Application start date and time for filenames of per-session log files:
static QString applicationStartForLogFileName =
        QDateTime::currentDateTime().toString ("yyyy-MM-dd--hh-mm-ss");

// Dynamic global list of all scripts, that are started and still running in any given moment:
QStringList startedScripts;

QStringList allowedEnvironmentVariables;


// Custom message handler for redirecting all debug messages to a log file:
#if QT_VERSION >= 0x050000
// Qt5 code:
void customMessageHandler (QtMsgType type, const QMessageLogContext &context,
                           const QString &message)
#else
// Qt4 code:
void customMessageHandler (QtMsgType type, const char *message)
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

   Settings settings;

   if (settings.logMode == "single_file") {
       QFile logFile (QDir::toNativeSeparators
                      (settings.logDirFullPath+QDir::separator()+
                       settings.logPrefix+".log"));
       logFile.open (QIODevice::WriteOnly | QIODevice::Append | QIODevice::Text);
       QTextStream textStream (&logFile);
       textStream << text << endl;
   }

   if (settings.logMode == "per_session_file") {
       QFile logFile (QDir::toNativeSeparators
                      (settings.logDirFullPath+QDir::separator()+
                       settings.logPrefix+"-started-at-"+
                       applicationStartForLogFileName+".log"));
       logFile.open (QIODevice::WriteOnly | QIODevice::Append | QIODevice::Text);
       QTextStream textStream (&logFile);
       textStream << text << endl;
   }
}

int main (int argc, char **argv)
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

    // Initialize settings:
    Settings settings;

    // Load translation:
    QTranslator translator;
    if (settings.defaultTranslation != "none") {
        translator.load (settings.defaultTranslation, settings.allTranslationsDirectory);
    }
    application.installTranslator (&translator);

    // Install custom message handler for redirecting all debug messages to a log file:
    if (settings.logging == "enable") {
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
    QStringList arguments = QCoreApplication::arguments();

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
            std::cout << "  --ini       -I    absolute path of browser configuration file"
                      << std::endl;
            std::cout << "  --root      -R    absolute path of browser root folder"
                      << std::endl;
            std::cout << "  --help      -H    this help"
                      << std::endl;
            std::cout << " " << std::endl;
            if (settings.logging == "enable") {
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

    // Settings file:
    QFile settingsFile (settings.settingsFileName);

    // Check if settings file exists:
    if (!settingsFile.exists()) {

        QMessageBox msgBox;
        msgBox.setWindowModality (Qt::WindowModal);
        msgBox.setIcon (QMessageBox::Critical);
        msgBox.setWindowTitle (QMessageBox::tr ("Missing configuration file"));
        msgBox.setText (QMessageBox::tr ("Configuration file<br>")+
                        settings.settingsFileName+
                        QMessageBox::tr ("<br>is missing.<br>Please restore it."));
        msgBox.setDefaultButton (QMessageBox::Ok);
        msgBox.exec();

        return 1;
        QApplication::exit();
    }

    // Check if default theme file exists, if not - copy it from themes folder:
    if (!QFile::exists (settings.defaultThemeDirectory+QDir::separator()+
                        "current.css")) {
        QFile::copy (settings.allThemesDirectory+QDir::separator()+
                     settings.defaultTheme,
                     settings.defaultThemeDirectory+QDir::separator()+
                     "current.css");
    }

    // Log basic program information:
    qDebug() << "";
    qDebug() << application.applicationName().toLatin1().constData()
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
    int user;
    user = geteuid();

    if (user == 0) {
        qDebug() << "Program started with root privileges. Aborting!";
    }
#endif

    qDebug() << "";

#ifndef Q_OS_WIN
    // Detect if the program is started from terminal (Linux and Mac only).
    // If the browser is started from terminal, it will start another copy of itself and
    // close the first one. This is necessary for a working interaction with the Perl debugger.
    if (isatty (fileno (stdin))) {

        if (user > 0) {
            qDebug() << "Started from terminal.";
            qDebug() << "Will start another instance of the program and quit this one.";
        }

        if (settings.logging == "enable") {
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

            if (user == 0) {
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
        if (user == 0) {
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
        if (user > 0) {
            qDebug() << "Started without terminal or inside Qt Creator with user privileges.";
        }
    }

    // Prevent starting the program as root - part 3:
    if (user == 0) {
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

    // Log all settings:
    qDebug() << "===============";
    qDebug() << "GENERAL SETTINGS:";
    qDebug() << "===============";
    qDebug() << "Root folder:" << QDir::toNativeSeparators (settings.rootDirName);
    qDebug() << "Settings file name:" << settings.settingsFileName;

    qDebug() << "===============";
    qDebug() << "ENVIRONMENT SETTINGS:";
    qDebug() << "===============";
    qDebug() << "PERLLIB folder:" << settings.perlLib;
    qDebug() << "Default Perl interpreter" << settings.perlInterpreter;
    qDebug() << "Default Python interpreter" << settings.pythonInterpreter;
    qDebug() << "Default PHP interpreter" << settings.phpInterpreter;

    qDebug() << "===============";
    qDebug() << "DEBUGGER SETTINGS:";
    qDebug() << "===============";
    qDebug() << "Debugger interpreter:" << settings.debuggerInterpreter;
    qDebug() << "Debugger HTML template:" << settings.debuggerHtmlTemplate;
    qDebug() << "Source viewer:" << settings.sourceViewer;
    qDebug() << "Source viewer arguments:" << settings.sourceViewerArguments;

    qDebug() << "===============";
    qDebug() << "User Agent:" << settings.userAgent;

    qDebug() << "===============";
    qDebug() << "GUI SETTINGS:";
    qDebug() << "===============";
    qDebug() << "Start page:" << settings.startPage;
    qDebug() << "Window size:" << settings.windowSize;
    qDebug() << "Frameless window:" << settings.framelessWindow;
    qDebug() << "Stay on top:" << settings.stayOnTop;
    qDebug() << "Browser title:" << settings.browserTitle;
    qDebug() << "Context menu:" << settings.contextMenu;
    qDebug() << "Web Inspector from context menu:" << settings.webInspector;
    qDebug() << "Application icon:" << settings.iconPathName;
    qDebug() << "Default theme:" << settings.defaultTheme;
    qDebug() << "Default theme directory:" << settings.defaultThemeDirectory;
    qDebug() << "All themes directory:" << settings.allThemesDirectory;
    qDebug() << "Default translation:" << settings.defaultTranslation;
    qDebug() << "Translations directory:" << settings.allTranslationsDirectory;
    qDebug() << "System tray icon:" << settings.systrayIcon;
    qDebug() << "System tray icon double-click action:"
             << settings.systrayIconDoubleClickAction;

    qDebug() << "===============";
    qDebug() << "LOGGING SETTINGS:";
    qDebug() << "===============";
    qDebug() << "Logging:" << settings.logging;
    qDebug() << "Logging mode:" << settings.logMode;
    qDebug() << "Logfiles directory:" << settings.logDirFullPath;
    qDebug() << "Logfiles prefix:" << settings.logPrefix;
    qDebug() << "===============";

    // Check if start page exists:
    QFile startPageFile (settings.startPage);
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
    QApplication::setWindowIcon (settings.icon);

    // ENVIRONMENT VARIABLES:
    // Browser-specific environment variables:
    qputenv ("FILE_TO_OPEN", "");
    allowedEnvironmentVariables.append ("FILE_TO_OPEN");
    qputenv ("FILE_TO_CREATE", "");
    allowedEnvironmentVariables.append ("FILE_TO_CREATE");
    qputenv ("FOLDER_TO_OPEN", "");
    allowedEnvironmentVariables.append ("FOLDER_TO_OPEN");

    // PATH:
    // Get the existing PATH and set the separator sign:
    QByteArray path;
    QString pathSeparator;
#if defined (Q_OS_LINUX) or defined (Q_OS_MAC) // Linux and Mac
    QByteArray oldPath = qgetenv ("PATH");
    pathSeparator = ":";
#endif
#ifdef Q_OS_WIN // Windows
    QByteArray oldPath = qgetenv ("Path");
    pathSeparator = ";";
#endif
    path.append (oldPath);
    path.append (pathSeparator);
    // Read the INI file for folders to insert into the PATH environment variable:
    QString equalSign = "=";
    QRegExp absolutePath ("^absolute_path");
    QRegExp relativePath ("^relative_path");
    if (!settingsFile.open (QIODevice::ReadOnly | QIODevice::Text))
        return 1;
    QTextStream settingsStream (&settingsFile);
    while (!settingsStream.atEnd()) {
        QString line = settingsStream.readLine();
        if (line.contains (absolutePath)) {
            QString absolutePathToAdd = line.section (equalSign, 1, 1);
            absolutePathToAdd.replace (QString ("\n"), "");
            path.append (QDir::toNativeSeparators (absolutePathToAdd));
            path.append (pathSeparator);
        }
        if (line.contains (relativePath)) {
            QString relativePathToAdd = line.section (equalSign, 1, 1);
            relativePathToAdd.replace (QString ("\n"), "");
            path.append (QDir::toNativeSeparators (
                             settings.rootDirName+relativePathToAdd));
            path.append (pathSeparator);
        }
    }
#if defined (Q_OS_LINUX) or defined (Q_OS_MAC) // Linux and Mac
    qputenv ("PATH", path);
    allowedEnvironmentVariables.append ("PATH");
#endif
#ifdef Q_OS_WIN // Windows
    qputenv ("Path", path);
    allowedEnvironmentVariables.append ("Path");
#endif

    // DOCUMENT_ROOT:
    QByteArray documentRoot;
    documentRoot.append (QDir::toNativeSeparators (settings.rootDirName));
    qputenv ("DOCUMENT_ROOT", documentRoot);
    allowedEnvironmentVariables.append ("DOCUMENT_ROOT");

    // PERLLIB:
    QByteArray perlLib;
    QString perlLibFullPath = QDir::toNativeSeparators (settings.rootDirName+settings.perlLib);
    perlLib.append (perlLibFullPath);
    qputenv ("PERLLIB", perlLib);
    allowedEnvironmentVariables.append ("PERLLIB");

    TopLevel toplevel (QString ("mainWindow"));

    QObject::connect (qApp, SIGNAL (lastWindowClosed()),
                      &toplevel, SLOT (quitApplicationSlot()));

    toplevel.setWindowIcon (settings.icon);
    toplevel.loadStartPageSlot();
    toplevel.show();

    TrayIcon trayicon;

    if (settings.systrayIcon == "enable") {
        QObject::connect (trayicon.aboutAction, SIGNAL (triggered()),
                          &toplevel, SLOT (aboutSlot()));

        QObject::connect (trayicon.quitAction, SIGNAL (triggered()),
                          &toplevel, SLOT (quitApplicationSlot()));

        QObject::connect (&toplevel, SIGNAL (trayIconHideSignal()),
                          &trayicon, SLOT (trayIconHideSlot()));
    }

    return application.exec();

}


Settings::Settings()
    : QSettings (0)
{

    // Get command line arguments:
    QStringList arguments = QCoreApplication::arguments();

    // Settings file:
    foreach (QString argument, arguments){
        if (argument.contains ("--ini") or argument.contains ("-I")) {
            settingsFileName = QDir::toNativeSeparators (argument.section ("=", 1, 1));
            settingsDir = QFileInfo(
                        QDir::toNativeSeparators (settingsFileName)).absolutePath();
            settingsDirName = settingsDir.absolutePath().toLatin1();
        } else {
#ifndef Q_OS_MAC
            settingsDir = QDir::toNativeSeparators (QApplication::applicationDirPath());
#endif
#ifdef Q_OS_MAC
    if (BUNDLE == 1) {
        settingsDir = QDir::toNativeSeparators (QApplication::applicationDirPath());
        settingsDir.cdUp();
        settingsDir.cdUp();
    }
#endif
            settingsDirName = settingsDir.absolutePath().toLatin1();
            settingsFileName = QDir::toNativeSeparators
                    (settingsDirName+QDir::separator()+"peb.ini");
        }
    }
    QSettings settings (settingsFileName, QSettings::IniFormat);

    // Root directory:
    foreach (QString argument, arguments){
        if (argument.contains ("--root") or argument.contains ("-R")) {
            rootDirName = QDir::toNativeSeparators (argument.section ("=", 1, 1));
            rootDirName.replace ("\n", "");
        } else {
            QString rootDirNameSetting = settings.value ("root/root").toString();
            if (rootDirNameSetting == "current") {
                rootDirName = settingsDirName;
            } else {
                rootDirName = QDir::toNativeSeparators (rootDirNameSetting);
            }
        }
    }
    if (!rootDirName.endsWith (QDir::separator())) {
        rootDirName.append (QDir::separator());
    }

    // Environment settings:
    perlLib = settings.value ("environment/perllib").toString();

    // Interpreters:
    perlInterpreter = settings.value ("interpreters/perl").toString();
    pythonInterpreter = settings.value ("interpreters/python").toString();
    phpInterpreter = settings.value ("interpreters/php").toString();

    // Perl debugger settings:
    debuggerInterpreter = settings.value ("perl_debugger/debugger_interpreter").toString();

    QString debuggerHtmlTemplateSetting = settings.value (
                "perl_debugger/debugger_html_template").toString();
    debuggerHtmlTemplate = QDir::toNativeSeparators (
                rootDirName+debuggerHtmlTemplateSetting);

    QString sourceViewerSetting = settings.value ("perl_debugger/source_viewer").toString();
    sourceViewer = QDir::toNativeSeparators (rootDirName+sourceViewerSetting);

    QString sourceViewerArgumentsSetting =
            settings.value ("perl_debugger/source_viewer_arguments").toString();
    sourceViewerArgumentsSetting.replace ("\n", "");
    sourceViewerArguments = sourceViewerArgumentsSetting.split(" ");

    userAgent = settings.value ("networking/user_agent").toString();

    // Read the INI file for a list of allowed web sites:
    QFile settingsFile (settingsFileName);
    QString equalSign = "=";
    QRegExp allowedWebsite ("^allowed_website");
    if (settingsFile.open (QIODevice::ReadOnly | QIODevice::Text)) {
        QTextStream settingsStream (&settingsFile);
        while (!settingsStream.atEnd()) {
            QString line = settingsStream.readLine();
            if (line.contains (allowedWebsite)) {
                QString allowedWebsiteToAdd = line.section (equalSign, 1, 1);
                allowedWebsiteToAdd.replace (QString ("\n"), "");
                allowedWebSites.append (allowedWebsiteToAdd);
            }
        }
    }

    // Start page:
    startPageSetting = settings.value ("gui/start_page").toString();
    startPage = QDir::toNativeSeparators (rootDirName+startPageSetting);

    // Basic GUI settings:
    windowSize = settings.value ("gui/window_size").toString();
    framelessWindow = settings.value ("gui/frameless_window").toString();
    stayOnTop = settings.value ("gui/stay_on_top") .toString();
    browserTitle = settings.value ("gui/browser_title").toString();
    contextMenu = settings.value ("gui/context_menu").toString();
    webInspector = settings.value ("gui/web_inspector").toString();
    if (windowSize != "maximized" or windowSize != "fullscreen") {
        fixedWidth = windowSize.section ("x", 0, 0) .toInt();
        fixedHeight = windowSize.section ("x", 1, 1) .toInt();
    }

    // Icon:
    QString iconPathNameSetting = settings.value ("gui/icon").toString();
    iconPathName =
            QDir::toNativeSeparators (rootDirName+iconPathNameSetting);
    icon.load (iconPathName);

    // GUI theme:
    defaultTheme = settings.value ("gui/default_theme").toString();
    QString defaultThemeDirectorySetting =
            settings.value ("gui/default_theme_directory").toString();
    defaultThemeDirectory =
            QDir::toNativeSeparators (rootDirName+defaultThemeDirectorySetting);
    QString allThemesDirectorySetting =
            settings.value ("gui/all_themes_directory").toString();
    allThemesDirectory =
            QDir::toNativeSeparators (rootDirName+allThemesDirectorySetting);

    // Translation:
    defaultTranslation = settings.value ("gui/default_translation").toString();
    QString allTranslationsDirectorySetting =
            settings.value ("gui/all_translations_directory").toString();
    allTranslationsDirectory = QDir::toNativeSeparators (
                rootDirName+allTranslationsDirectorySetting);

    // Help:
    QString helpDirectorySetting =
            settings.value ("gui/help_directory").toString();
    helpDirectory = QDir::toNativeSeparators (
                rootDirName+helpDirectorySetting);

    // System tray icon:
    systrayIcon = settings.value ("gui/systray_icon").toString();
    systrayIconDoubleClickAction =
            settings.value ("gui/systray_icon_double_click_action").toString();

    // Logging:
    logging = settings.value ("logging/logging").toString();
    logMode = settings.value ("logging/logging_mode").toString();
    logDirName = settings.value ("logging/logging_directory").toString();
    QDir logDir (logDirName);
    if (!logDir.exists ()) {
        logDir.mkpath(".");
    }
    if (logDir.isRelative()) {
        logDirFullPath = QDir::toNativeSeparators (rootDirName+logDirName);
    }
    if (logDir.isAbsolute()) {
        logDirFullPath = QDir::toNativeSeparators (logDirName);
    }
    logPrefix = settings.value ("logging/logging_prefix").toString();

    // Regular expressions for file type detection by shebang line:
    perlShebang.setPattern ("#!/.{1,}perl");
    pythonShebang.setPattern ("#!/.{1,}python");
    phpShebang.setPattern ("#!/.{1,}php");

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

    pyExtension.setPattern ("py");
    pyExtension.setCaseSensitivity (Qt::CaseInsensitive);

    phpExtension.setPattern ("php");
    phpExtension.setCaseSensitivity (Qt::CaseInsensitive);

}


TrayIcon::TrayIcon()
    : QSystemTrayIcon(0)
{

    if (settings.systrayIcon == "enable") {
        trayIcon = new QSystemTrayIcon();
        trayIcon->setIcon (settings.icon);
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
    if (settings.webInspector == "enable") {
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
    QWebSettings::clearMemoryCaches();

    QObject::connect (&scriptHandler, SIGNAL (readyReadStandardOutput()),
                       this, SLOT (scriptOutputSlot()));
    QObject::connect (&scriptHandler, SIGNAL (readyReadStandardError()),
                       this, SLOT (scriptErrorSlot()));
    QObject::connect (&scriptHandler, SIGNAL (finished (int, QProcess::ExitStatus)),
                       this, SLOT (scriptFinishedSlot()));

    QObject::connect (&debuggerHandler, SIGNAL (readyReadStandardOutput()),
                       this, SLOT (debuggerOutputSlot()));
    QObject::connect (this, SIGNAL (sourceCodeForDebuggerReadySignal()),
                       this, SLOT (displaySourceCodeAndDebuggerOutputSlot()));

    sourceViewerForPerlDebuggerStarted = false;

}


TopLevel::TopLevel (QString type)
    : QWebView(0)
{

    if (type == "mainWindow") {
        // Configure keyboard shortcuts - main window:
        QShortcut *minimizeShortcut = new QShortcut (Qt::Key_Escape, this);
        QObject::connect (minimizeShortcut, SIGNAL (activated()),
                          this, SLOT (minimizeSlot()));

        QShortcut *maximizeShortcut = new QShortcut (QKeySequence ("Ctrl+M"), this);
        QObject::connect (maximizeShortcut, SIGNAL (activated()),
                          this, SLOT (maximizeSlot()));

        QShortcut *toggleFullScreenShortcut = new QShortcut (Qt::Key_F11, this);
        QObject::connect (toggleFullScreenShortcut, SIGNAL (activated()),
                          this, SLOT (toggleFullScreenSlot()));

        QShortcut *homeShortcut = new QShortcut (Qt::Key_F12, this);
        QObject::connect (homeShortcut, SIGNAL (activated()),
                          this, SLOT (loadStartPageSlot()));

        QShortcut *reloadShortcut = new QShortcut (QKeySequence ("Ctrl+R"), this);
        QObject::connect (reloadShortcut, SIGNAL (activated()),
                          this, SLOT (reloadSlot()));

        QShortcut *printShortcut = new QShortcut (QKeySequence ("Ctrl+P"), this);
        QObject::connect (printShortcut, SIGNAL (activated()),
                          this, SLOT (printSlot()));

        QShortcut *closeAppShortcut = new QShortcut (QKeySequence ("Ctrl+X"), this);
        QObject::connect (closeAppShortcut, SIGNAL (activated()),
                          this, SLOT (quitApplicationSlot()));

        // Configure screen appearance - main window:
        if (settings.fixedWidth > 100 and settings.fixedHeight > 100) {
            setFixedSize (settings.fixedWidth, settings.fixedHeight);
            QRect screenRect = QDesktopWidget().screen()->rect();
            move (QPoint (screenRect.width() / 2 - width() / 2,
                          screenRect.height() / 2 - height() / 2));
        }
        if (settings.windowSize == "maximized") {
            showMaximized();
        }
        if (settings.windowSize == "fullscreen") {
            showFullScreen();
        }
        if (settings.stayOnTop == "enable") {
            setWindowFlags (Qt::WindowStaysOnTopHint);
        }
        if (settings.stayOnTop == "enable" and settings.framelessWindow == "enable") {
            setWindowFlags (Qt::WindowStaysOnTopHint | Qt::FramelessWindowHint);
        }
        if (settings.stayOnTop == "disable" and settings.framelessWindow == "enable") {
            setWindowFlags (Qt::FramelessWindowHint);
        }
        if (settings.browserTitle != "dynamic") {
            setWindowTitle (settings.browserTitle);
        }
        if (settings.contextMenu == "disable") {
            setContextMenuPolicy (Qt::NoContextMenu);
        }
    }

    if (type == "messageBox") {
        // Configure keyboard shortcuts - message box:
        QShortcut *escapeShortcut = new QShortcut (Qt::Key_Escape, this);
        QObject::connect (escapeShortcut, SIGNAL (activated()), this, SLOT (close()));

        QShortcut *enterShortcut = new QShortcut (Qt::Key_Return, this);
        QObject::connect (enterShortcut, SIGNAL (activated()), this, SLOT (close()));
    }

    mainPage = new Page();

    QObject::connect (mainPage, SIGNAL (closeWindowSignal()),
                      this, SLOT (close()));

    if (type == "mainWindow") {
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

        if (settings.browserTitle == "dynamic") {
            QObject::connect (mainPage, SIGNAL (loadFinished (bool)),
                              this, SLOT (pageLoadedDynamicTitleSlot (bool)));
        } else {
            QObject::connect (mainPage, SIGNAL (loadFinished (bool)),
                              this, SLOT (pageLoadedStaticTitleSlot (bool)));
        }
    }

    if (type == "messageBox") {
        // Connect signals and slots - message box:
        QObject::connect (mainPage, SIGNAL (loadFinished (bool)),
                          this, SLOT (pageLoadedDynamicTitleSlot (bool)));
    }

    setPage (mainPage);

    // Use modified Network Access Manager with every window of the program:
    ModifiedNetworkAccessManager *nam = new ModifiedNetworkAccessManager();
    mainPage->setNetworkAccessManager (nam);

    QObject::connect (nam, SIGNAL (startScriptSignal (QUrl, QByteArray)),
                      mainPage, SLOT (startScriptSlot (QUrl, QByteArray)));

    // Disable history:
    QWebHistory *history = mainPage->history();
    history->setMaximumItemCount (0);

    if (type == "mainWindow") {
        // Cookies and HTTPS support:
        QNetworkCookieJar *jar = new QNetworkCookieJar;
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
        mainPage->action (QWebPage::OpenImageInNewWindow)->setVisible (false);
        mainPage->action (QWebPage::DownloadImageToDisk)->setVisible (false);
    }

    if (type == "messageBox") {
        mainPage->setLinkDelegationPolicy (QWebPage::DelegateAllLinks);
        mainPage->mainFrame()->setScrollBarPolicy (Qt::Horizontal, Qt::ScrollBarAlwaysOff);
        mainPage->mainFrame()->setScrollBarPolicy (Qt::Vertical, Qt::ScrollBarAlwaysOff);

        setWindowIcon (settings.icon);
        setWindowFlags (Qt::WindowStaysOnTopHint);
        setContextMenuPolicy (Qt::NoContextMenu);
    }

}

// Manage clicking of links:
bool Page::acceptNavigationRequest (QWebFrame *frame,
                                     const QNetworkRequest &request,
                                     QWebPage::NavigationType navigationType)
{

    // Select Perl interpreter:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
         request.url().scheme().contains ("selectperl")) {

        QFileDialog dialog;
        dialog.setFileMode (QFileDialog::AnyFile);
        dialog.setViewMode (QFileDialog::Detail);
        dialog.setWindowModality (Qt::WindowModal);
        dialog.setWindowIcon (settings.icon);
        QString perlInterpreter = dialog.getOpenFileName
                (0, tr ("Select Perl Interpreter"),
                 QDir::currentPath(), tr ("All files (*)"));
        dialog.close();
        dialog.deleteLater();

        if (perlInterpreter.length() > 0) {
            settings.saveSetting (QString ("perl"), perlInterpreter);

            qDebug() << "Selected Perl interpreter:" << perlInterpreter;

            QFileDialog selectPerlLibDialog;
            selectPerlLibDialog.setFileMode (QFileDialog::AnyFile);
            selectPerlLibDialog.setViewMode (QFileDialog::Detail);
            selectPerlLibDialog.setWindowModality (Qt::WindowModal);
            selectPerlLibDialog.setWindowIcon (settings.icon);
            QString perlLibFolderNameString = selectPerlLibDialog.getExistingDirectory
                    (0, tr ("Select PERLLIB"), QDir::currentPath());
            selectPerlLibDialog.close();
            selectPerlLibDialog.deleteLater();

            QByteArray perlLibFolderName;
            perlLibFolderName.append (perlLibFolderNameString);
            qputenv ("PERLLIB", perlLibFolderName);

            qDebug() << "Selected PERLLIB:" << perlLibFolderName;
            qDebug() << "===============";
        }

        return false;
    }

    // Select Python interpreter:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
         request.url().scheme().contains ("selectpython")) {

        QFileDialog dialog;
        dialog.setFileMode (QFileDialog::AnyFile);
        dialog.setViewMode (QFileDialog::Detail);
        dialog.setWindowModality (Qt::WindowModal);
        dialog.setWindowIcon (settings.icon);
        QString pythonInterpreter = dialog.getOpenFileName
                (0, tr ("Select Python Interpreter"),
                 QDir::currentPath(), tr ("All files (*)"));
        dialog.close();
        dialog.deleteLater();

        if (pythonInterpreter.length() > 0) {
            settings.saveSetting (QString ("python"), pythonInterpreter);

            qDebug() << "Selected Python interpreter:" << pythonInterpreter;
            qDebug() << "===============";
        }

        return false;
    }

    // Select PHP interpreter:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
         request.url().scheme().contains ("selectphp")) {

        QFileDialog dialog;
        dialog.setFileMode (QFileDialog::AnyFile);
        dialog.setViewMode (QFileDialog::Detail);
        dialog.setWindowModality (Qt::WindowModal);
        dialog.setWindowIcon (settings.icon);
        QString phpInterpreter = dialog.getOpenFileName
                (0, tr ("Select PHP Interpreter"),
                 QDir::currentPath(), tr ("All files (*)"));
        dialog.close();
        dialog.deleteLater();

        if (phpInterpreter.length() > 0) {
            settings.saveSetting (QString ("php"), phpInterpreter);

            qDebug() << "Selected PHP interpreter:" << phpInterpreter;
            qDebug() << "===============";
        }

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
        dialog.setWindowIcon (settings.icon);
        QString fileNameToOpenString = dialog.getOpenFileName
                (0, tr ("Select File"),
                 QDir::currentPath(), tr ("All files (*)"));
        dialog.close();
        dialog.deleteLater();

        QByteArray fileName;
        fileName.append (fileNameToOpenString);
        qputenv ("FILE_TO_OPEN", fileName);

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
        dialog.setWindowIcon (settings.icon);
        QString fileNameToOpenString = dialog.getSaveFileName
                (0, tr ("Create New File"),
                 QDir::currentPath(), tr ("All files (*)"));
        if (fileNameToOpenString.isEmpty())
            return false;
        dialog.close();
        dialog.deleteLater();

        QByteArray fileName;
        fileName.append (fileNameToOpenString);
        qputenv ("FILE_TO_CREATE", fileName);

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
        dialog.setWindowIcon (settings.icon);
        QString folderNameToOpenString = dialog.getExistingDirectory
                (0, tr ("Select Folder"), QDir::currentPath());
        dialog.close();
        dialog.deleteLater();

        QByteArray folderName;
        folderName.append (folderNameToOpenString);
        qputenv ("FOLDER_TO_OPEN", folderName);

        qDebug() << "Folder to open:" << QDir::toNativeSeparators (folderName);
        qDebug() << "===============";

        return false;
    }

    // Display information about user-selected Perl scripts using the built-in Perl debugger.
    // Partial implementation of an idea proposed by Valcho Nedelchev.
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            request.url().toString().contains (PERL_DBG_DOMAIN)) {

        if (request.url().path().contains ("selectfile")) {
            QFileDialog dialog;
            dialog.setFileMode (QFileDialog::ExistingFile);
            dialog.setViewMode (QFileDialog::Detail);
            dialog.setWindowModality (Qt::WindowModal);
            dialog.setWindowIcon (settings.icon);
            debuggedScriptFilePath = "";
            debuggedScriptFilePath = dialog.getOpenFileName
                    (0, tr ("Select Perl File"), QDir::currentPath(),
                     tr ("Perl scripts (*.pl);;Perl modules (*.pm);;CGI scripts (*.cgi);;All files (*)"));
            dialog.close();
            dialog.deleteLater();
        }

        if (debuggedScriptFilePath.length() > 1) {

//            newWindow = new TopLevel (QString ("mainWindow"));
//            newWindow->setWindowIcon (settings.icon);
//            newWindow->setAttribute (Qt::WA_DeleteOnClose, true);

            QUrl debuggerRequestUrl = request.url();
            qDebug() << "Perl Debugger URL:" << debuggerRequestUrl.toString();

            startPerlDebugger (debuggerRequestUrl);
        }

        return false;
    }

    // Send command to the Perl debugger via web form:
    if (navigationType == QWebPage::NavigationTypeFormSubmitted and
            request.url().toString().contains (PERL_DBG_DOMAIN)) {

        qDebug() << "Perl Debugger URL:" << request.url().toString();

        startPerlDebugger (request.url());

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

    // Load local HTML page in the same window:
    QRegExp htmlExtensions ("\\.htm");
    htmlExtensions.setCaseSensitivity (Qt::CaseInsensitive);

    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            (QUrl (PEB_DOMAIN)).isParentOf (request.url()) and
            request.url().path().contains (htmlExtensions) and
            (Page::mainFrame()->childFrames().contains (frame))) {

        QString relativeFilePath = request.url()
                .toString (QUrl::RemoveScheme
                           | QUrl::RemoveAuthority
                           | QUrl::RemoveFragment);
        QString fullFilePath = settings.rootDirName+relativeFilePath;
        checkFileExistenceSlot (fullFilePath);

        frame->load (QUrl::fromLocalFile
                     (QDir::toNativeSeparators
                      (settings.rootDirName+
                       request.url().toString (
                           QUrl::RemoveScheme | QUrl::RemoveAuthority))));

        QWebSettings::clearMemoryCaches();

        return false;
    }

    // Open allowed web content in the same window:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            (Page::currentFrame() == frame) and
            (settings.allowedWebSites.contains (request.url().authority()))) {

        qDebug() << "Allowed web link in the same window:" << request.url().toString();
        qDebug() << "===============";

        frame->load (request.url());

        QWebSettings::clearMemoryCaches();

        return false;
    }

    // Open allowed web content in a new window:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            (!Page::mainFrame()->childFrames().contains (frame)) and
            (settings.allowedWebSites.contains (request.url().authority()))) {

        qDebug() << "Allowed web link in a new window:" << request.url().toString();
        qDebug() << "===============";

        newWindow = new TopLevel (QString ("mainWindow"));
        newWindow->setWindowIcon (settings.icon);
        newWindow->setAttribute (Qt::WA_DeleteOnClose, true);
        newWindow->setUrl (request.url());
        newWindow->show();

        QWebSettings::clearMemoryCaches();

        return false;
    }

    // Open clicked links to NOT allowed web content using default browser:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            request.url().scheme().contains ("http") and
            (!request.url().toString().contains (PEB_DOMAIN)) and
            (!request.url().toString().contains (PERL_DBG_DOMAIN)) and
            (!request.url().authority().contains ("localhost")) and
            (!settings.allowedWebSites.contains (request.url().authority()))) {

        qDebug() << "Default browser called for not allowed web link:"
                 << request.url().toString();
        qDebug() << "===============";

        QDesktopServices::openUrl (request.url());

        return false;
    }

    // Open local file using default application:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
             request.url().scheme().contains ("file")) {

        QString filepath = request.url()
                .toString (QUrl::RemoveScheme)
                .replace ("///", "/");

        QFile file (QDir::toNativeSeparators (filepath));
        if (file.exists()) {

            qDebug() << "Opening file with default application:" << filepath;
            qDebug() << "===============";

            QDesktopServices::openUrl (request.url());

            return false;

        } else {

            QMessageBox msgBox;
            msgBox.setWindowModality (Qt::WindowModal);
            msgBox.setIcon (QMessageBox::Critical);
            msgBox.setWindowTitle (tr ("Missing file"));
            msgBox.setText (filepath+
                            tr (" is missing.<br>Please restore the missing file."));
            msgBox.setDefaultButton (QMessageBox::Ok);
            msgBox.exec();

            qDebug() << "Missing file:" << filepath;
            qDebug() << "===============";

            return false;
        }
    }

    // Execute external command or application:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            request.url().scheme().contains ("external")) {

        QString externalCommand = request.url().toString().replace ("external:", "");

        qDebug() << "External command:" << externalCommand;
        qDebug() << "===============";

        QProcess externalProcess;
        externalProcess.startDetached (externalCommand);

        return false;
    }

    return QWebPage::acceptNavigationRequest (frame, request, navigationType);
}
