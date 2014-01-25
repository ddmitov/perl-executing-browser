#ifndef PEB_H
#define PEB_H

#include <qglobal.h>
#if QT_VERSION >= 0x050000
    // Qt5 code:
    #include <QtWidgets>
#else
    // Qt4 code:
    #include <QtGui>
    #include <QApplication>
#endif

#include <QUrl>
#include <QWebPage>
#include <QWebView>
#include <QWebFrame>
#include <QWebElement>
#include <QtNetwork/QNetworkAccessManager>
#include <QtNetwork/QNetworkRequest>
#include <QtNetwork/QNetworkReply>
#include <QtNetwork/QTcpSocket>
#include <QProcess>
#include <QPrintDialog>
#include <QPrinter>
#include <QSystemTrayIcon>
#include <QDebug>

class Settings : public QSettings
{
    Q_OBJECT

public:

    Settings ();

    QString settingsFileName;
    QString startPage;
    QString icon;
    QString iconPathName;
    QString windowSize;
    QString framelessWindow;
    QString stayOnTop;
    QString browserTitle;
    QString contextMenu;

};

class Watchdog : public QSystemTrayIcon
{

    Q_OBJECT

public slots:

    void pingSlot ()
    {
        QTcpSocket localWebServerPing;
        localWebServerPing.connectToHost ( "127.0.0.1", 8080 );
        QTcpSocket webConnectivityPing;
        webConnectivityPing.connectToHost ( "www.google.com", 80 );

        if ( localWebServerPing.waitForConnected ( 1000 ) )
        {
            qDebug () << "Local web server is running.";
        } else {
            qDebug () << "Local web server is not running. Will try to restart it.";
            QProcess server;
            server.startDetached ( QString ( QApplication::applicationDirPath () +
                                             QDir::separator () + "mongoose" ) );
        }
        if ( webConnectivityPing.waitForConnected ( 1000 ) )
        {
            qDebug () << "Web connection is available.";
            qDebug () << "===============";
        } else {
            qDebug () << "Web connection is not available.";
            qDebug () << "===============";
        }
    }

public:

    Watchdog ();

    QAction * quitAction;
    QAction * aboutAction;
    QAction * aboutQtAction;

private:

    Settings settings;
    QSystemTrayIcon * trayIcon;
    QMenu * trayIconMenu;

};

class ModifiedNetworkAccessManager : public QNetworkAccessManager
{

    Q_OBJECT

protected:

    virtual QNetworkReply * createRequest ( Operation operation,
                                            const QNetworkRequest & request,
                                            QIODevice * outgoingData = 0 )
    {
        // POST method form data:
        if ( operation == PostOperation and
             ( QUrl ( "http://perl-executing-browser-pseudodomain/" ) )
             .isParentOf ( request.url () ) )
        {
            QString postData;
            QByteArray outgoingByteArray;
            if ( outgoingData )
            {
                outgoingByteArray = outgoingData -> readAll ();
                QString postDataRaw ( outgoingByteArray );
                postData = postDataRaw;
                qDebug () << "POST data:" << postData;
            }

            qDebug () << "Form submitted to:" << request.url () .toString ();
            QString scriptpath = request.url ()
                    .toString ( QUrl::RemoveScheme | QUrl::RemoveAuthority | QUrl::RemoveQuery );

            qDebug () << "Script path:" << QDir::toNativeSeparators (
                            QApplication::applicationDirPath () + scriptpath );
            QFile file ( QDir::toNativeSeparators (
                             QApplication::applicationDirPath () + scriptpath ) );
            if ( ! file.exists () )
            {
                qDebug () << QDir::toNativeSeparators (
                                QApplication::applicationDirPath () + scriptpath ) <<
                            " is missing.";
                qDebug () << "Please restore the missing script.";
                QMessageBox msgBox;
                msgBox.setIcon ( QMessageBox::Critical );
                msgBox.setWindowTitle ( "Missing script" );
                msgBox.setText ( QDir::toNativeSeparators (
                                     QApplication::applicationDirPath () + scriptpath ) +
                                 " is missing.<br>Please restore the missing script." );
                msgBox.setDefaultButton ( QMessageBox::Ok );
                msgBox.exec ();
                QNetworkRequest emptyRequest;
                return QNetworkAccessManager::createRequest (
                            QNetworkAccessManager::GetOperation,
                            emptyRequest );
            }

            QString extension = scriptpath.section (".", 1, 1);
            qDebug () << "Extension:" << extension;
            QString interpreter;

            if ( extension == "pl" )
            {
#ifdef Q_OS_WIN
                interpreter = "perl.exe";
#endif
#ifdef Q_OS_LINUX
                interpreter = "perl";
#endif
            }
            if ( extension == "php" )
            {
#ifdef Q_OS_WIN
                interpreter = "php-cgi.exe";
#endif
#ifdef Q_OS_LINUX
                interpreter = "php";
#endif
            }
            if ( extension == "py" )
            {
#ifdef Q_OS_WIN
                interpreter = "python.exe";
#endif
#ifdef Q_OS_LINUX
                interpreter = "python";
#endif
            }

            if ( extension == "pl" or extension == "php" or extension == "py" )
            {
                qDebug () << "Interpreter:" << interpreter;
                QProcess handler;
                QProcessEnvironment env = QProcessEnvironment::systemEnvironment ();
                if ( postData.size () > 0 )
                {
                    env.insert ( "REQUEST_METHOD", "POST" );
                    QString postDataSize = QString::number ( postData.size () );
                    env.insert ( "CONTENT_LENGTH", postDataSize );
                }
                handler.setProcessEnvironment ( env );

                QFileInfo script ( scriptpath );
                QString scriptDirectory = QDir::toNativeSeparators (
                            QApplication::applicationDirPath () +
                            script.absoluteDir () .absolutePath () );
                handler.setWorkingDirectory ( scriptDirectory );
                qDebug () << "Working directory:" << scriptDirectory;

                handler.setStandardOutputFile (
                            QDir::toNativeSeparators (
                                QDir::tempPath () +
                                QDir::separator () + "output.htm" ) );
                qDebug () << "TEMP folder:" << QDir::tempPath ();
                qDebug () << "===============";
                handler.start ( interpreter, QStringList () <<
                                QDir::toNativeSeparators (
                                    QApplication::applicationDirPath () +
                                    QDir::separator () + scriptpath ) );
                if ( postData.size () > 0 )
                {
                    handler.write ( outgoingByteArray );
                    handler.closeWriteChannel ();
                }

                if ( handler.waitForFinished () )
                {
                    handler.close ();
                    qputenv ( "FILE_TO_OPEN", "" );
                    qputenv ( "FOLDER_TO_OPEN", "" );
                    QWebSettings::clearMemoryCaches ();
                    return QNetworkAccessManager::createRequest (
                                QNetworkAccessManager::GetOperation,
                                QNetworkRequest ( QUrl::fromLocalFile (
                                                      QDir::toNativeSeparators (
                                                          QDir::tempPath () +
                                                          QDir::separator () +
                                                          "output.htm" ) ) ) );
                }
            }
        }

        return QNetworkAccessManager::createRequest ( operation, request );
    }

};

class Page : public QWebPage
{
    Q_OBJECT

signals:

    void quitFromURLSignal ();

    void closeWindowSignal ();

public slots:

    void checkFileExistenceSlot ()
    {
        QFile file ( QDir::toNativeSeparators (
                         QApplication::applicationDirPath () + filepath ) );
        if ( ! file.exists () )
        {
            qDebug () << QDir::toNativeSeparators (
                             QApplication::applicationDirPath () + filepath ) <<
                         "is missing.";
            qDebug () << "Please restore the missing file.";
            QMessageBox msgBox;
            msgBox.setIcon ( QMessageBox::Critical );
            msgBox.setWindowTitle ( "Missing file" );
            msgBox.setText ( QDir::toNativeSeparators (
                                 QApplication::applicationDirPath () + filepath ) +
                             " is missing.<br>Please restore the missing file." );
            msgBox.setDefaultButton ( QMessageBox::Ok );
            msgBox.exec();
        }
    }

    void defineInterpreterSlot ()
    {
        if ( extension == "pl" )
        {
#ifdef Q_OS_WIN
            interpreter = "perl.exe";
#endif
#ifdef Q_OS_LINUX
            interpreter = "perl";
#endif
        }
        if ( extension == "php" )
        {
#ifdef Q_OS_WIN
            interpreter = "php-cgi.exe";
#endif
#ifdef Q_OS_LINUX
            interpreter = "php";
#endif
        }
        if ( extension == "py" )
        {
#ifdef Q_OS_WIN
            interpreter = "python.exe";
#endif
#ifdef Q_OS_LINUX
            interpreter = "python";
#endif
        }
    }

    void displayLongRunningScriptOutputSlot ()
    {
        QString output = longRunningScriptHandler.readAllStandardOutput ();
        QString filepathForConversion = lastRequest.url () .path ();
        QString extension = filepathForConversion.section ( ".", 1, 1 );
        QString longRunningScriptOutputFilePath = QDir::toNativeSeparators (
                    QDir::tempPath () + QDir::separator () + filepathForConversion
                    .replace ( QDir::separator (), "_" )
                    .replace ( QRegExp ( "(\\s+)" ), "_" )
                    .replace ( "." + extension, "" ) +
                    "_output.htm" );
        QFile longRunningScriptOutputFile ( longRunningScriptOutputFilePath );
        if ( longRunningScriptOutputFile.exists () )
        {
            longRunningScriptOutputFile.remove ();
        }
        if ( longRunningScriptOutputFile.open ( QIODevice::ReadWrite ) )
        {
            QTextStream stream ( & longRunningScriptOutputFile );
            stream << output << endl;
        }
        qDebug () << "Output from long-running script received.";
        qDebug () << "Long-running script output file:" << longRunningScriptOutputFilePath;
        qDebug () << "===============";
        if ( longRunningScriptOutputInNewWindow == false )
        {
            Page::currentFrame() -> setUrl (
                        QUrl::fromLocalFile ( longRunningScriptOutputFilePath ) );
        }
        if ( longRunningScriptOutputInNewWindow == true )
        {
            newLongRunWindow -> setUrl ( QUrl::fromLocalFile ( longRunningScriptOutputFilePath ) );
            newLongRunWindow -> show ();
        }
        longRunningScriptOutputFile.remove ();
    }

    void longRunningScriptFinishedSlot ()
    {
        qDebug () << "Long-running script finished.";
        qDebug () << "===============";
        longRunningScriptHandler.close ();
    }

    void displayLongRunningScriptErrorSlot ()
    {
        QString error = longRunningScriptHandler.readAllStandardError ();
        qDebug () << "Long-running script error:" << error;
        qDebug () << "===============";
    }

public:

    Page ();

protected:

    bool acceptNavigationRequest ( QWebFrame * frame,
                                   const QNetworkRequest & request,
                                   QWebPage::NavigationType type );

private:

    QString userAgentForUrl ( const QUrl & url ) const
    {
        Q_UNUSED ( url );
        return "PerlExecutingBrowser/0.1 AppleWebKit/535.2 (KHTML, like Gecko)";
    }

    Settings settings;

    QString filepath;
    QString extension;
    QString interpreter;

    QProcess longRunningScriptHandler;
    QNetworkRequest lastRequest;
    bool longRunningScriptOutputInNewWindow;
    QWebView * newLongRunWindow;

    QWebView * newWindow;

    QString fileNameToOpenString;
    QString folderNameToOpenString;
    QString externalApplication;
    QString allowedWebLink;
    QString externalWebLink;
    QString defaultApplicationFile;

};

class TopLevel : public QWebView
{
    Q_OBJECT

public slots:

    void loadStartPageSlot ()
    {
        QString startPageFilePath;
        startPageFilePath = QDir::toNativeSeparators (
                    QApplication::applicationDirPath () +
                    QDir::separator () + settings.startPage );
        qDebug () << "Start page:" << startPageFilePath;

        QString extension = startPageFilePath.section ( ".", 1, 1 );
        qDebug () << "Extension:" << extension;
        QString interpreter;
        if ( extension == "pl" )
        {
#ifdef Q_OS_WIN
            interpreter = "perl.exe";
#endif
#ifdef Q_OS_LINUX
            interpreter = "perl";
#endif
        }
        if ( extension == "php" )
        {
#ifdef Q_OS_WIN
            interpreter = "php-cgi.exe";
#endif
#ifdef Q_OS_LINUX
            interpreter = "php";
#endif
        }
        if ( extension == "py" )
        {
#ifdef Q_OS_WIN
            interpreter = "python.exe";
#endif
#ifdef Q_OS_LINUX
            interpreter = "python";
#endif
        }

        if ( extension == "pl" or extension == "php" or extension == "py" )
        {
            qDebug () << "Interpreter:" << interpreter;
            QProcess handler;
            QProcessEnvironment env = QProcessEnvironment::systemEnvironment ();
            handler.setProcessEnvironment ( env );

            QFileInfo initialViewFile ( startPageFilePath );
            QString initialViewFileDirectory = QDir::toNativeSeparators (
                        initialViewFile.absoluteDir () .absolutePath () );
            handler.setWorkingDirectory ( initialViewFileDirectory );
            qDebug () << "Working directory:" << initialViewFileDirectory;

            handler.setStandardOutputFile (
                        QDir::toNativeSeparators (
                            QDir::tempPath () +
                            QDir::separator () + "output.htm" ) );
            qDebug () << "TEMP folder:" << QDir::tempPath();
            qDebug () << "===============";
            handler.start ( interpreter, QStringList () << startPageFilePath );
            // wait until handler has finished
            if ( handler.waitForFinished () )
            {
                setUrl ( QUrl::fromLocalFile (
                             QDir::toNativeSeparators (
                                 QDir::tempPath () +
                                 QDir::separator () +
                                 "output.htm" ) ) );
            }
            handler.close ();
        }

        if ( extension == "htm" or extension == "html" )
        {
            setUrl ( QUrl::fromLocalFile ( startPageFilePath ) );
            qDebug () << "===============";
        }
        QWebSettings::clearMemoryCaches ();
    }

    void pageLoadedDynamicTitleSlot ( bool ok )
    {
        if ( ok )
        {
            setWindowTitle ( TopLevel::title () );
            QFile::remove (
                        QDir::toNativeSeparators (
                            QDir::tempPath () + QDir::separator () + "output.htm" ) );
        }
    }

    void pageLoadedStaticTitleSlot ( bool ok )
    {
        if ( ok )
        {
            QFile::remove (
                        QDir::toNativeSeparators (
                            QDir::tempPath () + QDir::separator () + "output.htm" ) );
        }
    }

    void printPageSlot ()
    {
        QPrinter printer;
        printer.setOrientation ( QPrinter::Portrait );
        printer.setPageSize ( QPrinter::A4 );
        printer.setPageMargins ( 10, 10, 10, 10, QPrinter::Millimeter );
        printer.setResolution ( QPrinter::HighResolution );
        printer.setColorMode ( QPrinter::Color );
        printer.setPrintRange ( QPrinter::AllPages );
        printer.setNumCopies ( 1 );
        //        printer.setOutputFormat ( QPrinter::PdfFormat );
        //        printer.setOutputFileName ( "output.pdf" );
        QPrintDialog * dialog = new QPrintDialog ( & printer );
        dialog -> setWindowFlags ( Qt::WindowStaysOnTopHint );
        QSize dialogSize = dialog -> sizeHint ();
        QRect screenRect = QDesktopWidget () .screen () -> rect();
        dialog -> move ( QPoint ( screenRect.width () / 2 - dialogSize.width () / 2,
                                  screenRect.height () / 2 - dialogSize.height () / 2 ) );
        if ( dialog -> exec () == QDialog::Accepted )
        {
            TopLevel::print ( & printer );
        }
        dialog -> close ();
        dialog -> deleteLater ();
    }

    void contextMenuEvent ( QContextMenuEvent * event )
    {
        QMenu * menu = mainPage -> createStandardContextMenu ();
        menu -> addSeparator ();
        if ( settings.windowSize == "maximized" or settings.windowSize == "fullscreen" )
        {
            if ( settings.framelessWindow == "no" )
            {
                QAction * maximizeAct = menu -> addAction ( tr ( "&Maximize" ) );
                QObject::connect ( maximizeAct, SIGNAL ( triggered () ),
                          this, SLOT ( maximizeSlot () ) );
            }
            QAction * toggleFullScreenAct = menu -> addAction ( tr ( "Toggle &Fullscreen" ) );
            QObject::connect ( toggleFullScreenAct, SIGNAL ( triggered () ),
                      this, SLOT ( toggleFullScreenSlot () ) );
        }
        if ( settings.framelessWindow == "no" )
        {
            QAction * minimizeAct = menu -> addAction ( tr ( "Mi&nimize" ) );
            QObject::connect ( minimizeAct, SIGNAL ( triggered () ),
                      this, SLOT ( minimizeSlot () ) );
        }
        if ( ! TopLevel::url () .toString () .contains ( "longrun" ) )
        {
            QAction * homeAct = menu -> addAction ( tr ( "&Home" ) );
            QObject::connect ( homeAct, SIGNAL ( triggered () ),
                      this, SLOT ( loadStartPageSlot () ) );
        }
        QAction * printAct = menu -> addAction ( tr ( "&Print" ) );
        QObject::connect ( printAct, SIGNAL ( triggered () ),
                  this, SLOT ( printPageSlot() ) );
        QAction * closeWindowAct = menu -> addAction ( tr ( "&Close window" ) );
        QObject::connect ( closeWindowAct, SIGNAL ( triggered () ),
                  this, SLOT ( close () ) );
        if ( ! TopLevel::url () .toString () .contains ( "longrun" ) )
        {
            QAction * quitAct = menu -> addAction ( tr ( "&Quit" ) );
            QObject::connect ( quitAct, SIGNAL ( triggered () ),
                      this, SLOT ( quitApplicationSlot () ) );
        }
        menu -> addSeparator();
        QAction * aboutAction = menu -> addAction ( tr ( "&About" ) );
        QObject::connect ( aboutAction, SIGNAL ( triggered () ),
                  this, SLOT ( aboutSlot () ) );
        QAction * aboutQtAction = menu -> addAction ( tr ( "About Q&t" ) );
        QObject::connect ( aboutQtAction, SIGNAL ( triggered () ),
                  qApp, SLOT ( aboutQt () ) );
        menu -> exec ( event -> globalPos () );
    }

    void maximizeSlot ()
    {
        raise ();
        showMaximized ();
    }

    void minimizeSlot ()
    {
        showMinimized ();
    }

    void toggleFullScreenSlot ()
    {
        if ( isFullScreen () )
        {
            showMaximized ();
        } else {
            showFullScreen ();
        }
    }

    void aboutSlot ()
    {
        QString qtVersion = QT_VERSION_STR;
        QString qtWebKitVersion = QTWEBKIT_VERSION_STR;
        QMessageBox msgBox;
        msgBox.setWindowTitle ( "About" );
        msgBox.setIconPixmap ( QPixmap ( settings.iconPathName ) );
        msgBox.setText ( "Perl Executing Browser, version 0.1, code name Camel Calf<br>"
                         "<a href='https://github.com/ddmitov/perl-executing-browser'>"
                         "https://github.com/ddmitov/perl-executing-browser</a><br>"
                         "Qt WebKit version: " + qtWebKitVersion + ", "
                         "Qt version: " + qtVersion );
        msgBox.setDefaultButton ( QMessageBox::Ok );
        msgBox.exec ();
    }

    void quitApplicationSlot ()
    {
        QFile::remove (
                    QDir::toNativeSeparators (
                        QDir::tempPath () + QDir::separator () + "output.htm" ) );
        setUrl ( QUrl ( "http://localhost:8080/close" ) );
        QApplication::exit();
    }

public:

    TopLevel ();

//    // http://qt-project.org/forums/viewthread/17635
//    // http://www.qtcentre.org/threads/52787
//    QWebView * createWindow ( QWebPage::WebWindowType type )
//    {
//        Q_UNUSED ( type );

//        QWebView * newWindow = new TopLevel;
//        newWindow -> setAttribute ( Qt::WA_DeleteOnClose, true );
//        newWindow -> show ();
//        return newWindow;
//    }

private:

    Page * mainPage;

    Settings settings;

};

#endif // PEB_H
