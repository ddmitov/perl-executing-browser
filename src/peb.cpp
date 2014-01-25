
// Perl Executing Browser, v.0.1
// This software is licensed under the terms of GNU GPL v.3 and
// is provided without warranties of any kind!
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

int main ( int argc, char ** argv )
{

    QApplication app ( argc, argv );

    // Get current date and time:
    QDateTime dateTime = QDateTime::currentDateTime ();
    QString dateTimeString = dateTime.toString ();
    qDebug () << "Perl Executing Browser v.0.1 started on:" << dateTimeString;
    qDebug () << "Application file path:" << QApplication::applicationFilePath ();
    qDebug () << "Qt WebKit version:" << QTWEBKIT_VERSION_STR;
    qDebug () << "Qt version:" << QT_VERSION_STR;
    qDebug () << "===============";

#if QT_VERSION >= 0x050000
    QTextCodec::setCodecForLocale ( QTextCodec::codecForName ( "UTF8" ) );
#else
    QTextCodec::setCodecForCStrings ( QTextCodec::codecForName ( "UTF8" ) );
#endif

    Settings settings;

    QApplication::setWindowIcon ( QIcon ( settings.iconPathName ) );
    qDebug () << "Application icon:" << settings.iconPathName;
    qDebug () << "===============";

    QFile settingsFile ( settings.settingsFileName );
    if ( ! settingsFile.exists () )
    {
        qDebug () << "'peb.ini' is missing. Please restore the missing file.";
        qDebug () << "Exiting.";
        QMessageBox msgBox;
        msgBox.setIcon ( QMessageBox::Critical );
        msgBox.setWindowTitle ( "Critical file missing" );
        msgBox.setText ( "'peb.ini' is missing.<br>Please restore the missing file." );
        msgBox.setDefaultButton ( QMessageBox::Ok );
        msgBox.exec ();
        return 1;
        QApplication::exit ();
    }

    QFile file ( QDir::toNativeSeparators (
                     QApplication::applicationDirPath () +
                     QDir::separator () + settings.startPage ) );
    if ( ! file.exists () )
    {
        qDebug () << QDir::toNativeSeparators (
                         QApplication::applicationDirPath () +
                         QDir::separator () + settings.startPage ) <<
                     "is missing.";
        qDebug () << "Please restore the missing start page.";
        qDebug () << "Exiting.";
        QMessageBox msgBox;
        msgBox.setIcon ( QMessageBox::Critical );
        msgBox.setWindowTitle ( "Missing start page" );
        msgBox.setText ( QDir::toNativeSeparators (
                             QApplication::applicationDirPath () +
                             QDir::separator () + settings.startPage ) +
                         " is missing.<br>Please restore the missing start page." );
        msgBox.setDefaultButton( QMessageBox::Ok );
        msgBox.exec ();
        return 1;
        QApplication::exit ();
    }

    // Environment variables:
    QByteArray path;
#ifdef Q_OS_LINUX
    QByteArray oldPath = qgetenv ( "PATH" ); //linux
#endif
#ifdef Q_OS_WIN
    QByteArray oldPath = qgetenv ( "Path" ); //win32
#endif
    path.append ( oldPath );
#ifdef Q_OS_LINUX
    path.append ( ":" ); //linux
#endif
#ifdef Q_OS_WIN
    path.append ( ";" ); //win32
#endif
    path.append ( QApplication::applicationDirPath () );
    path.append ( QDir::separator () );
    path.append ( "perl" );
#ifdef Q_OS_LINUX
    qputenv ( "PATH", path ); //linux
#endif
#ifdef Q_OS_WIN
    qputenv ( "Path", path ); //win32
#endif
    QByteArray documentRoot;
    documentRoot.append ( QApplication::applicationDirPath () );
    qputenv ( "DOCUMENT_ROOT", documentRoot );
    QByteArray perl5Lib;
    perl5Lib.append ( QApplication::applicationDirPath () );
    perl5Lib.append ( QDir::separator () );
    perl5Lib.append ( "perl" );
    perl5Lib.append ( QDir::separator () );
    perl5Lib.append ( "lib" );
    qputenv ( "PERL5LIB", perl5Lib );
    qputenv ( "FILE_TO_OPEN", "" );
    qputenv ( "FOLDER_TO_OPEN", "" );

    TopLevel toplevel;
    QObject::connect ( qApp, SIGNAL ( lastWindowClosed () ),
                       & toplevel, SLOT ( quitApplicationSlot () ) );
    QObject::connect ( qApp, SIGNAL ( aboutToQuit () ),
                       & toplevel, SLOT ( quitApplicationSlot () ) );
    toplevel.setWindowIcon ( QIcon ( settings.iconPathName ) );
    toplevel.loadStartPageSlot ();
    toplevel.show ();

    Watchdog watchdog;
    QObject::connect ( watchdog.aboutAction, SIGNAL ( triggered () ),
                       & toplevel, SLOT ( aboutSlot () ) );
    QObject::connect ( watchdog.quitAction, SIGNAL ( triggered () ),
                       & toplevel, SLOT ( quitApplicationSlot () ) );

    return app.exec ();

}

Settings::Settings ()
    : QSettings ( 0 )
{

    settingsFileName = QDir::toNativeSeparators (
                QApplication::applicationDirPath () + QDir::separator() + "peb.ini" );
    QSettings settings ( settingsFileName, QSettings::IniFormat );
    startPage = settings.value ( "gui/start_page" ). toString ();
    icon = settings.value ( "gui/icon" ) .toString ();
    windowSize = settings.value ( "gui/window_size" ) .toString ();
    framelessWindow = settings.value ( "gui/frameless_window" ) .toString ();
    stayOnTop = settings.value ( "gui/stay_on_top" ) .toString ();
    browserTitle = settings.value ( "gui/browser_title" ) .toString ();
    contextMenu = settings.value ( "gui/context_menu" ) .toString ();
    iconPathName = QDir::toNativeSeparators ( QApplication::applicationDirPath () +
                                              QDir::separator () + icon );

}

Watchdog::Watchdog ()
    : QSystemTrayIcon ( 0 )
{

    QProcess server;
    server.startDetached ( QString ( QApplication::applicationDirPath () +
                                     QDir::separator () + "mongoose" ) );

    QTimer * timer = new QTimer ( this );
    connect ( timer, SIGNAL ( timeout () ), this, SLOT ( pingSlot () ) );
    timer -> start ( 5000 );

    trayIcon = new QSystemTrayIcon ();
    trayIcon -> setIcon ( QIcon ( settings.iconPathName ) );
    trayIcon -> setToolTip ( "Camel Calf" );

    aboutAction = new QAction ( tr ( "&About" ), this );
    aboutQtAction = new QAction ( tr ( "About Q&t" ), this );
    QObject::connect ( aboutQtAction, SIGNAL ( triggered () ),
                       qApp, SLOT ( aboutQt () ) );
    quitAction = new QAction ( tr ( "&Quit" ), this );

    trayIconMenu = new QMenu ();
    trayIcon -> setContextMenu ( trayIconMenu );
    trayIconMenu -> addAction ( aboutAction );
    trayIconMenu -> addAction ( aboutQtAction );
    trayIconMenu -> addSeparator ();
    trayIconMenu -> addAction ( quitAction );
    trayIcon -> show ();

}

Page::Page ()
    : QWebPage ( 0 )
{

    QWebSettings::globalSettings() ->
            setDefaultTextEncoding ( QString ( "utf-8" ) );
    QWebSettings::globalSettings() ->
            setAttribute ( QWebSettings::PluginsEnabled, true );
    QWebSettings::globalSettings() ->
            setAttribute ( QWebSettings::JavascriptEnabled, true );
    QWebSettings::globalSettings() ->
            setAttribute ( QWebSettings::JavascriptCanOpenWindows, false );
    QWebSettings::globalSettings() ->
            setAttribute ( QWebSettings::SpatialNavigationEnabled, true );
    QWebSettings::globalSettings() ->
            setAttribute ( QWebSettings::LinksIncludedInFocusChain, true );
    QWebSettings::globalSettings() ->
            setAttribute ( QWebSettings::PrivateBrowsingEnabled, true );
    QWebSettings::globalSettings() ->
            setAttribute ( QWebSettings::AutoLoadImages, true );
    QWebSettings::globalSettings() ->
            setAttribute ( QWebSettings::LocalContentCanAccessFileUrls, true );
    QWebSettings::globalSettings() ->
            setAttribute ( QWebSettings::LocalContentCanAccessRemoteUrls, true );
    QWebSettings::globalSettings() ->
            setAttribute ( QWebSettings::DeveloperExtrasEnabled, true );
//    QWebSettings::globalSettings() ->
//            setAttribute ( QWebSettings::LocalStorageEnabled, true );
    QWebSettings::setMaximumPagesInCache ( 0 );
    QWebSettings::setObjectCacheCapacities ( 0, 0, 0 );
    QWebSettings::clearMemoryCaches ();

    QObject::connect ( & longRunningScriptHandler, SIGNAL ( readyReadStandardOutput () ),
                       this, SLOT ( displayLongRunningScriptOutputSlot () ) );
    QObject::connect ( & longRunningScriptHandler, SIGNAL ( finished ( int, QProcess::ExitStatus ) ),
                       this, SLOT ( longRunningScriptFinishedSlot () ) );
    QObject::connect ( & longRunningScriptHandler, SIGNAL ( readyReadStandardError () ),
                       this, SLOT ( displayLongRunningScriptErrorSlot() ) );

}

TopLevel::TopLevel ()
    : QWebView ( 0 )
{

    QShortcut * maximizeShortcut = new QShortcut ( QKeySequence ( "Ctrl+M" ), this );
    QObject::connect ( maximizeShortcut, SIGNAL ( activated () ),
                       this, SLOT ( maximizeSlot () ) );
    QShortcut * minimizeShortcut = new QShortcut ( Qt::Key_Escape, this );
    QObject::connect ( minimizeShortcut, SIGNAL ( activated () ),
                       this, SLOT ( minimizeSlot () ) );
    QShortcut * toggleFullScreenShortcut = new QShortcut ( Qt::Key_F11, this );
    QObject::connect ( toggleFullScreenShortcut, SIGNAL ( activated () ),
                       this, SLOT ( toggleFullScreenSlot () ) );
    QShortcut * homeShortcut = new QShortcut ( Qt::Key_F12, this );
    QObject::connect ( homeShortcut, SIGNAL ( activated () ),
                       this, SLOT ( loadStartPageSlot () ) );
    QShortcut * printShortcut = new QShortcut ( QKeySequence ("Ctrl+P"), this );
    QObject::connect ( printShortcut, SIGNAL ( activated () ),
                       this, SLOT ( printPageSlot () ) );
    QShortcut * closeAppShortcut = new QShortcut ( QKeySequence ( "Ctrl+X" ), this );
    QObject::connect ( closeAppShortcut, SIGNAL ( activated () ),
                       this, SLOT ( quitApplicationSlot () ) );

    if ( settings.windowSize != "maximized" or settings.windowSize != "fullscreen" )
    {
        int fixedWidth = settings.windowSize.section ( "x", 0, 0 ) .toInt ();
        int fixedHeight = settings.windowSize.section ( "x", 1, 1 ) .toInt ();
        if ( fixedWidth > 100 and fixedHeight > 100 )
        {
            setFixedSize ( fixedWidth, fixedHeight );
            QRect screenRect = QDesktopWidget () .screen () -> rect ();
            move ( QPoint ( screenRect.width () / 2 - width () / 2,
                            screenRect.height () / 2 - height () / 2 ) );
        }
    }
    if ( settings.windowSize == "maximized")
    {
        showMaximized();
    }
    if ( settings.windowSize == "fullscreen" )
    {
        showFullScreen();
    }
    if ( settings.stayOnTop == "yes" )
    {
        setWindowFlags ( Qt::WindowStaysOnTopHint );
    }
    if ( settings.stayOnTop == "yes" and settings.framelessWindow == "yes" )
    {
        setWindowFlags ( Qt::WindowStaysOnTopHint | Qt::FramelessWindowHint );
    }
    if ( settings.stayOnTop == "no" and settings.framelessWindow == "yes" )
    {
        setWindowFlags ( Qt::FramelessWindowHint );
    }
    if ( settings.browserTitle != "dynamic" )
    {
        setWindowTitle ( settings.browserTitle );
    }
    if ( settings.contextMenu == "no" )
    {
        setContextMenuPolicy ( Qt::NoContextMenu );
    }

    mainPage = new Page ();

    QObject::connect ( mainPage, SIGNAL ( closeWindowSignal () ),
                       this, SLOT ( close () ) );
    QObject::connect ( mainPage, SIGNAL ( quitFromURLSignal () ),
                       this, SLOT ( quitApplicationSlot () ) );
    if ( settings.browserTitle == "dynamic" )
    {
        QObject::connect ( mainPage, SIGNAL ( loadFinished ( bool ) ),
                           this, SLOT ( pageLoadedDynamicTitleSlot ( bool ) ) );
    } else {
        QObject::connect ( mainPage, SIGNAL ( loadFinished ( bool ) ),
                           this, SLOT ( pageLoadedStaticTitleSlot ( bool ) ) );
    }

    setPage ( mainPage );

    ModifiedNetworkAccessManager * nam = new ModifiedNetworkAccessManager ();
    mainPage -> setNetworkAccessManager ( nam );

    //main_page -> setLinkDelegationPolicy ( QWebPage::DelegateAllLinks );

    // Scroll bars:
    mainPage -> mainFrame () -> setScrollBarPolicy ( Qt::Horizontal, Qt::ScrollBarAsNeeded );
    mainPage -> mainFrame () -> setScrollBarPolicy ( Qt::Vertical, Qt::ScrollBarAsNeeded );

    // Disabling history:
    QWebHistory * history = mainPage -> history ();
    history -> setMaximumItemCount ( 0 );

    // Context menu settings:
    mainPage -> action ( QWebPage::CopyLinkToClipboard ) -> setVisible ( true );
    mainPage -> action ( QWebPage::Back ) -> setVisible ( false );
    mainPage -> action ( QWebPage::Forward ) -> setVisible ( false );
    mainPage -> action ( QWebPage::Stop ) -> setVisible ( false );
    mainPage -> action ( QWebPage::OpenLink ) -> setVisible ( false );
    mainPage -> action ( QWebPage::OpenLinkInNewWindow ) -> setVisible ( false );
    mainPage -> action ( QWebPage::OpenFrameInNewWindow ) -> setVisible ( false );
    mainPage -> action ( QWebPage::DownloadLinkToDisk ) -> setVisible ( false );
    mainPage -> action ( QWebPage::SetTextDirectionLeftToRight ) -> setVisible ( false );
    mainPage -> action ( QWebPage::SetTextDirectionRightToLeft ) -> setVisible ( false );
    mainPage -> action ( QWebPage::OpenImageInNewWindow ) -> setVisible ( false );
    mainPage -> action ( QWebPage::DownloadImageToDisk ) -> setVisible ( false );
    mainPage -> action ( QWebPage::CopyImageToClipboard ) -> setVisible ( false );
    mainPage -> action ( QWebPage::Reload ) -> setVisible ( false );

}

bool Page::acceptNavigationRequest ( QWebFrame * frame,
                                     const QNetworkRequest & request,
                                     QWebPage::NavigationType navigationType )
{

    if ( frame != Page::currentFrame () and
         ( QUrl ( "http://perl-executing-browser-pseudodomain/" ) )
         .isParentOf ( request.url () ) )
    {
        if ( ! Page::mainFrame() -> childFrames () .contains ( frame ) )
        {
            if ( ! request.url () .path () .contains ( "longrun" ) )
            {
                newWindow = new TopLevel;
                newWindow -> setWindowIcon ( QIcon ( settings.iconPathName ) );
                newWindow -> setUrl ( QUrl::fromLocalFile (
                                          QDir::toNativeSeparators (
                                              QApplication::applicationDirPath () +
                                              QDir::separator () + request.url () .path () ) ) );
                newWindow -> show ();

//                QMessageBox msgBox;
//                msgBox.setWindowTitle ( "Open in New Window Requested" );
//                msgBox.setIconPixmap ( QPixmap ( iconPathName ) );
//                msgBox.setText
//                        ( "Opening URL in a new window is not allowed!" );
//                msgBox.setDefaultButton ( QMessageBox::Ok );
//                msgBox.exec ();

                return true;
            }
        }
    }

    if ( navigationType == QWebPage::NavigationTypeLinkClicked and
         request.url () .toString () .contains ( "openfile:" ) )
    {
        QFileDialog dialog;
        dialog.setFileMode ( QFileDialog::AnyFile );
        dialog.setViewMode ( QFileDialog::Detail );
        dialog.setOption ( QFileDialog::DontUseNativeDialog );
        dialog.setWindowFlags ( Qt::WindowStaysOnTopHint );
        dialog.setWindowIcon ( QIcon ( settings.iconPathName ) );
        fileNameToOpenString = dialog.getOpenFileName ( 0, "Select File",
                                                          QDir::currentPath (), "All files (*)" );
        QByteArray fileName;
        fileName.append ( fileNameToOpenString );
        qputenv ( "FILE_TO_OPEN", fileName );
        qDebug () << "File to open:" << fileName;
        qDebug () << "===============";
        dialog.close ();
        dialog.deleteLater ();
        return true;
    }

    if ( navigationType == QWebPage::NavigationTypeLinkClicked and
         request.url () .toString () .contains ( "openfolder:" ) )
    {
        QFileDialog dialog;
        dialog.setFileMode ( QFileDialog::AnyFile );
        dialog.setViewMode ( QFileDialog::Detail );
        dialog.setOption ( QFileDialog::DontUseNativeDialog );
        dialog.setWindowFlags ( Qt::WindowStaysOnTopHint );
        dialog.setWindowIcon ( QIcon ( settings.iconPathName ) );
        folderNameToOpenString = dialog.getExistingDirectory ( 0, "Select Folder",
                                                                 QDir::currentPath () );
        QByteArray folderName;
        folderName.append ( folderNameToOpenString );
        qputenv ( "FOLDER_TO_OPEN", folderName );
        qDebug () << "Folder to open:" << folderName;
        qDebug () << "===============";
        dialog.close ();
        dialog.deleteLater ();
        return true;
    }

    if ( navigationType == QWebPage::NavigationTypeLinkClicked and
         request.url () .toString () .contains ( "print:" ) )
    {
        qDebug () << "Printing requested.";
        qDebug () << "===============";
        QPrinter printer;
        printer.setOrientation ( QPrinter::Portrait );
        printer.setPageSize ( QPrinter::A4 );
        printer.setPageMargins ( 10, 10, 10, 10, QPrinter::Millimeter );
        printer.setResolution ( QPrinter::HighResolution );
        printer.setColorMode ( QPrinter::Color );
        printer.setPrintRange ( QPrinter::AllPages );
        printer.setNumCopies ( 1 );
        //            printer.setOutputFormat ( QPrinter::PdfFormat );
        //            printer.setOutputFileName ( "output.pdf" );
        QPrintDialog * dialog = new QPrintDialog ( & printer );
        dialog -> setWindowFlags ( Qt::WindowStaysOnTopHint );
        if ( dialog -> exec () == QDialog::Accepted )
        {
            frame -> print ( & printer );
        }
        dialog -> close ();
        dialog -> deleteLater ();
        return true;
    }

    if ( navigationType == QWebPage::NavigationTypeLinkClicked and
         request.url () .toString () .contains ( "quit:" ) )
    {
        qDebug () << "Application termination requested from URL.";
        qDebug () << "Exiting.";
        emit quitFromURLSignal ();
    }

    if ( navigationType == QWebPage::NavigationTypeLinkClicked and
         request.url () .toString () .contains ( "closewindow:" ) )
    {
        qDebug () << "Close window requested from URL.";
        qDebug () << "===============";
        emit closeWindowSignal ();
    }

    if ( navigationType == QWebPage::NavigationTypeLinkClicked and
         request.url () .toString () .contains ( "external:" ) )
    {
        externalApplication = request.url ()
                .toString ( QUrl::RemoveScheme )
                .replace ( "/", "" );
        qDebug () << "External application: " << externalApplication;
        qDebug () << "===============";
        QProcess externalProcess;
        externalProcess.startDetached ( externalApplication );
        return false;
    }

    if ( navigationType == QWebPage::NavigationTypeLinkClicked and
         request.url () .scheme () .contains ( "http" ) and
         ! ( QUrl ( "http://perl-executing-browser-pseudodomain/" ) )
         .isParentOf ( request.url () ) )
    {
        if ( request.url () .authority () .contains ( "localhost" ) )
        {
            qDebug () << "Local webserver link:" << request.url () .toString ();
            qDebug () << "===============";
            return QWebPage::acceptNavigationRequest ( frame, request, navigationType );
        }
        if ( request.url () .authority () .contains ( "www.perl.com" ) )
        {
            allowedWebLink = request.url () .toString ();
            qDebug () << "Allowed web link:" << allowedWebLink;
            qDebug () << "===============";
            return QWebPage::acceptNavigationRequest ( frame, request, navigationType );
        } else {
            externalWebLink = request.url () .toString ();
            qDebug () << "External browser called for:" << externalWebLink;
            qDebug () << "===============";
            QDesktopServices::openUrl ( request.url () );
            return false;
        }
    }

    if ( navigationType == QWebPage::NavigationTypeLinkClicked and
         request.url () .scheme () .contains ( "file" ) )
    {
        QString filepath = request.url () .toString ( QUrl::RemoveScheme );
        QFile file ( QDir::toNativeSeparators ( filepath ) );
        if ( file.exists() )
        {
            defaultApplicationFile = request.url() .toString();
            qDebug () << "Opening file with default application:" << defaultApplicationFile;
            qDebug () << "===============";
            QDesktopServices::openUrl ( request.url() );
            return false;
        }
    }

    if ( navigationType == QWebPage::NavigationTypeLinkClicked and
         ( QUrl ( "http://perl-executing-browser-pseudodomain/" ) )
         .isParentOf ( request.url () ) )
    {

        if ( request.url () .path () .contains ( "longrun" ) )
        {
            qDebug () << "Long-running script detected.";
        }
        qDebug () << "Local link:" << request.url () .toString ();
        filepath = request.url ()
                .toString ( QUrl::RemoveScheme | QUrl::RemoveAuthority |
                            QUrl::RemoveQuery | QUrl::RemoveFragment );
        qDebug () << "File path:" << QDir::toNativeSeparators (
                         QApplication::applicationDirPath() + filepath );

        checkFileExistenceSlot ();

        extension = filepath.section ( ".", 1, 1 );
        qDebug () << "Extension:" << extension;
        defineInterpreterSlot ();

        if ( extension == "pl" or extension == "php" or extension == "py" )
        {
            qDebug () << "Interpreter:" << interpreter;

            QProcessEnvironment env = QProcessEnvironment::systemEnvironment();
            env.insert ( "REQUEST_METHOD", "GET" );
            QString query = request.url ()
                    .toString ( QUrl::RemoveScheme |
                                QUrl::RemoveAuthority |
                                QUrl::RemovePath )
                    .replace ( "?", "" );
            env.insert ( "QUERY_STRING", query );

            QProcess handler;

            if ( request.url () .path () .contains ( "longrun" ) )
            {
                longRunningScriptHandler.setProcessEnvironment ( env );
            } else {
                handler.setProcessEnvironment ( env );
            }

            QFileInfo file ( filepath );
            QString fileDirectory = QDir::toNativeSeparators (
                        QApplication::applicationDirPath() +
                        file.absoluteDir() .absolutePath () );
            qDebug () << "Working directory:" << fileDirectory;
            qDebug () << "TEMP folder:" << QDir::tempPath();
            qDebug () << "===============";

            if ( request.url () .path () .contains ( "longrun" ) )
            {
                longRunningScriptHandler.setWorkingDirectory ( fileDirectory );
            } else {
                handler.setWorkingDirectory ( fileDirectory );
                handler.setStandardOutputFile (
                            QDir::toNativeSeparators (
                                QDir::tempPath () + QDir::separator () + "output.htm" ) );
                handler.setStandardErrorFile (
                            QDir::toNativeSeparators (
                                QDir::tempPath () + QDir::separator () + "error.txt" ) );
            }

            if ( request.url () .path () .contains ( "longrun" ) )
            {
                longRunningScriptHandler.start ( interpreter, QStringList() <<
                                                 QDir::toNativeSeparators (
                                                     QApplication::applicationDirPath () +
                                                     QDir::separator () + filepath ) );
                if ( frame == Page::currentFrame () )
                {
                    longRunningScriptOutputInNewWindow = false;
                }
                if ( frame != Page::currentFrame () )
                {
                    longRunningScriptOutputInNewWindow = true;
                    lastRequest = request;
                    newLongRunWindow = new TopLevel;
                    newLongRunWindow -> setWindowIcon ( QIcon ( settings.iconPathName ) );
                }
            } else {
                handler.start ( interpreter, QStringList() << QDir::toNativeSeparators (
                                    QApplication::applicationDirPath () +
                                    QDir::separator () + filepath ) );
                // wait until handler has finished:
                if ( ! handler.waitForFinished() )
                    return 1;
                frame -> load ( QUrl::fromLocalFile (
                                    QDir::toNativeSeparators (
                                        QDir::tempPath () + QDir::separator () +
                                        "output.htm" ) ) );
                handler.close ();
            }
        }

        if ( extension == "htm" or extension == "html" )
        {
            frame -> load ( QUrl::fromLocalFile (
                                QDir::toNativeSeparators (
                                    QApplication::applicationDirPath () +
                                    QDir::separator () + filepath ) ) );
            qDebug () << "===============";
        }

        QWebSettings::clearMemoryCaches ();
        return true;
    }

    // GET method form data:
    if ( navigationType == QWebPage::NavigationTypeFormSubmitted and
         ( QUrl ( "http://perl-executing-browser-pseudodomain/" ) )
         .isParentOf ( request.url () ) and request.url ()
         .toString ( QUrl::RemoveScheme |
                     QUrl::RemoveAuthority |
                     QUrl::RemovePath )
         .replace ( "?", "" ).length() > 0 )
    {

        qDebug () << "Form submitted to:" << request.url () .toString ( QUrl::RemoveQuery );

        filepath = request.url ()
                .toString ( QUrl::RemoveScheme | QUrl::RemoveAuthority | QUrl::RemoveQuery );

        qDebug () << "Script path:" << QDir::toNativeSeparators (
                         QApplication::applicationDirPath () + filepath );

        checkFileExistenceSlot ();

        qDebug () << "Query string:" << request.url()
                     .toString ( QUrl::RemoveScheme |
                                 QUrl::RemoveAuthority |
                                 QUrl::RemovePath )
                     .replace ( "?", "" );

        extension = filepath.section ( ".", 1, 1 );
        qDebug () << "Extension:" << extension;
        defineInterpreterSlot ();

        if ( extension == "pl" or extension == "php" or extension == "py" )
        {
            qDebug () << "Interpreter:" << interpreter;
            QProcess handler;
            QProcessEnvironment env = QProcessEnvironment::systemEnvironment();
            env.insert ( "REQUEST_METHOD", "GET" );
            QString query = request.url()
                    .toString ( QUrl::RemoveScheme |
                                QUrl::RemoveAuthority |
                                QUrl::RemovePath )
                    .replace ( "?", "" );
            env.insert ( "QUERY_STRING", query );
            handler.setProcessEnvironment ( env );

            QFileInfo script ( filepath );
            QString scriptDirectory = QDir::toNativeSeparators (
                        QApplication::applicationDirPath () +
                        script.absoluteDir () .absolutePath () );
            handler.setWorkingDirectory ( scriptDirectory );
            qDebug () << "Working directory:" << scriptDirectory;

            handler.setStandardOutputFile (
                        QDir::toNativeSeparators (
                            QDir::tempPath () +
                            QDir::separator () + "output.htm" ) );
            qDebug () << "TEMP folder:" << QDir::tempPath();
            qDebug () << "===============";
            handler.start ( interpreter, QStringList() << QDir::toNativeSeparators (
                                QApplication::applicationDirPath () +
                                QDir::separator () + filepath ) );
            // wait until handler has finished
            if ( ! handler.waitForFinished () )
                return 1;
            frame -> load ( QUrl::fromLocalFile (
                                QDir::toNativeSeparators (
                                    QDir::tempPath () +
                                    QDir::separator () + "output.htm" ) ) );
            handler.close ();
            qputenv ( "FILE_TO_OPEN", "" );
            qputenv ( "FOLDER_TO_OPEN", "" );
        }

        QWebSettings::clearMemoryCaches();
        return true;
    }

    QNetworkRequest emptyRequest;
    return QWebPage::acceptNavigationRequest ( frame, emptyRequest, navigationType );
}
