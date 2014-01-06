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
#include <QProcess>
#include <QPrintDialog>
#include <QPrinter>
#include <QDebug>

class NAM : public QNetworkAccessManager {

    Q_OBJECT

protected:

    virtual QNetworkReply * createRequest ( Operation operation,
                                            const QNetworkRequest & request,
                                            QIODevice * outgoingData = 0 ) {

        // POST method form data:
        if ( operation == PostOperation and
             ( QUrl ( "http://perl-executing-browser-pseudodomain/" ) )
             .isParentOf ( request.url() ) ){

            QString postData;
            QByteArray outgoingByteArray;
            if ( outgoingData ){
                outgoingByteArray = outgoingData -> readAll();
                QString postDataRaw ( outgoingByteArray );
                postData = postDataRaw;
                qDebug() << "POST data:" << postData;
            }

            qDebug() << "Form submitted to:" << request.url().toString();
            QString scriptpath = request.url()
                    .toString ( QUrl::RemoveScheme | QUrl::RemoveAuthority | QUrl::RemoveQuery );

            qDebug() << "Script path:" << QDir::toNativeSeparators (
                            QApplication::applicationDirPath() + scriptpath );
            QFile file ( QDir::toNativeSeparators (
                             QApplication::applicationDirPath() + scriptpath ) );
            if( !file.exists() )
            {
                qDebug() << QDir::toNativeSeparators (
                                QApplication::applicationDirPath() + scriptpath ) <<
                            " is missing.";
                qDebug() << "Please restore the missing script.";
                QMessageBox msgBox;
                msgBox.setIcon( QMessageBox::Critical );
                msgBox.setWindowTitle ( "Missing script" );
                msgBox.setText ( QDir::toNativeSeparators (
                                     QApplication::applicationDirPath() + scriptpath ) +
                                 " is missing.<br>Please restore the missing script." );
                msgBox.setDefaultButton( QMessageBox::Ok );
                msgBox.exec();
                QNetworkRequest emptyRequest;
                return QNetworkAccessManager::createRequest (
                            QNetworkAccessManager::GetOperation,
                            emptyRequest );
            }

            QString extension = scriptpath.section(".", 1, 1);
            qDebug() << "Extension:" << extension;
            QString interpreter;

            if ( extension == "pl" ) {
#ifdef Q_OS_WIN
                interpreter = "perl.exe";
#endif
#ifdef Q_OS_LINUX
                interpreter = "perl";
#endif
            }
            if ( extension == "php" ) {
#ifdef Q_OS_WIN
                interpreter = "php-cgi.exe";
#endif
#ifdef Q_OS_LINUX
                interpreter = "php";
#endif
            }
            if ( extension == "py" ) {
#ifdef Q_OS_WIN
                interpreter = "python.exe";
#endif
#ifdef Q_OS_LINUX
                interpreter = "python";
#endif
            }

            if ( extension == "pl" or extension == "php" or extension == "py" ) {
                qDebug() << "Interpreter:" << interpreter;
                QProcess handler;
                QProcessEnvironment env = QProcessEnvironment::systemEnvironment();
                if ( postData.size() > 0 ){
                    env.insert ( "REQUEST_METHOD", "POST" );
                    QString postDataSize = QString::number ( postData.size() );
                    env.insert ( "CONTENT_LENGTH", postDataSize );
                }
                handler.setProcessEnvironment ( env );

                QFileInfo script ( scriptpath );
                QString scriptDirectory = QDir::toNativeSeparators (
                            QApplication::applicationDirPath() +
                            script.absoluteDir().absolutePath () );
                handler.setWorkingDirectory ( scriptDirectory );
                qDebug() << "Working directory:" << scriptDirectory;

                handler.setStandardOutputFile (
                            QDir::toNativeSeparators (
                                QDir::tempPath() +
                                QDir::separator () + "output.htm" ) );
                qDebug() << "TEMP folder:" << QDir::tempPath();
                qDebug() << "===============";
                handler.start ( interpreter, QStringList() <<
                                QDir::toNativeSeparators (
                                    QApplication::applicationDirPath() +
                                    QDir::separator () + scriptpath ) );
                if ( postData.size() > 0 ){
                    handler.write ( outgoingByteArray );
                    handler.closeWriteChannel();
                }

                if ( handler.waitForFinished() ){
                    handler.close();
                    qputenv ( "FILE_TO_OPEN", "" );
                    qputenv ( "FOLDER_TO_OPEN", "" );
                    QWebSettings::clearMemoryCaches();
                    return QNetworkAccessManager::createRequest (
                                QNetworkAccessManager::GetOperation,
                                QNetworkRequest ( QUrl::fromLocalFile (
                                                      QDir::toNativeSeparators (
                                                          QDir::tempPath() +
                                                          QDir::separator() +
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

public slots:

    void sysTrayAbout()
    {
        QSettings settings (
                    QDir::toNativeSeparators (
                        QApplication::applicationDirPath() +
                        QDir::separator () + "peb.ini"), QSettings::IniFormat );
        QString windowIcon = settings.value ( "gui/icon" ).toString();
        QMessageBox msgBox;
        msgBox.setIcon( QMessageBox::Information );
        msgBox.setWindowTitle ( "About" );
        msgBox.setIconPixmap ( QPixmap ( windowIcon ) );
        msgBox.setText ( "Perl Executing Browser v. 0.1,<br>code name Camel Calf" );
        msgBox.setDefaultButton( QMessageBox::Ok );
        msgBox.exec();
    }

public:

    Page();

protected:

    bool acceptNavigationRequest ( QWebFrame * frame,
                                   const QNetworkRequest & request,
                                   QWebPage::NavigationType type );

private:
    QAction * quitAction;
    QAction * aboutAction;
    QAction * aboutQtAction;
    QSystemTrayIcon * trayIcon;
    QMenu * trayIconMenu;

};

class TopLevel : public QWebView
{
    Q_OBJECT

signals:

    void startPageRequested();

public slots:

    void closeAppSlot()
    {
        QFile::remove (
                    QDir::toNativeSeparators (
                        QDir::tempPath() + QDir::separator () + "output.htm" ) );
        QApplication::exit();
    }

    void homeSlot()
    {
        // Reading settings from INI file:
        QSettings settings (
                    QDir::toNativeSeparators (
                        QApplication::applicationDirPath() +
                        QDir::separator () + "peb.ini"), QSettings::IniFormat );
        QString startPagePathName = settings.value ( "gui/start_page" ).toString();
        qDebug() << "Start page:" << QDir::toNativeSeparators (
                        QApplication::applicationDirPath() +
                        QDir::separator () + startPagePathName );
        QString extension = startPagePathName.section ( ".", 1, 1 );
        qDebug() << "Extension:" << extension;
        QString interpreter;

        if ( extension == "pl" ) {
#ifdef Q_OS_WIN
            interpreter = "perl.exe";
#endif
#ifdef Q_OS_LINUX
            interpreter = "perl";
#endif
        }
        if ( extension == "php" ) {
#ifdef Q_OS_WIN
            interpreter = "php-cgi.exe";
#endif
#ifdef Q_OS_LINUX
            interpreter = "php";
#endif
        }
        if ( extension == "py" ) {
#ifdef Q_OS_WIN
            interpreter = "python.exe";
#endif
#ifdef Q_OS_LINUX
            interpreter = "python";
#endif
        }

        if ( extension == "pl" or extension == "php" or extension == "py" ) {
            qDebug() << "Interpreter:" << interpreter;
            QProcess handler;
            QProcessEnvironment env = QProcessEnvironment::systemEnvironment();
            handler.setProcessEnvironment ( env );

            QFileInfo startPage ( startPagePathName );
            QString startPageDirectory = QDir::toNativeSeparators (
                        startPage.absoluteDir().absolutePath () );
            handler.setWorkingDirectory ( startPageDirectory );
            qDebug() << "Working directory:" << startPageDirectory;

            handler.setStandardOutputFile (
                        QDir::toNativeSeparators (
                            QDir::tempPath() +
                            QDir::separator () + "output.htm" ) );
            qDebug() << "TEMP folder:" << QDir::tempPath();
            qDebug() << "===============";
            handler.start ( interpreter, QStringList() <<
                            QDir::toNativeSeparators (
                                QApplication::applicationDirPath() +
                                QDir::separator () + startPagePathName ) );
            // wait until handler has finished
            if ( handler.waitForFinished() ){
                setUrl ( QUrl::fromLocalFile (
                             QDir::toNativeSeparators (
                                 QDir::tempPath() +
                                 QDir::separator () +
                                 "output.htm" ) ) );
            }
            handler.close();
        }

        if ( extension == "htm" or extension == "html" ) {
            setUrl ( QUrl::fromLocalFile (
                         QDir::toNativeSeparators (
                             QApplication::applicationDirPath() +
                             QDir::separator () + startPagePathName ) ) );
            qDebug() << "===============";
        }
        QWebSettings::clearMemoryCaches();
    }

    void maximizeSlot()
    {
        showMaximized();
    }

    void minimizeSlot()
    {
        showMinimized();
    }

    void toggleFullScreenSlot()
    {
        if (isFullScreen()){
            showMaximized();
        }
        else{
            showFullScreen();
        }
    };

    void pageLoadedDynamicTitle ( bool ok )
    {
        if ( ok )
        {
            setWindowTitle ( TopLevel::title() );
            QFile::remove (
                        QDir::toNativeSeparators (
                            QDir::tempPath() + QDir::separator () + "output.htm" ) );
        }
    }

    void pageLoadedStaticTitle ( bool ok )
    {
        if ( ok )
        {
            QFile::remove (
                        QDir::toNativeSeparators (
                            QDir::tempPath() + QDir::separator () + "output.htm" ) );
        }
    }

    void contextMenuEvent ( QContextMenuEvent * event )
    {
        // Reading settings from INI file:
        QSettings settings (
                    QDir::toNativeSeparators (
                        QApplication::applicationDirPath() +
                        QDir::separator () + "peb.ini" ), QSettings::IniFormat );
        QString windowSize = settings.value ( "gui/window_size" ).toString();
        QString framelessWindow = settings.value ( "gui/frameless_window" ).toString();
        QMenu * menu = main_page -> createStandardContextMenu();
        menu -> addSeparator();
        if ( windowSize == "maximized" or windowSize == "fullscreen" ) {
            if ( framelessWindow == "no" ) {
                QAction * maximizeAct = menu -> addAction ( "&Maximize" );
                connect ( maximizeAct, SIGNAL ( triggered() ),
                          this, SLOT ( maximizeSlot() ) );
            }
            QAction * toggleFullScreenAct = menu -> addAction ( "Toggle &Fullscreen" );
            connect ( toggleFullScreenAct, SIGNAL ( triggered() ),
                      this, SLOT ( toggleFullScreenSlot() ) );
        }
        if ( framelessWindow == "no" ) {
            QAction * minimizeAct = menu -> addAction ( "Mi&nimize" );
            connect ( minimizeAct, SIGNAL ( triggered() ),
                      this, SLOT ( minimizeSlot() ) );
        }
        QAction * homeAct = menu -> addAction ( "&Home" );
        connect ( homeAct, SIGNAL ( triggered() ),
                  this, SLOT ( homeSlot() ) );
        QAction * printAct = menu -> addAction ( "&Print" );
        connect ( printAct, SIGNAL ( triggered() ),
                  this, SLOT ( printPageSlot() ) );
        QAction * closeAct = menu -> addAction ( "&Quit" );
        connect ( closeAct, SIGNAL ( triggered() ),
                  this, SLOT ( closeAppSlot() ) );
        menu -> addSeparator();
        QAction * aboutAction = menu -> addAction ( "&About" );
        connect ( aboutAction, SIGNAL ( triggered() ),
                  this, SLOT ( sysTrayAbout() ) );
        QAction * aboutQtAction = menu -> addAction ( "About Q&t" );
        connect ( aboutQtAction, SIGNAL ( triggered() ),
                  qApp, SLOT ( aboutQt() ) );

        menu -> exec ( event -> globalPos() );
    }

    void printPageSlot()
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
        QSize dialogSize = dialog -> sizeHint();
        QRect screenRect = QDesktopWidget().screen()->rect();
        dialog -> move ( QPoint ( screenRect.width() / 2 - dialogSize.width() / 2,
                                  screenRect.height() / 2 - dialogSize.height() / 2 ) );
        if ( dialog -> exec() == QDialog::Accepted )
        {
            TopLevel::print ( & printer );
        }
        dialog -> close();
        dialog -> deleteLater();
    }

    void sysTrayAbout()
    {
        QSettings settings (
                    QDir::toNativeSeparators (
                        QApplication::applicationDirPath() +
                        QDir::separator () + "peb.ini"), QSettings::IniFormat );
        QString windowIcon = settings.value ( "gui/icon" ).toString();
        QMessageBox msgBox;
        msgBox.setIcon( QMessageBox::Information );
        msgBox.setWindowTitle ( "About" );
        msgBox.setIconPixmap ( QPixmap ( windowIcon ) );
        msgBox.setText ( "Perl Executing Browser v. 0.1,<br>code name Camel Calf" );
        msgBox.setDefaultButton( QMessageBox::Ok );
        msgBox.exec();
    }

public:

    TopLevel();

private:

    Page *main_page;

};

#endif // PEB_H
