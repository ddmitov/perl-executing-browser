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

#include <QWebView>
#include <QWebPage>
#include <QWebElement>
#include <QPrintDialog>
#include <QPrinter>


//#include <QApplication>
//#include <QUrl>
//#include <QtWebKit/QWebPage>
//#include <QtWebKit/QWebFrame>
//#include <QtNetwork/QNetworkAccessManager>
//#include <QtNetwork/QNetworkRequest>
//#include <QtNetwork/QNetworkReply>
//#include <QDebug>

//class NAM : public QNetworkAccessManager {

//    Q_OBJECT

//protected:

//    virtual QNetworkReply * createRequest ( Operation op,
//                                            const QNetworkRequest &req,
//                                            QIODevice *outgoingData = 0 ) {
//        qDebug() << "Trying to read POST data...";
//        QByteArray outgoingByteArray = outgoingData -> getSourceData();
//        QString postData ( outgoingByteArray );
//        qDebug() << "POST data" << postData;
//        return QNetworkAccessManager::createRequest ( op, req );
//    }
//};


class Page : public QWebPage
{
    Q_OBJECT

public:
    Page();

protected:
    bool acceptNavigationRequest ( QWebFrame *frame,
                                   const QNetworkRequest &request,
                                   QWebPage::NavigationType type );
};

class TopLevel : public QWebView
{
    Q_OBJECT

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

        qDebug() << "Start page requested from hotkey:" << startPage;
        QString startPageExtension = startPage.section ( ".", 1, 1 );
        qDebug() << "Extension:" << startPageExtension;

        if ( startPageExtension == "pl" ) {
            QProcess handler;
            QProcessEnvironment env = QProcessEnvironment::systemEnvironment();
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
            handler.start ( interpreter, QStringList() << qApp->applicationDirPath() +
                            QDir::separator () + "scripts" + QDir::separator () + startPage );
            // wait until handler has finished
            if ( handler.waitForFinished() ){
                setUrl ( QUrl::fromLocalFile ( QDir::tempPath() + QDir::separator () + "output.htm" ) );
                QWebSettings::clearMemoryCaches();
            }
            handler.close();
        }

        if ( startPageExtension == "htm" or startPageExtension == "html" ) {
            setUrl ( QUrl::fromLocalFile ( qApp->applicationDirPath() + QDir::separator () +
                                           "html" + QDir::separator () + startPage ) );
            QWebSettings::clearMemoryCaches();
        }
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
        QPrintDialog* dialog = new QPrintDialog ( &printer );
        dialog->setWindowFlags ( Qt::WindowStaysOnTopHint );
        QSize dialogSize = dialog->sizeHint();
        QRect screenRect = QDesktopWidget().screen()->rect();
        dialog->move(QPoint(screenRect.width()/2 - dialogSize.width()/2,
                            screenRect.height()/2 - dialogSize.height()/2 ));
        if ( dialog->exec() == QDialog::Accepted )
        {
            TopLevel::print ( &printer );
        }
        dialog->close();
        dialog->deleteLater();
    };

public:
    TopLevel();

private:
    Page *main_page;

};

#endif // PEB_H
