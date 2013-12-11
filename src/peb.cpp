
// Perl Executing Browser, v.0.1
// peb-webkit

// Perl Executing Browser (PEB) is a Qt4/5 WebKit-powered browser,
// which is capable of executing Perl (possibly PHP/Python) scripts locally without a webserver,
// providing them with a nice HTML4/5 interface for both input and output and
// using CGI protocol GET method for communication between HTML forms and scripts.

// PEB can be used as a fast and easy GUI framework for Perl (possibly PHP/Python) scripts and
// has the following design objectives:
// 1. Easy creation of nice and reusable HTML/CSS/JavaScript-powered GUIs for scripts;
// 2. Zero installation solution:
//    pack your Perl modules or even your version of Perl with your copy of PEB browser and
//    the necessary Qt libraries and run your application from everywhere, even from USB sticks;
// 3. Cross-platform availability:
//    use it on every platform where Perl and Qt4 or Qt5 could be compiled;
// 4. More security for private data that does not need to be accessible over a network:
//    no services are started, no ports are opened, no firewall notifications,
//    no need to have administrative privileges, everything remains in the userspace.

// PEB also exposes some desktop functionalities to the end user of the hosted scripts.
// These are accessible from special URLs and currently are:
// open file, open folder and close browser.
// File to open and folder to open are accessible for every script as $ARGV[0] and $ARGV[1].
// Printing current page by clicking a special URL is also supported.

// PEB is primarily intended as a basic framework for small personal databases,
// but many other use scenarios are also possible.
// Network connections are in no way out of reach, but they have to be
// implemented entirely in the scripts that PEB is going to execute.

// This small project is still in its very beginning and
// current version should be considered alpha pre-release.
// Do not use it for production purposes!
// Many features have to be polished and some have to be created from scratch.
// Documentation and proper examples are still missing...
// Compiled and tested successfully using:
// 1. Qt Creator 2.5.0 and Qt 4.8.2 under 32 bit Debian Linux,
// 2. Qt Creator 2.8.1 and Qt 5.1.1 under 32 bit Debian Linux.

// This software is licensed under the terms of GNU GPL v.3 and
// is provided without warranties of any kind!
// Dimitar D. Mitov, 2013, ddmitov (at) yahoo (dot) com

// REFERENCES:
// https://gitorious.org/qt-examples/qt-examples/source/sitespecificbrowser
// http://qt-project.org/doc/qt-5.0/qtwebkit/qwebsettings.html
// http://qt-project.org/doc/qt-5.0/qtcore/qsettings.html
// http://qt-project.org/doc/qt-5.0/qtcore/qprocess.html
// http://qt-project.org/doc/qt-5.0/qtcore/qurl.html
// http://qt-project.org/doc/qt-5.0/qtcore/qstring.html
// http://qt-project.org/doc/qt-4.8/qwebhistory.html
// http://qt-project.org/wiki/How_to_Use_QSettings
// http://qt-project.org/forums/viewthread/23835
// http://qt-project.org/forums/viewthread/5318
// http://qt-project.org/forums/viewthread/8270
// http://qt-project.org/forums/viewthread/18292
// http://qt-project.org/forums/viewthread/6102
// http://qt-project.org/forums/viewthread/17635
// http://www.qtcentre.org/threads/23094-cancle-right-click-context-menu-in-qtwebkit
// http://www.qtcentre.org/threads/25880-QWebView-prints-PDF-file-OK-with-QPrintDialog-only
// http://www.qtcentre.org/threads/39673-QWebView-and-right-click-reload
// http://www.qtcentre.org/threads/46016-Place-QMessageBox-on-middle-of-screen
// http://www.qtcentre.org/threads/4322-How-to-delete-File
// http://www.qtcentre.org/threads/53731-compiling-under-qt4-AND-qt5
// http://www.qtcentre.org/archive/index.php/t-31264.html
// http://developer.nokia.com/Community/Discussion/showthread.php/212357-How-to-disable-the-scrollbar-of-QWebView
// http://developer.nokia.com/Community/Wiki/Archived:How_to_create_a_message_box_in_Qt
// http://developer.nokia.com/Community/Wiki/Fullscreen_applications_on_Qt
// http://harmattan-dev.nokia.com/docs/library/html/qt4/qkeysequence.html
// http://harmattan-dev.nokia.com/docs/library/html/qt4/qdir.html
// http://harmattan-dev.nokia.com/docs/library/html/qtwebkit/qwebpage.html
// http://harmattan-dev.nokia.com/docs/library/html/qtwebkit/qwebview.html
// http://stackoverflow.com/questions/9685615/qt-and-linux-pipes
// http://stackoverflow.com/questions/14987007/what-is-the-expected-encoding-for-qwebviewsethtml
// http://stackoverflow.com/questions/10666998/qwebkit-display-local-webpage
// http://stackoverflow.com/questions/7402576/how-to-get-current-working-directory-in-a-qt-application
// http://stackoverflow.com/questions/8026101/correct-way-to-quit-a-qt-program
// http://stackoverflow.com/questions/8122094/qtwebkit-printing-issue-no-images-on-printed-page
// http://stackoverflow.com/questions/2029272/how-to-declare-a-global-variable-that-could-be-used-in-the-entire-program
// http://stackoverflow.com/questions/1246825/fullscreen-widget
// http://stackoverflow.com/questions/12571895/save-open-dialog-localization-in-qt
// http://stackoverflow.com/questions/3518090/how-to-get-the-query-string-from-a-qurl
// http://stackoverflow.com/questions/6955281/how-to-stop-qhttp-qtwebkit-from-caching-pages
// http://stackoverflow.com/questions/3211771/how-to-convert-int-to-qstring
// https://github.com/rsdn/avalon/blob/master/web_view.cpp
// https://github.com/ariya/phantomjs/blob/master/src/qt/src/3rdparty/webkit/Source/WebKit/qt/Api/qwebpage.cpp
// http://www.codeprogress.com/cpp/libraries/qt/showQtExample.php?index=598&key=QWebViewCustomContextMenu
// http://www.java2s.com/Code/Cpp/Qt/CheckfileexistanceandfilenamewithQFile.htm
// http://www.stringreplace.com/c-plus-plus/qt-string-replace-method/
// http://fr.openclassrooms.com/forum/sujet/qt-icone-et-titre-non-charge-d-un-qwebview-54256
// http://en.wikipedia.org/wiki/Common_Gateway_Interface
// http://en.wikipedia.org/wiki/INI_file

// Special thanks to the staff of the Library of the New Bulgarian University,
// where much of the coding effort took place!

#include <qglobal.h>
#if QT_VERSION >= 0x050000
    // Qt5 code:
    #include <QtWidgets>
#else
    // Qt4 code:
    #include <QtGui>
    #include <QApplication>
#endif

#include <QtNetwork/QNetworkRequest>
#include <QWebView>
#include <QWebPage>
#include <QWebFrame>
#include <QWebHistory>
#include <QProcess>
#include <QPrintDialog>
#include <QPrinter>
#include <QDebug>
#include "peb.h"

QString fileName;
QString folderName;

int main ( int argc, char **argv )
{
    QApplication app ( argc, argv );

    QString settingsFileName = QApplication::applicationDirPath() + QDir::separator () + "peb.ini";
    QSettings settings ( settingsFileName, QSettings::NativeFormat );

    QFile settingsFile ( settingsFileName );
    if( !settingsFile.exists() )
    {
        QMessageBox msgBox;
        msgBox.setIcon( QMessageBox::Critical );
        msgBox.setWindowTitle ( "Critical file missing" );
        msgBox.setText ( "'peb.ini' is missing.<br>Please restore the missing file." );
        msgBox.setDefaultButton( QMessageBox::Ok );
        msgBox.exec();
        return 1;
        qApp->exit();
    }

    QString windowIcon = settings.value ( "gui/icon" ).toString();
    QString fixedWidth = settings.value ( "gui/fixed_width" ).toString();
    QString fixedHeight = settings.value ( "gui/fixed_heigth" ).toString();
    QString stayOnTop = settings.value ( "gui/stay_on_top" ).toString();
    QString framelessWindow = settings.value ( "gui/frameless_window" ).toString();

    QApplication::setWindowIcon ( QIcon ( qApp->applicationDirPath() +
                                          QDir::separator () + "icons" +
                                          QDir::separator () + windowIcon ) );

    #if QT_VERSION >= 0x050000
    QTextCodec::setCodecForLocale ( QTextCodec::codecForName ( "UTF8" ) );
    #else
    QTextCodec::setCodecForCStrings ( QTextCodec::codecForName ( "UTF8" ) );
    #endif

    QWebSettings::globalSettings() -> setDefaultTextEncoding ( QString ( "utf-8" ) );
    QWebSettings::globalSettings() -> setAttribute ( QWebSettings::PluginsEnabled, true );
    QWebSettings::globalSettings() -> setAttribute ( QWebSettings::JavascriptEnabled, true );
    QWebSettings::globalSettings() -> setAttribute ( QWebSettings::SpatialNavigationEnabled, true );
    QWebSettings::globalSettings() -> setAttribute ( QWebSettings::LinksIncludedInFocusChain, true );
    QWebSettings::globalSettings() -> setAttribute ( QWebSettings::PrivateBrowsingEnabled, true );
    QWebSettings::globalSettings() -> setAttribute ( QWebSettings::AutoLoadImages, true );
    QWebSettings::setMaximumPagesInCache ( 0 );
    QWebSettings::setObjectCacheCapacities ( 0, 0, 0 );
    QWebSettings::clearMemoryCaches();

    TopLevel toplevel;

    if ( fixedWidth != "false" and fixedHeight != "false" ) {
        QRect screenRect = QDesktopWidget().screen()->rect();
        toplevel.move ( QPoint(screenRect.width()/2 - toplevel.width()/2,
                               screenRect.height()/2 - toplevel.height()/2 ) );
    }

    if ( stayOnTop == "yes" ) {
        toplevel.setWindowFlags ( Qt::WindowStaysOnTopHint );
    }

    if ( stayOnTop == "yes" and framelessWindow == "yes" ) {
        toplevel.setWindowFlags ( Qt::WindowStaysOnTopHint | Qt::FramelessWindowHint );
    }

    if ( stayOnTop != "yes" and framelessWindow == "yes" ) {
        toplevel.setWindowFlags ( Qt::FramelessWindowHint );
    }

    toplevel.show();
    app.exec();

};

Page::Page()
    : QWebPage ( 0 )
{
}

TopLevel::TopLevel()
    : QWebView ( 0 )
{
    // Reading settings from peb.ini file
    QString settingsFileName = QApplication::applicationDirPath() + "/peb.ini";
    QSettings settings ( settingsFileName, QSettings::NativeFormat );
    QString windowTitle = settings.value ( "gui/window_title" ).toString();
    QString startPage = settings.value ( "gui/start_page" ).toString();
    QString maximizedWindow = settings.value ( "gui/maximized_window" ).toString();
    QString fullScreen = settings.value ( "gui/full_screen" ).toString();
    QString contextMenu = settings.value ( "gui/context_menu" ).toString();
    QString fixedWidth = settings.value ( "gui/fixed_width" ).toString();
    QString fixedHeight = settings.value ( "gui/fixed_heigth" ).toString();

    main_page = new Page();
    setPage ( main_page );
    main_page -> setLinkDelegationPolicy ( QWebPage::DelegateAllLinks );
    // Disabling horizontal scroll bar:
    main_page -> mainFrame() -> setScrollBarPolicy ( Qt::Horizontal, Qt::ScrollBarAlwaysOff );
    // Disabling history:
    QWebHistory* history = main_page -> history();
    history -> setMaximumItemCount ( 0 );

    // Context menu settings:
    main_page -> action ( QWebPage::CopyLinkToClipboard ) -> setVisible ( true );
    //main_page -> action ( QWebPage::CopyLinkToClipboard ) -> setText ( QString::fromUtf8 ( "Copy Address" ) );
    main_page -> action ( QWebPage::Back ) -> setVisible ( false );
    main_page -> action ( QWebPage::Forward ) -> setVisible ( false );
    main_page -> action ( QWebPage::Stop ) -> setVisible ( false );
    main_page -> action ( QWebPage::OpenLink ) -> setVisible ( false );
    main_page -> action ( QWebPage::OpenLinkInNewWindow ) -> setVisible ( false );
    main_page -> action ( QWebPage::OpenFrameInNewWindow ) -> setVisible ( false );
    main_page -> action ( QWebPage::DownloadLinkToDisk ) -> setVisible ( false );
    main_page -> action ( QWebPage::SetTextDirectionLeftToRight )-> setVisible ( false );
    main_page -> action ( QWebPage::SetTextDirectionRightToLeft )-> setVisible ( false );
    main_page -> action ( QWebPage::OpenImageInNewWindow ) -> setVisible ( false );
    main_page -> action ( QWebPage::DownloadImageToDisk ) -> setVisible ( false );
    main_page -> action ( QWebPage::CopyImageToClipboard ) -> setVisible ( false );
    main_page -> action ( QWebPage::Reload ) -> setVisible ( false );

    QShortcut * maximizeShortcut = new QShortcut ( QKeySequence ( "Ctrl+M" ), this );
    QObject::connect ( maximizeShortcut, SIGNAL ( activated() ), this, SLOT ( maximizeSlot() ) );

    QShortcut * minimizeShortcut = new QShortcut ( Qt::Key_Escape, this );
    QObject::connect ( minimizeShortcut, SIGNAL ( activated() ), this, SLOT ( minimizeSlot() ) );

    QShortcut * helpShortcut = new QShortcut ( Qt::Key_F1, this );
    QObject::connect ( helpShortcut, SIGNAL ( activated() ), this, SLOT ( helpSlot() ) );

    QShortcut * configShortcut = new QShortcut ( Qt::Key_F2, this );
    QObject::connect ( configShortcut, SIGNAL ( activated() ), this, SLOT ( configSlot() ) );

    QShortcut * toggleFullScreenShortcut = new QShortcut ( Qt::Key_F11, this );
    QObject::connect ( toggleFullScreenShortcut, SIGNAL ( activated() ), this, SLOT ( toggleFullScreenSlot() ) );

    QShortcut * printShortcut = new QShortcut ( QKeySequence ("Ctrl+P"), this );
    QObject::connect ( printShortcut, SIGNAL ( activated() ), this, SLOT ( printPageSlot() ) );

    QShortcut * closeAppShortcut = new QShortcut ( QKeySequence ( "Ctrl+X" ), this );
    QObject::connect ( closeAppShortcut, SIGNAL ( activated() ), this, SLOT ( closeAppSlot() ) );

    if ( windowTitle == "dynamic" ) {
        QObject::connect ( main_page, SIGNAL ( loadFinished (bool) ), this, SLOT ( pageLoadedDynamicTitle (bool) ) );
    } else {
        QObject::connect ( main_page, SIGNAL ( loadFinished (bool) ), this, SLOT ( pageLoadedStaticTitle (bool) ) );
    }

    if ( fixedWidth != "false" and fixedHeight != "false" ) {
        int fixedWidthInt = fixedWidth.toInt();
        int fixedHeightInt = fixedHeight.toInt();
        setFixedSize ( fixedWidthInt, fixedHeightInt );
    }

    if ( windowTitle != "dynamic" ) {
        setWindowTitle ( windowTitle );
    }

    if ( maximizedWindow == "yes" ) {
        showMaximized();
    }

    if ( fullScreen == "yes" ) {
        showFullScreen();
    }

    if ( contextMenu == "no" ) {
        setContextMenuPolicy ( Qt::NoContextMenu );
    }

    QProcess handler;
    QProcessEnvironment env = QProcessEnvironment::systemEnvironment();
    qDebug() << "Start page:" << startPage;
    QString startPageExtension = startPage.section ( ".", 1, 1 );
    qDebug() << "Extension:" << startPageExtension;

    if ( startPageExtension == "pl" ) {
        QString interpreter = "perl";
        qDebug() << "Interpreter:" << interpreter;
        env.insert ( "PERL5LIB", qApp->applicationDirPath() +
                     QDir::separator () + "perl" +
                     QDir::separator () + "lib" );
        env.insert ( "DOCUMENT_ROOT", qApp->applicationDirPath() );
        #ifdef Q_WS_WIN
            env.insert ("PATH", env.value ( "Path" ) + ";" +
                        qApp->applicationDirPath() + QDir::separator () + "scripts" ); //win32
        #endif
        #ifdef Q_OS_LINUX
            env.insert ( "PATH", env.value ( "PATH" ) + ":" +
                         qApp->applicationDirPath() + QDir::separator () + "scripts" ); //linux
        #endif
        handler.setProcessEnvironment ( env );
        handler.setWorkingDirectory ( qApp->applicationDirPath() + QDir::separator () + "scripts" );
        handler.setStandardOutputFile ( QDir::tempPath() + QDir::separator () + "output.htm" );
        qDebug() << "TEMP folder:" << QDir::tempPath();
        // call handler and add your input as argument
        handler.start ( interpreter, QStringList() << qApp->applicationDirPath() +
                        QDir::separator () + "scripts" + QDir::separator () + startPage );
        // wait until handler has finished
        if ( handler.waitForFinished() ){
            setUrl ( QUrl::fromLocalFile ( QDir::tempPath() + QDir::separator () + "output.htm" ) );
        }
        handler.close();
    }

    if ( startPageExtension == "htm" or startPageExtension == "html" ) {
        setUrl ( QUrl::fromLocalFile ( qApp->applicationDirPath() + QDir::separator () +
                                       "html" + QDir::separator () + startPage ) );
    }

    QWebSettings::clearMemoryCaches();

}

bool Page::acceptNavigationRequest ( QWebFrame *frame,
                                     const QNetworkRequest &request,
                                     QWebPage::NavigationType type )
{
    QString settingsFileName = QApplication::applicationDirPath() + QDir::separator () + "peb.ini";
    QSettings settings ( settingsFileName, QSettings::NativeFormat );
    QString windowIcon = settings.value ( "gui/icon" ).toString();
    QUrl allowedBase = ( QUrl ( "local://script/" ) );

    if ( type == QWebPage::NavigationTypeLinkClicked ) {
        QUrl OpenFileBase ( QUrl ( "local://openfile/" ) );
        if ( OpenFileBase.isParentOf ( request.url() ) ) {
            QFileDialog dialog;
            dialog.setFileMode ( QFileDialog::AnyFile );
            dialog.setViewMode ( QFileDialog::Detail );
            dialog.setOption ( QFileDialog::DontUseNativeDialog );
            dialog.setWindowIcon ( QIcon ( qApp -> applicationDirPath() + QDir::separator () +
                                           "icons" + QDir::separator () + windowIcon ) );
            fileName = dialog.getOpenFileName ( 0, "Select File", QDir::currentPath(), "All files (*)" );
            qDebug() << "File open request for:" << fileName;
            dialog.close();
            dialog.deleteLater();
            return true;
        }
    }

    if ( type == QWebPage::NavigationTypeLinkClicked ) {
        QUrl OpenFolderBase ( QUrl ( "local://openfolder/" ) );
        if ( OpenFolderBase.isParentOf ( request.url() ) ) {
            QFileDialog dialog;
            dialog.setFileMode ( QFileDialog::AnyFile );
            dialog.setViewMode ( QFileDialog::Detail );
            dialog.setOption ( QFileDialog::DontUseNativeDialog );
            dialog.setWindowIcon ( QIcon ( qApp->applicationDirPath() + QDir::separator () +
                                           "icons" + QDir::separator () + windowIcon ) );
            folderName = dialog.getExistingDirectory ( 0, "Select Folder", QDir::currentPath() );
            qDebug() << "Folder open request for:" << folderName;
            dialog.close();
            dialog.deleteLater();
            return true;
        }
    }

    if ( type == QWebPage::NavigationTypeLinkClicked ) {
        QUrl PrintBase ( QUrl ( "local://print/" ) );
        if ( PrintBase.isParentOf ( request.url() ) ) {
            qDebug() << "Printing requested.";
            QPrinter printer;
            printer.setOrientation ( QPrinter::Portrait );
            printer.setPageSize ( QPrinter::A4 );
            printer.setPageMargins ( 10, 10, 10, 10, QPrinter::Millimeter );
            printer.setResolution ( QPrinter::HighResolution );
            printer.setColorMode ( QPrinter::Color );
            printer.setPrintRange ( QPrinter::AllPages );
            printer.setNumCopies ( 1 );
            //        printer.setPrinterName ( "Print to File (PDF)" );
            //        printer.setOutputFormat ( QPrinter::PdfFormat );
            //        printer.setOutputFileName ( "output.pdf" );
            QPrintDialog* dialog = new QPrintDialog ( &printer );
            dialog->setWindowFlags ( Qt::WindowStaysOnTopHint );
            if ( dialog->exec() == QDialog::Accepted )
            {
                frame->print(&printer);
            }
            dialog->close();
            dialog->deleteLater();
            return true;
        }
    }

    if ( type == QWebPage::NavigationTypeLinkClicked ) {
        QUrl CloseBase ( QUrl ( "local://close/" ) );
        if ( CloseBase.isParentOf ( request.url() ) ) {
            qDebug() << "Application termination requested from URL.";
            qApp->exit();
        }
    }

    if ( type == QWebPage::NavigationTypeLinkClicked ) {
        QUrl ExternalBase ( QUrl ( "external:" ) );
        if ( ExternalBase.isParentOf ( request.url() ) ) {
            QString externalApplication = request.url()
                    .toString ( QUrl::RemoveScheme )
                    .replace ( "/", "" );
            qDebug() << "External application: " << externalApplication;
            QProcess externalProcess;
            externalProcess.setWorkingDirectory ( qApp->applicationDirPath() );
            externalProcess.startDetached ( externalApplication );
            return false;
        }
    }

    if ( type == QWebPage::NavigationTypeLinkClicked ) {
        QUrl base ( allowedBase );
        if ( !base.isParentOf ( request.url() ) &&
             !( QUrl ( "local://openfile/" ) ).isParentOf ( request.url() ) &&
             !( QUrl ( "local://openfolder/" ) ).isParentOf ( request.url() ) &&
             !( QUrl ( "local://print/" ) ).isParentOf ( request.url() ) &&
             !( QUrl ( "local://close/" ) ).isParentOf ( request.url() ) &&
             !( QUrl ( "external:" ) ).isParentOf ( request.url() )) {
            qDebug() << "External browser called for navigation to:" << request.url().toString();
            QDesktopServices::openUrl ( request.url() );
            return false;
        }
    }

    if ( type == QWebPage::NavigationTypeLinkClicked ) {
        QUrl base ( allowedBase );
        if ( base.isParentOf ( request.url() ) ) {
            qDebug() << "Local link clicked:" << request.url().toString();

            QProcess handler;
            QProcessEnvironment env = QProcessEnvironment::systemEnvironment();
            QString link = request.url()
                    .toString ( QUrl::RemoveScheme | QUrl::RemoveAuthority );
            QString file = request.url()
                    .toString ( QUrl::RemoveScheme | QUrl::RemoveAuthority | QUrl::RemoveQuery )
                    .replace ( "/", "" );
            qDebug() << "File:" << file;
            QString extension = file.section ( ".", 1, 1 );
            qDebug() << "Extension:" << extension;

            if ( extension == "pl" ) {
                QString interpreter = "perl";
                qDebug() << "Interpreter:" << interpreter;
                env.insert ( "PERL5LIB", qApp->applicationDirPath() + QDir::separator () +
                             "perl" + QDir::separator () + "lib" );
                env.insert ( "DOCUMENT_ROOT", qApp->applicationDirPath() );
                #ifdef Q_WS_WIN
                    env.insert ( "PATH", env.value ( "Path" ) + ";" + qApp->applicationDirPath() +
                                 QDir::separator () + "scripts" ); //win32
                #endif
                #ifdef Q_OS_LINUX
                    env.insert ( "PATH", env.value ( "PATH" ) + ":" + qApp->applicationDirPath() +
                                 QDir::separator () + "scripts" ); //linux
                #endif
                handler.setProcessEnvironment ( env );
                handler.setWorkingDirectory ( qApp->applicationDirPath() + QDir::separator () + "scripts" );
                handler.setStandardOutputFile ( QDir::tempPath() + QDir::separator () + "output.htm" );
                qDebug() << "TEMP folder:" << QDir::tempPath();
                // call handler and add your input as argument
                handler.start ( interpreter, QStringList() << qApp->applicationDirPath() +
                                QDir::separator () + "scripts" + QDir::separator () + link );
                // wait until handler has finished
                if ( !handler.waitForFinished() )
                    return 1;
                frame->load ( QUrl::fromLocalFile ( QDir::tempPath() + QDir::separator () + "output.htm" ) );
                handler.close();
            }

            if ( extension == "htm" or extension == "html" ) {
                frame->load ( QUrl::fromLocalFile ( qApp->applicationDirPath() + QDir::separator () +
                                                    "html" + QDir::separator () + link ) );
            }

            QWebSettings::clearMemoryCaches();
            return true;
        }
    }

    if ( type == QWebPage::NavigationTypeFormSubmitted ) {
        QUrl base ( allowedBase );
        if ( base.isParentOf( request.url() ) ) {
            qDebug() << "Form submitted to:" << request.url().toString();

            QProcess handler;
            QProcessEnvironment env = QProcessEnvironment::systemEnvironment();
            QString script = request.url()
                    .toString ( QUrl::RemoveScheme | QUrl::RemoveAuthority | QUrl::RemoveQuery )
                    .replace ( "/", "" );
            qDebug() << "Script:" << script;
            QString extension = script.section(".", 1, 1);
            qDebug() << "Extension:" << extension;

            if ( extension == "pl" ) {
                QString interpreter = "perl";
                qDebug() << "Interpreter:" << interpreter;
                QString query = request.url()
                        .toString ( QUrl::RemoveScheme | QUrl::RemoveAuthority | QUrl::RemovePath )
                        .replace ( "?", "" );
                env.insert ( "QUERY_STRING", query );
                env.insert ( "REQUEST_METHOD", "GET" );
                env.insert ( "PERL5LIB", qApp->applicationDirPath() + QDir::separator () +
                             "perl" + QDir::separator () + "lib" );
                env.insert ( "DOCUMENT_ROOT", qApp->applicationDirPath() );
                #ifdef Q_WS_WIN
                    env.insert ( "PATH", env.value ( "Path" ) + ";" +
                                 qApp->applicationDirPath() + QDir::separator () + "scripts" ); //win32
                #endif
                #ifdef Q_OS_LINUX
                    env.insert ( "PATH", env.value ( "PATH" ) + ":" +
                                 qApp->applicationDirPath() + QDir::separator () + "scripts" ); //linux
                #endif
                handler.setProcessEnvironment ( env );
                handler.setWorkingDirectory ( qApp->applicationDirPath() + QDir::separator () + "scripts" );
                handler.setStandardOutputFile ( QDir::tempPath() + QDir::separator () + "output.htm" );
                qDebug() << "TEMP folder:" << QDir::tempPath();
                // call handler and add your input as argument
                handler.start ( interpreter, QStringList() << qApp->applicationDirPath() +
                                QDir::separator () + "scripts" + QDir::separator () +
                                script << fileName << folderName );
            }

            fileName = "";
            folderName = "";

            if ( handler.waitForFinished() ){
                frame->load ( QUrl::fromLocalFile ( QDir::tempPath() + QDir::separator () + "output.htm" ) );
                return true;
            }

            handler.close();
            QWebSettings::clearMemoryCaches();
            return true;
        }
    }

    return QWebPage::acceptNavigationRequest ( frame, request, type );
}
