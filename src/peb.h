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
        if ( operation == PostOperation ){

            QString postData;
            QByteArray outgoingByteArray;
            if ( outgoingData ){
                outgoingByteArray = outgoingData -> readAll();
                QString postDataRaw ( outgoingByteArray );
                postData = postDataRaw;
                qDebug() << "POST data:" << postData;
            }

            QUrl allowedBase = ( QUrl ( "http://perl-executing-browser-pseudodomain/" ) );
            if ( allowedBase.isParentOf ( request.url() ) ) {
                qDebug() << "Form submitted to:" << request.url().toString();
                QString script = request.url()
                        .toString ( QUrl::RemoveScheme | QUrl::RemoveAuthority | QUrl::RemoveQuery )
                        .replace ( "/", "" );
                qDebug() << "Script:" << script;
                QString extension = script.section(".", 1, 1);
                qDebug() << "Extension:" << extension;
                QString interpreter;
                if ( extension == "pl" ) {
                    interpreter = "perl";
                }
                if ( extension == "php" ) {
                    interpreter = "php-cgi";
                }
                if ( extension == "py" ) {
                    interpreter = "python";
                }
                qDebug() << "Interpreter:" << interpreter;

                if ( extension == "pl" or extension == "php" or extension == "py" ) {
                    QProcess handler;
                    QProcessEnvironment env = QProcessEnvironment::systemEnvironment();
                    if ( postData.size() > 0 ){
                        env.insert ( "REQUEST_METHOD", "POST" );
                        QString postDataSize = QString::number ( postData.size() );
                        env.insert ( "CONTENT_LENGTH", postDataSize );
                    }
//#ifdef Q_WS_WIN
//                    env.insert ( "PATH", env.value ( "Path" ) + ";" +
//                                 qApp->applicationDirPath() +
//                                 QDir::separator () + "scripts" ); //win32
//#endif
//#ifdef Q_OS_LINUX
//                    env.insert ( "PATH", env.value ( "PATH" ) + ":" +
//                                 qApp->applicationDirPath() +
//                                 QDir::separator () + "scripts" ); //linux
//#endif
                    handler.setProcessEnvironment ( env );
                    handler.setWorkingDirectory ( qApp->applicationDirPath() +
                                                  QDir::separator () + "scripts" );
                    handler.setStandardOutputFile ( QDir::tempPath() +
                                                    QDir::separator () + "output.htm" );
                    qDebug() << "TEMP folder:" << QDir::tempPath();
                    qDebug() << "===============";
                    handler.start ( interpreter, QStringList() << qApp->applicationDirPath() +
                                    QDir::separator () + "scripts" + QDir::separator () +
                                    script );
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
                                    QNetworkRequest ( QUrl::fromLocalFile ( QDir::tempPath() +
                                                                            QDir::separator() +
                                                                            "output.htm" ) ) );
                    }

                }
            }

        }

        return QNetworkAccessManager::createRequest ( operation, request );
    }
};

class Page : public QWebPage
{
    Q_OBJECT

public:

    Page();

protected:

    bool acceptNavigationRequest ( QWebFrame * frame,
                                   const QNetworkRequest & request,
                                   QWebPage::NavigationType type );
};

class TopLevel : public QWebView
{
    Q_OBJECT

signals:
    void startPageRequested();

public slots:

    void closeAppSlot()
    {
        QFile::remove ( QDir::tempPath() + QDir::separator () + "output.htm" );
        qApp->exit();
    };

    void homeSlot()
    {
        // Reading settings from INI file:
        QSettings settings ( QApplication::applicationDirPath() +
                             QDir::separator () + "peb.ini", QSettings::NativeFormat );
        QString startPage = settings.value ( "gui/start_page" ).toString();

        qDebug() << "Start page:" << startPage;
        QString startPageExtension = startPage.section ( ".", 1, 1 );
        qDebug() << "Extension:" << startPageExtension;
        QString interpreter;
        if ( startPageExtension == "pl" ) {
            interpreter = "perl";
        }
        if ( startPageExtension == "php" ) {
            interpreter = "php-cgi";
        }
        if ( startPageExtension == "py" ) {
            interpreter = "python";
        }
        qDebug() << "Interpreter:" << interpreter;

        if ( startPageExtension == "pl" or
             startPageExtension == "php" or
             startPageExtension == "py" ) {
            QProcess handler;
            QProcessEnvironment env = QProcessEnvironment::systemEnvironment();
            handler.setProcessEnvironment ( env );
            handler.setWorkingDirectory ( qApp->applicationDirPath() +
                                          QDir::separator () + "scripts" );
            handler.setStandardOutputFile ( QDir::tempPath() +
                                            QDir::separator () + "output.htm" );
            qDebug() << "TEMP folder:" << QDir::tempPath();
            qDebug() << "===============";
            handler.start ( interpreter, QStringList() << qApp->applicationDirPath() +
                            QDir::separator () + "scripts" + QDir::separator () + startPage );
            // wait until handler has finished
            if ( handler.waitForFinished() ){
                setUrl ( QUrl::fromLocalFile ( QDir::tempPath() +
                                               QDir::separator () +
                                               "output.htm" ) );
            }
            handler.close();
        }

        if ( startPageExtension == "htm" or startPageExtension == "html" ) {
            setUrl ( QUrl::fromLocalFile ( qApp->applicationDirPath() +
                                           QDir::separator () +
                                           "html" + QDir::separator ()
                                           + startPage ) );
            qDebug() << "===============";
        }
        QWebSettings::clearMemoryCaches();
    };

    void maximizeSlot()
    {
        showMaximized();
    };

    void minimizeSlot()
    {
        showMinimized();
    };

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
            QFile::remove ( QDir::tempPath() + QDir::separator () + "output.htm" );
        }
    }

    void pageLoadedStaticTitle ( bool ok )
    {
        if ( ok )
        {
            QFile::remove ( QDir::tempPath() + QDir::separator () + "output.htm" );
        }
    }

    void contextMenuEvent ( QContextMenuEvent* event )
    {
        QMenu *menu = main_page -> createStandardContextMenu();
        menu -> addSeparator();
        QAction* minimizeAct = menu -> addAction ( "Minimize" );
        connect ( minimizeAct, SIGNAL ( triggered() ), this, SLOT ( minimizeSlot() ) );
        QAction* maximizeAct = menu->addAction ( "Maximize" );
        connect ( maximizeAct, SIGNAL ( triggered() ), this, SLOT ( maximizeSlot() ) );
        QAction* toggleFullScreenAct = menu -> addAction ( "Toggle Fullscreen" );
        connect ( toggleFullScreenAct, SIGNAL ( triggered() ), this, SLOT ( toggleFullScreenSlot() ) );
        QAction* homeAct = menu -> addAction ( "Home" );
        connect ( homeAct, SIGNAL ( triggered() ), this, SLOT ( homeSlot() ) );
        QAction* printAct = menu -> addAction ( "Print" );
        connect ( printAct, SIGNAL ( triggered() ), this, SLOT ( printPageSlot() ) );
        QAction* closeAct = menu -> addAction ( "Close" );
        connect ( closeAct, SIGNAL ( triggered() ), this, SLOT ( closeAppSlot() ) );
        menu -> exec ( QPoint ( event -> x(), event -> y() ) );
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
        QPrintDialog* dialog = new QPrintDialog ( & printer );
        dialog -> setWindowFlags ( Qt::WindowStaysOnTopHint );
        QSize dialogSize = dialog->sizeHint();
        QRect screenRect = QDesktopWidget().screen()->rect();
        dialog -> move(QPoint ( screenRect.width() / 2 - dialogSize.width() / 2,
                            screenRect.height() / 2 - dialogSize.height() / 2 ) );
        if ( dialog->exec() == QDialog::Accepted )
        {
            TopLevel::print ( & printer );
        }
        dialog -> close();
        dialog -> deleteLater();
    };

public:

    TopLevel();

private:

    Page *main_page;

};

#endif // PEB_H
