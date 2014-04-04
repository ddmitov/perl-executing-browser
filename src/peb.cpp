
// Perl Executing Browser, v. 0.1

// This program is free software;
// you can redistribute it and/or modify it under the terms of the
// GNU General Public License, as published by the Free Software Foundation;
// either version 3 of the License, or (at your option) any later version.
// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
// without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
// Dimitar D. Mitov, 2013 - 2014, ddmitov (at) yahoo (dot) com
// Valcho Nedelchev, 2014

#include <qglobal.h>
#if QT_VERSION >= 0x050000
// Qt5 code:
#include <QtWidgets>
#else
// Qt4 code:
#include <QtGui>
#include <QApplication>
#endif

#include <QWebPage>
#include <QWebView>
#include <QWebFrame>
#include <QWebHistory>
#include <QtNetwork/QNetworkRequest>
#include <QProcess>
#include <QPrintDialog>
#include <QPrinter>
#include <QDateTime>
#include <QSystemTrayIcon>
#include <QIcon>
#include <QDebug>
#include "peb.h"
#include <unistd.h> // for isatty()
#include <iostream> // for std::cout

static QString applicationStartForLogFileName =
        QDateTime::currentDateTime().toString ("yyyy-MM-dd--hh-mm-ss");

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
         text += QString ("{Debug} %1").arg (message);
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
   if (settings.logFile == "single") {
       QFile logFile (QDir::toNativeSeparators
                      (settings.rootDirName+
                       QDir::separator()+
                       "peb.log"));
       logFile.open (QIODevice::WriteOnly | QIODevice::Append | QIODevice::Text);
       QTextStream textStream (&logFile);
       textStream << text << endl;
   }
   if (settings.logFile == "per_session") {
       QFile logFile (QDir::toNativeSeparators
                      (settings.rootDirName+
                       QDir::separator()+
                       "peb-started-at-"+
                       applicationStartForLogFileName+".log"));
       logFile.open (QIODevice::WriteOnly | QIODevice::Append | QIODevice::Text);
       QTextStream textStream (&logFile);
       textStream << text << endl;
   }

}

int main (int argc, char **argv)
{

    QApplication application (argc, argv);

    application.setOrganizationName ("PEB-Dev-Team");
    //application.setOrganizationDomain ("peb.org");
    application.setApplicationName ("Perl Executing Browser");
    application.setApplicationVersion ("0.1");

    Settings settings;

    if (settings.logging == "yes") {
#if QT_VERSION >= 0x050000
        // Qt5 code:
        qInstallMessageHandler (customMessageHandler);
#else
        // Qt4 code:
        qInstallMsgHandler (customMessageHandler);
#endif
    }

    // Get current date and time for the log file and the command line output:
    QString applicationStartForLogging = QDateTime::currentDateTime().toString ("dd.MM.yyyy hh:mm:ss");

    // Display command line help:
    QStringList arguments = QCoreApplication::arguments();
    foreach (QString argument, arguments){
        if (argument.contains ("--help") or argument.contains ("-h")) {
            std::cout << " " << std::endl;
            std::cout << "Perl Executing Browser v.0.1 started on: "
                      << applicationStartForLogging.toLatin1().constData() << std::endl;
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
            std::cout << "  --root      -r    absolute path of the browser root folder"
                      << std::endl;
            std::cout << "  --webserver -w    start a local webserver with the browser: 'yes' or 'no'"
                      << std::endl;
            std::cout << "  --help      -h    this help"
                      << std::endl;
            std::cout << " " << std::endl;
            QString dateTimeString = QDateTime::currentDateTime().toString ("dd.MM.yyyy hh:mm:ss");
            qDebug() << "Perl Executing Browser v.0.1 displayed help and terminated normally on:"
                     << dateTimeString;
            qDebug() << "===============";
            return 1;
            QApplication::exit();
        }
    }

    qDebug() << "===============";
    qDebug() << "Perl Executing Browser v.0.1 started on:" << applicationStartForLogging;
    qDebug() << "Application file path:"
             << QDir::toNativeSeparators (QApplication::applicationFilePath());
    QString allArguments;
    foreach (QString argument, arguments){
                     allArguments.append (argument);
                     allArguments.append (" ");
                 }
    allArguments.replace (QRegExp ("\\s$"), "");
    qDebug() << "Command line:" << allArguments;
    qDebug() << "Qt WebKit version:" << QTWEBKIT_VERSION_STR;
    qDebug() << "Qt version:" << QT_VERSION_STR;

#ifndef Q_OS_WIN
    if (isatty (fileno (stdin))) {
        qDebug() << "Started from terminal.";
        qDebug() << "Will start another instance of the program and quit this one.";

        if (settings.logging == "yes") {
            std::cout << " " << std::endl;
            std::cout << "Perl Executing Browser v.0.1 started on: "
                      << applicationStartForLogging.toLatin1().constData() << std::endl;
            std::cout << "Application file path: "
                      << (QDir::toNativeSeparators (
                              QApplication::applicationFilePath()).toLatin1().constData())
                      << std::endl;
            std::cout << "Qt WebKit version: " << QTWEBKIT_VERSION_STR << std::endl;
            std::cout << "Qt version: " << QT_VERSION_STR << std::endl;
            std::cout << " " << std::endl;
            std::cout << "Started from terminal." << std::endl;
            std::cout << "Will start another instance of the program and quit this one."
                      << std::endl;
            std::cout << " " << std::endl;
        }

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

        qDebug() << "===============";

    } else {
        qDebug() << "Started without terminal or inside Qt Creator.";
        qDebug() << "===============";
    }
#endif

#if QT_VERSION >= 0x050000
    QTextCodec::setCodecForLocale (QTextCodec::codecForName ("UTF8"));
#else
    QTextCodec::setCodecForCStrings (QTextCodec::codecForName ("UTF8"));
#endif

    QPixmap emptyTransparentIcon (16, 16);
    emptyTransparentIcon.fill (Qt::transparent);
    QApplication::setWindowIcon (QIcon (emptyTransparentIcon));

    qDebug() << "Root folder:" << settings.rootDirName;
    qDebug() << "===============";

    QFile settingsFile (settings.settingsFileName);
    if (!settingsFile.exists()) {
        qDebug() << "===============";
        qDebug() << QDir::toNativeSeparators (settings.settingsFileName)
                 << "is missing.";
        qDebug() << "Please restore the missing file.";
        qDebug() << "Exiting.";
        qDebug() << "===============";
        QMessageBox msgBox;
        msgBox.setIcon (QMessageBox::Critical);
        msgBox.setWindowTitle ("Critical file missing");
        msgBox.setText ("'peb.ini' is missing.<br>Please restore the missing file.");
        msgBox.setDefaultButton (QMessageBox::Ok);
        msgBox.exec();
        return 1;
        QApplication::exit();
    } else {
        qDebug() << "Settings file found:" << settings.settingsFileName;
    }

    QString startPageFileName (QDir::toNativeSeparators
                         (settings.rootDirName+
                          QDir::separator()+settings.startPage));
    QFile startPageFile (startPageFileName);
    if (!startPageFile.exists()) {
        qDebug() << "===============";
        qDebug() << QDir::toNativeSeparators (startPageFileName)
                 << "is missing.";
        qDebug() << "Please restore the missing start page.";
        qDebug() << "Exiting.";
        qDebug() << "===============";
        QMessageBox msgBox;
        msgBox.setIcon (QMessageBox::Critical);
        msgBox.setWindowTitle ("Missing start page");
        msgBox.setText (QDir::toNativeSeparators (startPageFileName)+
                        " is missing.<br>Please restore the missing start page.");
        msgBox.setDefaultButton (QMessageBox::Ok);
        msgBox.exec();
        return 1;
        QApplication::exit();
    } else {
        qDebug() << "Start page found:" << startPageFileName;
        qDebug() << "===============";
    }

    QApplication::setWindowIcon (settings.icon);
    qDebug() << "Application icon:" << settings.iconPathName;
    qDebug() << "===============";

    // ENVIRONMENT VARIABLES:
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
            path.append (QDir::toNativeSeparators (settings.rootDirName+
                                                   QDir::separator()+relativePathToAdd));
            path.append (pathSeparator);
        }
    }
#if defined (Q_OS_LINUX) or defined (Q_OS_MAC) // Linux and Mac
    qputenv ("PATH", path);
#endif
#ifdef Q_OS_WIN // Windows
    qputenv ("Path", path);
#endif

    // DOCUMENT_ROOT:
    QByteArray documentRoot;
    documentRoot.append (QDir::toNativeSeparators (settings.rootDirName));
    qputenv ("DOCUMENT_ROOT", documentRoot);

    // PERLLIB:
    QByteArray perlLib;
    QString perlLibFullPath = QDir::toNativeSeparators (
                settings.rootDirName+QDir::separator()+settings.perlLib);
    perlLib.append (perlLibFullPath);
    qputenv ("PERLLIB", perlLib);

    // Browser-specific environment variables:
    qputenv ("PERL_INTERPRETER", "");
    qputenv ("PYTHON_INTERPRETER", "");
    qputenv ("PHP_INTERPRETER", "");
    qputenv ("FILE_TO_OPEN", "");
    qputenv ("FOLDER_TO_OPEN", "");
    qputenv ("NEW_FILE", "");

    TopLevel toplevel;
    QObject::connect (qApp, SIGNAL (lastWindowClosed()),
                      &toplevel, SLOT (quitApplicationSlot()));

    toplevel.setWindowIcon (settings.icon);
    toplevel.loadStartPageSlot();
    toplevel.show();

    Watchdog watchdog;
    QObject::connect (watchdog.aboutAction, SIGNAL (triggered()),
                      &toplevel, SLOT (aboutSlot()));
    QObject::connect (watchdog.quitAction, SIGNAL (triggered()),
                      &toplevel, SLOT (quitApplicationSlot()));
    QObject::connect (qApp, SIGNAL (aboutToQuit()),
                      &watchdog, SLOT (aboutToQuitSlot()));

    return application.exec();

}

Settings::Settings()
    : QSettings (0)
{

    // Settings folder:
#ifdef Q_OS_MAC
    if (BUNDLE == 1) {
        iniDir = QDir::toNativeSeparators (QApplication::applicationDirPath());
        iniDir.cdUp();
        iniDir.cdUp();
        rootDirName = iniDir.absolutePath().toLatin1();
    }
#endif
    iniDir = QDir::toNativeSeparators (QApplication::applicationDirPath());
    iniDirName = iniDir.absolutePath().toLatin1();

    // Settings file:
    settingsFileName = QDir::toNativeSeparators
            (iniDirName+QDir::separator()+"peb.ini");
    QSettings settings (settingsFileName, QSettings::IniFormat);

    // Browser root directory:
    QString rootDirNameSetting = settings.value ("root_directory/path").toString();
    if (rootDirNameSetting == "current") {
        rootDirName = iniDirName;
    } else {
        rootDirName = rootDirNameSetting;
    }

    // Environment settings:
    perlLib = settings.value ("environment/perllib").toString();

    // Interpreters:
    QByteArray perlInterpreterByteArray = qgetenv ("PERL_INTERPRETER");
    QString perlInterpreter (perlInterpreterByteArray);
    if (perlInterpreter.length() == 0) {
        QString defaultPerlInterpreter = settings.value ("interpreters/perl").toString();
        if (defaultPerlInterpreter == "system") {
            qputenv ("PERL_INTERPRETER", "perl");
        } else {
            QByteArray perlInterpreterByteArray;
            perlInterpreterByteArray.append (defaultPerlInterpreter);
            qputenv ("PERL_INTERPRETER", perlInterpreterByteArray);
        }
    }
    QByteArray pythonInterpreterByteArray = qgetenv ("PYTHON_INTERPRETER");
    QString pythonInterpreter (pythonInterpreterByteArray);
    if (pythonInterpreter.length() == 0) {
        QString defaultPythonInterpreter = settings.value ("interpreters/python").toString();
        if (defaultPythonInterpreter == "system") {
            qputenv ("PYTHON_INTERPRETER", "python");
        } else {
            QByteArray pythonInterpreterByteArray;
            pythonInterpreterByteArray.append (defaultPythonInterpreter);
            qputenv ("PYTHON_INTERPRETER", pythonInterpreterByteArray);
        }
    }
    QByteArray phpInterpreterByteArray = qgetenv ("PHP_INTERPRETER");
    QString phpInterpreter (phpInterpreterByteArray);
    if (phpInterpreter.length() == 0) {
        QString defaultPhpInterpreter = settings.value ("interpreters/php").toString();
        if (defaultPhpInterpreter == "system") {
            qputenv ("PHP_INTERPRETER", "php");
        } else {
            QByteArray phpInterpreterByteArray;
            phpInterpreterByteArray.append (defaultPhpInterpreter);
            qputenv ("PHP_INTERPRETER", phpInterpreterByteArray);
        }
    }

    // Perl debugger settings:
    debuggerInterpreter = settings.value ("perl_debugger/debugger_interpreter").toString();

    // Local webserver general settings:
    autostartLocalWebserver = settings.value ("local_webserver/autostart").toString();

    // Mongoose local web server settings:
    mongooseSettingsFileName = QDir::toNativeSeparators
            (rootDirName+QDir::separator()+"mongoose.conf");
    QFile mongooseSettingsFile (mongooseSettingsFileName);
    QRegExp space ("\\s");
    QRegExp listeningPortRegExp ("^listening_port");
    QRegExp quitTokenRegExp ("^quit_token");
    if (!mongooseSettingsFile.open(QIODevice::ReadOnly | QIODevice::Text))
        return;
    QTextStream mongooseSettings (&mongooseSettingsFile);
    while (!mongooseSettings.atEnd()) {
        QString line = mongooseSettings.readLine();
        if (line.contains (listeningPortRegExp)) {
            listeningPort = line.section (space, 1, 1);
            listeningPort.replace (QString ("\n"), "");
        }
        if (line.contains (quitTokenRegExp)) {
            quitToken = line.section (space, 1, 1);
            quitToken.replace (QString ("\n"), "");
        }
    }

    // Ping settings:
    pingLocalWebserver = settings.value ("ping/ping_local_webserver").toString();
    pingRemoteWebserver = settings.value ("ping/ping_remote_webserver").toString();

    // GUI settings:
    startPage = settings.value ("gui/start_page").toString();
    windowSize = settings.value ("gui/window_size").toString();
    framelessWindow = settings.value ("gui/frameless_window").toString();
    stayOnTop = settings.value ("gui/stay_on_top") .toString();
    browserTitle = settings.value ("gui/browser_title").toString();
    contextMenu = settings.value ("gui/context_menu").toString();

    // Icon:
    QString iconRelativePathName = settings.value ("gui/icon").toString();
    iconPathName = QDir::toNativeSeparators (
                rootDirName+QDir::separator()+iconRelativePathName);
    icon.load (iconPathName);

    // Logging:
    logging = settings.value ("logging/enable").toString();
    logFile = settings.value ("logging/file").toString();

    // Command line options
    QStringList arguments = QCoreApplication::arguments();
    foreach (QString argument, arguments){
        if (argument.contains ("--root") or argument.contains ("-r")) {
            rootDirName = argument.section ("=", 1, 1);
        }
        if (argument.contains ("--webserver") or argument.contains ("-w")) {
            autostartLocalWebserver = argument.section ("=", 1, 1);
        }
    }

}

Watchdog::Watchdog()
    : QObject (0)
{

    if (settings.autostartLocalWebserver == "yes") {
        qDebug() << "Mongoose quit token:" << settings.quitToken;
        qDebug() << "===============";

        QProcess server;
        server.startDetached (QString (
                                  settings.rootDirName+QDir::separator()+"mongoose"));
    }

    QTimer *timer = new QTimer (this);
    connect (timer, SIGNAL (timeout()), this, SLOT (pingSlot()));
    timer->start (5000);

    trayIcon = new QSystemTrayIcon();
    trayIcon->setIcon (settings.icon);
    trayIcon->setToolTip ("Camel Calf");

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

Page::Page()
    : QWebPage (0)
{

    QWebSettings::globalSettings()->
            setDefaultTextEncoding (QString ("utf-8"));
    QWebSettings::globalSettings()->
            setAttribute (QWebSettings::PluginsEnabled, true);
    QWebSettings::globalSettings()->
            setAttribute (QWebSettings::JavascriptEnabled, true);
    QWebSettings::globalSettings()->
            setAttribute (QWebSettings::SpatialNavigationEnabled, true);
    QWebSettings::globalSettings()->
            setAttribute (QWebSettings::LinksIncludedInFocusChain, true);
    QWebSettings::globalSettings()->
            setAttribute (QWebSettings::AutoLoadImages, true);
    QWebSettings::globalSettings()->
            setAttribute (QWebSettings::DeveloperExtrasEnabled, true);
//    QWebSettings::globalSettings()->
//            setAttribute (QWebSettings::LocalStorageEnabled, true);

    QWebSettings::globalSettings()->
            setAttribute (QWebSettings::PrivateBrowsingEnabled, true);
    QWebSettings::globalSettings()->
            setAttribute (QWebSettings::LocalContentCanAccessFileUrls, true);
    QWebSettings::globalSettings()->
            setAttribute (QWebSettings::LocalContentCanAccessRemoteUrls, true);
    QWebSettings::setMaximumPagesInCache (0);
    QWebSettings::setObjectCacheCapacities (0, 0, 0);
    QWebSettings::clearMemoryCaches();

    QObject::connect (&longRunningScriptHandler, SIGNAL (readyReadStandardOutput()),
                       this, SLOT (displayLongRunningScriptOutputSlot()));
    QObject::connect (&longRunningScriptHandler, SIGNAL (readyReadStandardError()),
                       this, SLOT (displayLongRunningScriptErrorSlot()));
    QObject::connect (&longRunningScriptHandler, SIGNAL (finished (int, QProcess::ExitStatus)),
                       this, SLOT (longRunningScriptFinishedSlot()));

    QObject::connect (&debuggerHandler, SIGNAL (readyReadStandardOutput()),
                       this, SLOT (displayDebuggerOutputSlot()));

}

TopLevel::TopLevel()
    : QWebView (0)
{

    // Configure keyboard shortcuts:
    QShortcut *maximizeShortcut = new QShortcut (QKeySequence ("Ctrl+M"), this);
    QObject::connect (maximizeShortcut, SIGNAL (activated()),
                       this, SLOT (maximizeSlot()));
    QShortcut *minimizeShortcut = new QShortcut (Qt::Key_Escape, this);
    QObject::connect (minimizeShortcut, SIGNAL (activated()),
                       this, SLOT (minimizeSlot()));
    QShortcut *toggleFullScreenShortcut = new QShortcut (Qt::Key_F11, this);
    QObject::connect (toggleFullScreenShortcut, SIGNAL (activated()),
                       this, SLOT (toggleFullScreenSlot()));
    QShortcut *homeShortcut = new QShortcut (Qt::Key_F12, this);
    QObject::connect (homeShortcut, SIGNAL (activated()),
                       this, SLOT (loadStartPageSlot()));
    QShortcut *printShortcut = new QShortcut (QKeySequence ("Ctrl+P"), this);
    QObject::connect (printShortcut, SIGNAL (activated()),
                       this, SLOT (printPageSlot()));
    QShortcut *closeAppShortcut = new QShortcut (QKeySequence ("Ctrl+X"), this);
    QObject::connect (closeAppShortcut, SIGNAL (activated()),
                       this, SLOT (quitApplicationSlot()));

    // Configure screen appearance:
    if (settings.windowSize != "maximized" or settings.windowSize != "fullscreen") {
        int fixedWidth = settings.windowSize.section ("x", 0, 0) .toInt();
        int fixedHeight = settings.windowSize.section ("x", 1, 1) .toInt();
        if (fixedWidth > 100 and fixedHeight > 100) {
            setFixedSize (fixedWidth, fixedHeight);
            QRect screenRect = QDesktopWidget().screen()->rect();
            move (QPoint (screenRect.width() / 2 - width() / 2,
                            screenRect.height() / 2 - height() / 2));
        }
    }
    if (settings.windowSize == "maximized") {
        showMaximized();
    }
    if (settings.windowSize == "fullscreen") {
        showFullScreen();
    }
    if (settings.stayOnTop == "yes") {
        setWindowFlags (Qt::WindowStaysOnTopHint);
    }
    if (settings.stayOnTop == "yes" and settings.framelessWindow == "yes") {
        setWindowFlags (Qt::WindowStaysOnTopHint | Qt::FramelessWindowHint);
    }
    if (settings.stayOnTop == "no" and settings.framelessWindow == "yes") {
        setWindowFlags (Qt::FramelessWindowHint);
    }
    if (settings.browserTitle != "dynamic") {
        setWindowTitle (settings.browserTitle);
    }
    if (settings.contextMenu == "no") {
        setContextMenuPolicy (Qt::NoContextMenu);
    }

    mainPage = new Page();

    QObject::connect (mainPage, SIGNAL (closeWindowSignal()),
                       this, SLOT (close()));
    QObject::connect (mainPage, SIGNAL (quitFromURLSignal()),
                       this, SLOT (quitApplicationSlot()));
    if (settings.browserTitle == "dynamic") {
        QObject::connect (mainPage, SIGNAL (loadFinished (bool)),
                           this, SLOT (pageLoadedDynamicTitleSlot (bool)));
    } else {
        QObject::connect (mainPage, SIGNAL (loadFinished (bool)),
                           this, SLOT (pageLoadedStaticTitleSlot (bool)));
    }

    setPage (mainPage);

    // Use modified Network Access Manager with every window of the program:
    ModifiedNetworkAccessManager *nam = new ModifiedNetworkAccessManager();
    mainPage->setNetworkAccessManager (nam);

    // HTTPS support:
    QNetworkCookieJar *jar = new QNetworkCookieJar;
    nam->setCookieJar (jar);
    QObject::connect (nam, SIGNAL (sslErrors (QNetworkReply*, QList<QSslError>)),
                 this, SLOT (sslErrors (QNetworkReply*, QList<QSslError>)));

    //main_page->setLinkDelegationPolicy (QWebPage::DelegateAllLinks);

    // Configure scroll bars:
    mainPage->mainFrame()->setScrollBarPolicy (Qt::Horizontal, Qt::ScrollBarAsNeeded);
    mainPage->mainFrame()->setScrollBarPolicy (Qt::Vertical, Qt::ScrollBarAsNeeded);

    // Disable history:
    QWebHistory *history = mainPage->history();
    history->setMaximumItemCount (0);

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

// Manage clicking of links:
bool Page::acceptNavigationRequest (QWebFrame *frame,
                                     const QNetworkRequest &request,
                                     QWebPage::NavigationType navigationType)
{

    // Open local file using default application:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
         request.url().scheme().contains ("file")) {
        QString filepath = request.url().toString (QUrl::RemoveScheme);
        QFile file (QDir::toNativeSeparators (filepath));
        if (file.exists()) {
            QString defaultApplicationFile = request.url().toString();
            qDebug() << "Opening file with default application:" << defaultApplicationFile;
            qDebug() << "===============";
            QDesktopServices::openUrl (request.url());
            return false;
        }
    }

    // Execute external application:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
         request.url().toString().contains ("external:")) {
        QString externalApplication = request.url()
                .toString (QUrl::RemoveScheme)
                .replace ("/", "");
        qDebug() << "External application: " << externalApplication;
        qDebug() << "===============";
        QProcess externalProcess;
        externalProcess.startDetached (externalApplication);
        return false;
    }

    // Select Perl interpreter:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
         request.url().toString().contains ("selectperl:")) {
        QFileDialog dialog;
        dialog.setFileMode (QFileDialog::AnyFile);
        dialog.setViewMode (QFileDialog::Detail);
        dialog.setOption (QFileDialog::DontUseNativeDialog);
        dialog.setWindowFlags (Qt::WindowStaysOnTopHint);
        dialog.setWindowIcon (settings.icon);
        QString perlInterpreter = dialog.getOpenFileName
                (0, "Select Perl Interpreter", QDir::currentPath(), "All files (*)");
        dialog.close();
        dialog.deleteLater();
        QByteArray perlInterpreterByteArray;
        perlInterpreterByteArray.append (perlInterpreter);
        qputenv ("PERL_INTERPRETER", perlInterpreterByteArray);
        qDebug() << "Selected Perl interpreter:" << perlInterpreter;

        QFileDialog selectPerlLibDialog;
        selectPerlLibDialog.setFileMode (QFileDialog::AnyFile);
        selectPerlLibDialog.setViewMode (QFileDialog::Detail);
        selectPerlLibDialog.setOption (QFileDialog::DontUseNativeDialog);
        selectPerlLibDialog.setWindowFlags (Qt::WindowStaysOnTopHint);
        selectPerlLibDialog.setWindowIcon (settings.icon);
        QString perlLibFolderNameString = selectPerlLibDialog.getExistingDirectory
                (0, "Select PERLLIB", QDir::currentPath());
        selectPerlLibDialog.close();
        selectPerlLibDialog.deleteLater();
        QByteArray perlLibFolderName;
        perlLibFolderName.append (perlLibFolderNameString);
        qputenv ("PERLLIB", perlLibFolderName);
        qDebug() << "Selected PERLLIB:" << perlLibFolderName;
        qDebug() << "===============";

        return true;
    }

    // Select Python interpreter:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
         request.url().toString().contains ("selectpython:")) {
        QFileDialog dialog;
        dialog.setFileMode (QFileDialog::AnyFile);
        dialog.setViewMode (QFileDialog::Detail);
        dialog.setOption (QFileDialog::DontUseNativeDialog);
        dialog.setWindowFlags (Qt::WindowStaysOnTopHint);
        dialog.setWindowIcon (settings.icon);
        QString pythonInterpreter = dialog.getOpenFileName
                (0, "Select Python Interpreter", QDir::currentPath(), "All files (*)");
        dialog.close();
        dialog.deleteLater();
        QByteArray pythonInterpreterByteArray;
        pythonInterpreterByteArray.append (pythonInterpreter);
        qputenv ("PYTHON_INTERPRETER", pythonInterpreterByteArray);
        qDebug() << "Selected Python interpreter:" << pythonInterpreter;
        qDebug() << "===============";
        return true;
    }

    // Select PHP interpreter:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
         request.url().toString().contains ("selectphp:")) {
        QFileDialog dialog;
        dialog.setFileMode (QFileDialog::AnyFile);
        dialog.setViewMode (QFileDialog::Detail);
        dialog.setOption (QFileDialog::DontUseNativeDialog);
        dialog.setWindowFlags (Qt::WindowStaysOnTopHint);
        dialog.setWindowIcon (settings.icon);
        QString phpInterpreter = dialog.getOpenFileName
                (0, "Select PHP Interpreter", QDir::currentPath(), "All files (*)");
        dialog.close();
        dialog.deleteLater();
        QByteArray phpInterpreterByteArray;
        phpInterpreterByteArray.append (phpInterpreter);
        qputenv ("PHP_INTERPRETER", phpInterpreterByteArray);
        qDebug() << "Selected PHP interpreter:" << phpInterpreter;
        qDebug() << "===============";
        return true;
    }

    // Invoke 'Open file' dialog from URL:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
         request.url().toString().contains ("openfile:")) {
        QFileDialog dialog;
        dialog.setFileMode (QFileDialog::AnyFile);
        dialog.setViewMode (QFileDialog::Detail);
        dialog.setOption (QFileDialog::DontUseNativeDialog);
        dialog.setWindowFlags (Qt::WindowStaysOnTopHint);
        dialog.setWindowIcon (settings.icon);
        QString fileNameToOpenString = dialog.getOpenFileName
                (0, "Select File", QDir::currentPath(), "All files (*)");
        dialog.close();
        dialog.deleteLater();
        QByteArray fileName;
        fileName.append (fileNameToOpenString);
        qputenv ("FILE_TO_OPEN", fileName);
        qDebug() << "File to open:" << fileName;
        qDebug() << "===============";
        return true;
    }

    // Invoke 'New file' dialog from URL:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
         request.url().toString().contains ("newfile:")) {
        QFileDialog dialog;
        dialog.setFileMode (QFileDialog::AnyFile);
        dialog.setViewMode (QFileDialog::Detail);
        dialog.setOption (QFileDialog::DontUseNativeDialog);
        dialog.setWindowFlags (Qt::WindowStaysOnTopHint);
        dialog.setWindowIcon (settings.icon);
        QString fileNameToOpenString = dialog.getSaveFileName
                (0, "Create New File", QDir::currentPath(), "All files (*)");
        if (fileNameToOpenString.isEmpty())
            return false;
        dialog.close();
        dialog.deleteLater();
        QByteArray fileName;
        fileName.append (fileNameToOpenString);
        qputenv ("NEW_FILE", fileName);
        qDebug() << "New file:" << fileName;
        qDebug() << "===============";
        return true;
    }

    // Invoke 'Open folder' dialog from URL:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
         request.url().toString().contains ("openfolder:")) {
        QFileDialog dialog;
        dialog.setFileMode (QFileDialog::AnyFile);
        dialog.setViewMode (QFileDialog::Detail);
        dialog.setOption (QFileDialog::DontUseNativeDialog);
        dialog.setWindowFlags (Qt::WindowStaysOnTopHint);
        dialog.setWindowIcon (settings.icon);
        QString folderNameToOpenString = dialog.getExistingDirectory
                (0, "Select Folder", QDir::currentPath());
        dialog.close();
        dialog.deleteLater();
        QByteArray folderName;
        folderName.append (folderNameToOpenString);
        qputenv ("FOLDER_TO_OPEN", folderName);
        qDebug() << "Folder to open:" << QDir::toNativeSeparators (folderName);
        qDebug() << "===============";
        return true;
    }

    // Display information about user-selected Perl scripts using the built-in Perl debugger.
    // Partial implementation of an idea proposed by Valcho Nedelchev.
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            request.url().toString().contains ("perl_debugger")) {
        QFileDialog dialog;
        dialog.setFileMode (QFileDialog::ExistingFile);
        dialog.setViewMode (QFileDialog::Detail);
        dialog.setOption (QFileDialog::DontUseNativeDialog);
        dialog.setWindowFlags (Qt::WindowStaysOnTopHint);
        dialog.setWindowIcon (settings.icon);
        filepath = "";
        filepath = dialog.getOpenFileName
                (0, "Select Perl File", QDir::currentPath(),
                 "Perl scripts (*.pl);;Perl modules (*.pm);;CGI scripts (*.cgi);;All files (*)");
        dialog.close();
        dialog.deleteLater();
        if (filepath.length() > 1) {
            qDebug() << "File passed to Perl debugger:" << QDir::toNativeSeparators (filepath);
            extension = filepath.section (".", 1, 1);
            if (extension.length() == 0)
                extension = "pl";
            qDebug() << "Extension:" << extension;

            if (settings.debuggerInterpreter == "current") {
                defineInterpreter();
            }

            if (settings.debuggerInterpreter == "select") {
                selectInterpreterSlot();
            }

            qDebug() << "Interpreter:" << interpreter;

            debuggerHandler.close();
            accumulatedOutput = "";
            accumulatedOutput.append ("\nScript: "+filepath+"\n");
            QFile debuggerOutputFile (debuggerOutputFilePath);
            if (debuggerOutputFile.exists())
                debuggerOutputFile.remove();

            accumulatedOutput.append ("Interpreter: "+interpreter+"\n");

            QProcessEnvironment env = QProcessEnvironment::systemEnvironment();
            env.insert ("COLUMNS", "80");
            env.insert ("LINES", "24");
            //env.insert ("PERLDB_OPTS", "LineInfo=/home/knoppix/github/peb/lineinfo.txt");
            debuggerHandler.setProcessEnvironment (env);
            //qDebug() << "Process environment:" << debuggerHandler.processEnvironment().toStringList();

            QFileInfo scriptAbsoluteFilePath (filepath);
            QString scriptDirectory = scriptAbsoluteFilePath.absolutePath();
            debuggerHandler.setWorkingDirectory (scriptDirectory);
            qDebug() << "Working directory:" << QDir::toNativeSeparators (scriptDirectory);

            qDebug() << "TEMP folder:" << QDir::toNativeSeparators (QDir::tempPath());
            qDebug() << "===============";

            debuggerHandler.setProcessChannelMode (QProcess::MergedChannels);
            debuggerHandler.start (interpreter, QStringList() << "-d" <<
                                   QDir::toNativeSeparators (filepath),
                                   QProcess::Unbuffered | QProcess::ReadWrite);
            if (!debuggerHandler.waitForStarted (-1))
                return false;

            QByteArray debuggerCommand;
            if (request.url().toString().contains ("perl_debugger_list_modules:")) {
                debuggerCommand.append (QString ("M\n").toLatin1());
                debuggerCommandHumanReadable = "Show module versions (M)";
            }
            if (request.url().toString().contains ("perl_debugger_list_subroutine_names:")) {
                debuggerCommand.append (QString ("S\n").toLatin1());
                debuggerCommandHumanReadable = "List subroutine names (S)";
            }
            if (request.url().toString().contains ("perl_debugger_list_variables_in_package:")) {
                debuggerCommand.append (QString ("V\n").toLatin1());
                debuggerCommandHumanReadable = "List Variables in Package (V)";
            }
            accumulatedOutput.append ("Debugger Command: "+debuggerCommandHumanReadable+"\n");

            debuggerHandler.write (debuggerCommand);

            newDebuggerWindow = new TopLevel;
            newDebuggerWindow->setWindowIcon (settings.icon);
        }

        QWebSettings::clearMemoryCaches();
        return true;
    }

    // Print page from URL:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
         request.url().toString().contains ("print:")) {
        qDebug() << "Printing requested.";
        qDebug() << "===============";
        QPrinter printer;
        printer.setOrientation (QPrinter::Portrait);
        printer.setPageSize (QPrinter::A4);
        printer.setPageMargins (10, 10, 10, 10, QPrinter::Millimeter);
        printer.setResolution (QPrinter::HighResolution);
        printer.setColorMode (QPrinter::Color);
        printer.setPrintRange (QPrinter::AllPages);
        printer.setNumCopies (1);
        //            printer.setOutputFormat (QPrinter::PdfFormat);
        //            printer.setOutputFileName ("output.pdf");
        QPrintDialog *dialog = new QPrintDialog (&printer);
        dialog->setWindowFlags (Qt::WindowStaysOnTopHint);
        if (dialog->exec() == QDialog::Accepted) {
            frame->print (&printer);
        }
        dialog->close();
        dialog->deleteLater();
        return true;
    }

    // Close window from URL:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
         request.url().toString().contains ("closewindow:")) {
        qDebug() << "Close window requested from URL.";
        qDebug() << "===============";
        emit closeWindowSignal();
    }

    // Quit application from URL:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
         request.url().toString().contains ("quit:")) {
        qDebug() << "Application termination requested from URL.";
        emit quitFromURLSignal();
    }

    // Open not allowed web site using default browser:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            request.url().scheme().contains ("http") and
            (! (QUrl (PEB_DOMAIN))
             .isParentOf (request.url())) and
            (! request.url().authority().contains ("localhost")) and
            (! request.url().authority().contains ("www.google.com"))) {
        QString externalWebLink = request.url().toString();
        qDebug() << "Default browser called for:" << externalWebLink;
        qDebug() << "===============";
        QDesktopServices::openUrl (request.url());
        return false;
    }

    // Open allowed web site in the same or in a new window:
    if (frame == Page::currentFrame() and
            request.url().authority().contains ("www.google.com")) {
        QString allowedWebLink = request.url().toString();
        qDebug() << "Allowed web link:" << allowedWebLink;
        qDebug() << "===============";
        return QWebPage::acceptNavigationRequest (frame, request, navigationType);

    }
    if (frame != Page::currentFrame() and
            request.url().authority().contains ("www.google.com")) {
        qDebug() << "Allowed web link in a new window:" << request.url();
        qDebug() << "===============";
        if (! Page::mainFrame()->childFrames().contains (frame))
        {
            newWindow = new TopLevel;
            newWindow->setWindowIcon (settings.icon);
            newWindow->setUrl (request.url());
            newWindow->show();
        }
    }

    // Open localhost:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
         request.url().scheme().contains ("http") and
         request.url().authority().contains ("localhost")) {
        qDebug() << "Local webserver link:" << request.url().toString();
        qDebug() << "===============";
        return QWebPage::acceptNavigationRequest (frame, request, navigationType);
    }

    // Open local content in a new window
    // (with the exception of result from long-running script):
    if (frame != Page::currentFrame() and
            (QUrl (PEB_DOMAIN))
            .isParentOf (request.url())) {
        if (! Page::mainFrame()->childFrames().contains (frame)) {
            if (! request.url().path().contains ("longrun")) {
                filepath = request.url()
                        .toString (QUrl::RemoveScheme
                                   | QUrl::RemoveAuthority
                                   | QUrl::RemoveQuery
                                   | QUrl::RemoveFragment);
                QFile file (QDir::toNativeSeparators
                            (settings.rootDirName+filepath));
                if (!file.exists()) {
                    missingFileMessageSlot();
                    return true;
                } else {
                    newWindow = new TopLevel;
                    newWindow->setWindowIcon (settings.icon);
                    if (request.url().path().contains (".htm")) {
                        newWindow->setUrl (QUrl::fromLocalFile
                                             (QDir::toNativeSeparators
                                              (settings.rootDirName+
                                               QDir::separator()+request.url().path())));
                    } else {
                        newWindow->setUrl (request.url());
                    }
                }
                newWindow->show();
                return true;
            }
        }
    }

    // Load local HTML page invoked from hyperlink:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
         (QUrl (PEB_DOMAIN))
         .isParentOf (request.url()) and
         (request.url().path().contains (".htm"))) {
        filepath = request.url()
                .toString (QUrl::RemoveScheme
                           | QUrl::RemoveAuthority
                           | QUrl::RemoveQuery
                           | QUrl::RemoveFragment);
        qDebug() << "HTML file path:" << QDir::toNativeSeparators
                    (settings.rootDirName+filepath);
        checkFileExistenceSlot();
        frame->load (QUrl::fromLocalFile
                       (QDir::toNativeSeparators
                        (settings.rootDirName+
                                QDir::separator()+filepath)));
        qDebug() << "===============";
        QWebSettings::clearMemoryCaches();
        return true;
    }

    // Execute local long-running script invoked from hyperlink:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
         (QUrl (PEB_DOMAIN))
         .isParentOf (request.url()) and
         (request.url().path().contains ("longrun"))){
        qDebug() << "Long-running script:" << request.url().toString();
        filepath = request.url()
                .toString (QUrl::RemoveScheme
                           | QUrl::RemoveAuthority
                           | QUrl::RemoveQuery);
        qDebug() << "File path:" << QDir::toNativeSeparators
                    (settings.rootDirName+filepath);
        checkFileExistenceSlot();
        extension = filepath.section (".", 1, 1);
        qDebug() << "Extension:" << extension;
        defineInterpreter();
        qDebug() << "Interpreter:" << interpreter;

        QProcessEnvironment env = QProcessEnvironment::systemEnvironment();
        env.insert ("REQUEST_METHOD", "GET");
        QString query = request.url()
                .toString (QUrl::RemoveScheme
                           | QUrl::RemoveAuthority
                           | QUrl::RemovePath)
                .replace ("?", "");
        env.insert ("QUERY_STRING", query);
        longRunningScriptHandler.setProcessEnvironment (env);
        //qDebug() << "Process environment:" << longRunningScriptHandler.processEnvironment().toStringList();

        QFileInfo scriptAbsoluteFilePath (QDir::toNativeSeparators
                                          (settings.rootDirName+
                                           QDir::separator()+filepath));
        QString scriptDirectory = scriptAbsoluteFilePath.absolutePath();
        longRunningScriptHandler.setWorkingDirectory (scriptDirectory);
        qDebug() << "Working directory:" << QDir::toNativeSeparators (scriptDirectory);

        qDebug() << "TEMP folder:" << QDir::toNativeSeparators (QDir::tempPath());
        qDebug() << "===============";

        longRunningScriptHandler.start (interpreter, QStringList() <<
                                        QDir::toNativeSeparators
                                        (settings.rootDirName+
                                         QDir::separator()+filepath));

            if (frame == Page::currentFrame()) {
                longRunningScriptOutputInNewWindow = false;
            }
            if (frame != Page::currentFrame()) {
                longRunningScriptOutputInNewWindow = true;
                lastRequest = request;
                newLongRunWindow = new TopLevel;
                newLongRunWindow->setWindowIcon (settings.icon);
            }

            QWebSettings::clearMemoryCaches();
            return true;
    }

    return QWebPage::acceptNavigationRequest (frame, request, navigationType);
}
