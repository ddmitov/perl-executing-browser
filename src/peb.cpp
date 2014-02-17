
// Perl Executing Browser, v. 0.1

// This program is free software;
// you can redistribute it and/or modify it under the terms of the
// GNU General Public License, as published by the Free Software Foundation;
// either version 3 of the License, or (at your option) any later version.
// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
// without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
// Dimitar D. Mitov, 2013 - 2014, ddmitov (at) yahoo (dot) com

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

int main (int argc, char **argv)
{

    QApplication application (argc, argv);

    application.setApplicationName ("Perl Executing Browser");
    // Get current date and time:
    QDateTime dateTime = QDateTime::currentDateTime();
    QString dateTimeString = dateTime.toString();
    qDebug() << "Perl Executing Browser v.0.1 started on:" << dateTimeString;
    qDebug() << "Application file path:" << QApplication::applicationFilePath();
    qDebug() << "Qt WebKit version:" << QTWEBKIT_VERSION_STR;
    qDebug() << "Qt version:" << QT_VERSION_STR;
    qDebug() << "===============";

#if QT_VERSION >= 0x050000
    QTextCodec::setCodecForLocale (QTextCodec::codecForName ("UTF8"));
#else
    QTextCodec::setCodecForCStrings (QTextCodec::codecForName ("UTF8"));
#endif

    QPixmap emptyTransparentIcon (16, 16);
    emptyTransparentIcon.fill (Qt::transparent);
    QApplication::setWindowIcon (QIcon (emptyTransparentIcon));

    Settings settings;

    QFile settingsFile (settings.settingsFileName);
    if (!settingsFile.exists()) {
        qDebug() << "'peb.ini' is missing. Please restore the missing file.";
        qDebug() << "Exiting.";
        QMessageBox msgBox;
        msgBox.setIcon (QMessageBox::Critical);
        msgBox.setWindowTitle ("Critical file missing");
        msgBox.setText ("'peb.ini' is missing.<br>Please restore the missing file.");
        msgBox.setDefaultButton (QMessageBox::Ok);
        msgBox.exec();
        return 1;
        QApplication::exit();
    }

    QFile startPageFile (QDir::toNativeSeparators
                         (QApplication::applicationDirPath()+
                          QDir::separator()+settings.startPage));
    if (!startPageFile.exists()) {
        qDebug() << QDir::toNativeSeparators
                    (QApplication::applicationDirPath()+
                     QDir::separator()+settings.startPage) <<
                    "is missing.";
        qDebug() << "Please restore the missing start page.";
        qDebug() << "Exiting.";
        QMessageBox msgBox;
        msgBox.setIcon (QMessageBox::Critical);
        msgBox.setWindowTitle ("Missing start page");
        msgBox.setText (QDir::toNativeSeparators
                        (QApplication::applicationDirPath()+
                         QDir::separator()+settings.startPage)+
                        " is missing.<br>Please restore the missing start page.");
        msgBox.setDefaultButton (QMessageBox::Ok);
        msgBox.exec();
        return 1;
        QApplication::exit();
    }

    QApplication::setWindowIcon (QIcon (settings.iconPathName));
    qDebug() << "Application icon:" << settings.iconPathName;
    qDebug() << "===============";

    // Environment variables:
    QByteArray path;
#ifdef Q_OS_LINUX
    QByteArray oldPath = qgetenv ("PATH"); //linux
#endif
#ifdef Q_OS_WIN
    QByteArray oldPath = qgetenv ("Path"); //win32
#endif
    path.append (oldPath);
#ifdef Q_OS_LINUX
    path.append (":"); //linux
#endif
#ifdef Q_OS_WIN
    path.append (";"); //win32
#endif
    path.append (QApplication::applicationDirPath());
    path.append (QDir::separator());
    path.append ("perl");
#ifdef Q_OS_LINUX
    qputenv ("PATH", path); //linux
#endif
#ifdef Q_OS_WIN
    qputenv ("Path", path); //win32
#endif
    QByteArray documentRoot;
    documentRoot.append (QApplication::applicationDirPath());
    qputenv ("DOCUMENT_ROOT", documentRoot);
    QByteArray perlLib;
    perlLib.append (QApplication::applicationDirPath());
    perlLib.append (QDir::separator());
    perlLib.append ("perl");
    perlLib.append (QDir::separator());
    perlLib.append ("lib");
    qputenv ("PERLLIB", perlLib);
    qputenv ("FILE_TO_OPEN", "");
    qputenv ("FOLDER_TO_OPEN", "");

    TopLevel toplevel;
    QObject::connect (qApp, SIGNAL (lastWindowClosed()),
                       &toplevel, SLOT (quitApplicationSlot()));
    QObject::connect (qApp, SIGNAL (aboutToQuit()),
                       &toplevel, SLOT (quitApplicationSlot()));
    toplevel.setWindowIcon (QIcon (settings.iconPathName));
    toplevel.loadStartPageSlot();
    toplevel.show();

    Watchdog watchdog;
    QObject::connect (watchdog.aboutAction, SIGNAL (triggered()),
                       &toplevel, SLOT (aboutSlot()));
    QObject::connect (watchdog.quitAction, SIGNAL (triggered()),
                       &toplevel, SLOT (quitApplicationSlot()));

    return application.exec();

}

Settings::Settings()
    : QSettings (0)
{

    settingsFileName = QDir::toNativeSeparators
            (QApplication::applicationDirPath()+QDir::separator()+"peb.ini");
    QSettings settings (settingsFileName, QSettings::IniFormat);
    startPage = settings.value ("gui/start_page"). toString();
    icon = settings.value ("gui/icon") .toString();
    windowSize = settings.value ("gui/window_size") .toString();
    framelessWindow = settings.value ("gui/frameless_window") .toString();
    stayOnTop = settings.value ("gui/stay_on_top") .toString();
    browserTitle = settings.value ("gui/browser_title") .toString();
    contextMenu = settings.value ("gui/context_menu") .toString();
    iconPathName = QDir::toNativeSeparators (QApplication::applicationDirPath() +
                                              QDir::separator()+icon);

    mongooseSettingsFileName = QDir::toNativeSeparators
            (QApplication::applicationDirPath()+QDir::separator()+"mongoose.conf");
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

}

Watchdog::Watchdog()
    : QObject (0)
{

    qDebug() << "Mongoose quit token:" << settings.quitToken;

    QProcess server;
    server.startDetached (QString (QApplication::applicationDirPath()+
                                     QDir::separator()+"mongoose"));

    QTimer *timer = new QTimer (this);
    connect (timer, SIGNAL (timeout()), this, SLOT (pingSlot()));
    timer->start (5000);

    trayIcon = new QSystemTrayIcon();
    trayIcon->setIcon (QIcon (settings.iconPathName));
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
    QObject::connect (&longRunningScriptHandler, SIGNAL (finished (int, QProcess::ExitStatus)),
                       this, SLOT (longRunningScriptFinishedSlot()));
    QObject::connect (&longRunningScriptHandler, SIGNAL (readyReadStandardError()),
                       this, SLOT (displayLongRunningScriptErrorSlot()));

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


    // Invoke 'Open file' dialog from URL:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
         request.url().toString().contains ("openfile:")) {
        QFileDialog dialog;
        dialog.setFileMode (QFileDialog::AnyFile);
        dialog.setViewMode (QFileDialog::Detail);
        dialog.setOption (QFileDialog::DontUseNativeDialog);
        dialog.setWindowFlags (Qt::WindowStaysOnTopHint);
        dialog.setWindowIcon (QIcon (settings.iconPathName));
        QString fileNameToOpenString = dialog.getOpenFileName
                (0, "Select File", QDir::currentPath(), "All files (*)");
        QByteArray fileName;
        fileName.append (fileNameToOpenString);
        qputenv ("FILE_TO_OPEN", fileName);
        qDebug() << "File to open:" << fileName;
        qDebug() << "===============";
        dialog.close();
        dialog.deleteLater();
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
        dialog.setWindowIcon (QIcon (settings.iconPathName));
        QString folderNameToOpenString = dialog.getExistingDirectory
                (0, "Select Folder", QDir::currentPath());
        QByteArray folderName;
        folderName.append (folderNameToOpenString);
        qputenv ("FOLDER_TO_OPEN", folderName);
        qDebug() << "Folder to open:" << folderName;
        qDebug() << "===============";
        dialog.close();
        dialog.deleteLater();
        return true;
    }

    // List all modules of a Perl script using the built-in Perl debugger.
    // Early experiments for implementing an idea proposed by Valcho Nedelchev.
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
            request.url().toString().contains ("perl_debugger")) {
        QFileDialog dialog;
        dialog.setFileMode (QFileDialog::ExistingFile);
        dialog.setViewMode (QFileDialog::Detail);
        dialog.setOption (QFileDialog::DontUseNativeDialog);
        dialog.setWindowFlags (Qt::WindowStaysOnTopHint);
        dialog.setWindowIcon (QIcon (settings.iconPathName));
        filepath = "";
        filepath = dialog.getOpenFileName
                (0, "Select Perl File", QDir::currentPath(),
                 "Perl scripts (*.pl);;Perl modules (*.pm);;CGI scripts (*.cgi);;All files (*)");
        if (filepath.length() > 1) {
            qDebug() << "File path:" << filepath;
            extension = filepath.section (".", 1, 1);
            if (extension.length() == 0)
                extension = "pl";
            qDebug() << "Extension:" << extension;
            defineInterpreterSlot();
            qDebug() << "Interpreter:" << interpreter;

            debuggerHandler.close();
            accumulatedOutput = "";
            accumulatedOutput.append ("\nScript: "+filepath+"\n");
            QFile debuggerOutputFile (debuggerOutputFilePath);
            if (debuggerOutputFile.exists())
                debuggerOutputFile.remove();

            QProcessEnvironment env = QProcessEnvironment::systemEnvironment();
            // http://stackoverflow.com/questions/1725097
            env.insert ("COLUMNS", "80");
            env.insert ("LINES", "24");
            debuggerHandler.setProcessEnvironment (env);

            QFileInfo file (filepath);
            QString fileDirectory = QDir::toNativeSeparators
                    (file.absoluteDir().absolutePath());
            qDebug() << "Working directory:" << fileDirectory;
            qDebug() << "TEMP folder:" << QDir::tempPath();
            qDebug() << "===============";
            debuggerHandler.setWorkingDirectory (fileDirectory);

            // http://qt-project.org/forums/viewthread/1335
            // http://www.qtcentre.org/threads/31264
            // http://stackoverflow.com/questions/13856734/open-qfile-for-appending
            debuggerHandler.setProcessChannelMode (QProcess::MergedChannels);
            debuggerHandler.start (interpreter, QStringList() << "-d" <<
                                            QDir::toNativeSeparators (filepath),
                                            QProcess::Unbuffered | QProcess::ReadWrite);
            if (! debuggerHandler.waitForStarted (-1))
                return 1;
            QByteArray noTTY;
            noTTY.append (QString ("noTTY\n").toLatin1());
            debuggerHandler.write (noTTY);
            QByteArray showModuleVersions;
            showModuleVersions.append (QString ("M\n").toLatin1());
            debuggerHandler.write (showModuleVersions);

            newDebuggerWindow = new TopLevel;
            newDebuggerWindow->setWindowIcon (QIcon (settings.iconPathName));
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
        qDebug() << "Exiting.";
        emit quitFromURLSignal();
    }

    // Open not allowed web site using default browser:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
         request.url().scheme().contains ("http") and
         (! (QUrl ("http://perl-executing-browser-pseudodomain/"))
           .isParentOf (request.url())) and
         (! request.url().authority().contains ("localhost")) and
         (! request.url().authority().contains ("www.perl.org"))) {
        QString externalWebLink = request.url().toString();
        qDebug() << "Default browser called for:" << externalWebLink;
        qDebug() << "===============";
        QDesktopServices::openUrl (request.url());
        return false;
    }

    // Open allowed web site in the same or in a new window:
    if (frame == Page::currentFrame() and
         request.url().authority().contains ("www.perl.org")) {
        QString allowedWebLink = request.url().toString();
        qDebug() << "Allowed web link:" << allowedWebLink;
        qDebug() << "===============";
        return QWebPage::acceptNavigationRequest (frame, request, navigationType);

    }
    if (frame != Page::currentFrame() and
               request.url().authority().contains ("www.perl.org")) {
        qDebug() << "Allowed web link in a new window:" << request.url();
        qDebug() << "===============";
        if (! Page::mainFrame()->childFrames().contains (frame))
        {
            newWindow = new TopLevel;
            newWindow->setWindowIcon (QIcon (settings.iconPathName));
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
            (QUrl ("http://perl-executing-browser-pseudodomain/"))
            .isParentOf (request.url())) {
        if (! Page::mainFrame()->childFrames().contains (frame)) {
            if (! request.url().path().contains ("longrun")) {
                filepath = request.url()
                        .toString (QUrl::RemoveScheme
                                   | QUrl::RemoveAuthority
                                   | QUrl::RemoveQuery
                                   | QUrl::RemoveFragment);
                QFile file (QDir::toNativeSeparators
                            (QApplication::applicationDirPath()+filepath));
                if (!file.exists()) {
                    missingFileMessageSlot();
                    return true;
                } else {
                    newWindow = new TopLevel;
                    newWindow->setWindowIcon (QIcon (settings.iconPathName));
                    if (request.url().path().contains (".htm")) {
                        newWindow->setUrl (QUrl::fromLocalFile
                                             (QDir::toNativeSeparators
                                              (QApplication::applicationDirPath()+
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
         (QUrl ("http://perl-executing-browser-pseudodomain/"))
         .isParentOf (request.url()) and
         (request.url().path().contains (".htm"))) {
        filepath = request.url()
                .toString (QUrl::RemoveScheme
                           | QUrl::RemoveAuthority
                           | QUrl::RemoveQuery
                           | QUrl::RemoveFragment);
        qDebug() << "HTML file path:" << QDir::toNativeSeparators
                    (QApplication::applicationDirPath()+filepath);
        checkFileExistenceSlot();
        frame->load (QUrl::fromLocalFile
                       (QDir::toNativeSeparators
                        (QApplication::applicationDirPath()+
                                QDir::separator()+filepath)));
        qDebug() << "===============";
        QWebSettings::clearMemoryCaches();
        return true;
    }

    // Execute local long-running script invoked from hyperlink:
    if (navigationType == QWebPage::NavigationTypeLinkClicked and
         (QUrl ("http://perl-executing-browser-pseudodomain/"))
         .isParentOf (request.url()) and
         (request.url().path().contains ("longrun"))){
        qDebug() << "Long-running script:" << request.url().toString();
        filepath = request.url()
                .toString (QUrl::RemoveScheme
                           | QUrl::RemoveAuthority
                           | QUrl::RemoveQuery);
        qDebug() << "File path:" << QDir::toNativeSeparators
                    (QApplication::applicationDirPath()+filepath);
        checkFileExistenceSlot();
        extension = filepath.section (".", 1, 1);
        qDebug() << "Extension:" << extension;
        defineInterpreterSlot();
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

        QFileInfo file (filepath);
        QString fileDirectory = QDir::toNativeSeparators
                (QApplication::applicationDirPath()+
                    file.absoluteDir().absolutePath());
        qDebug() << "Working directory:" << fileDirectory;
        qDebug() << "TEMP folder:" << QDir::tempPath();
        qDebug() << "===============";
        longRunningScriptHandler.setWorkingDirectory (fileDirectory);

        longRunningScriptHandler.start (interpreter, QStringList() <<
                                         QDir::toNativeSeparators
                                        (QApplication::applicationDirPath()+
                                             QDir::separator()+filepath));

            if (frame == Page::currentFrame()) {
                longRunningScriptOutputInNewWindow = false;
            }
            if (frame != Page::currentFrame()) {
                longRunningScriptOutputInNewWindow = true;
                lastRequest = request;
                newLongRunWindow = new TopLevel;
                newLongRunWindow->setWindowIcon (QIcon (settings.iconPathName));
            }

            QWebSettings::clearMemoryCaches();
            return true;
    }

    return QWebPage::acceptNavigationRequest (frame, request, navigationType);
}
