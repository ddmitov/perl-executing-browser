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
        QFile::remove ( QDir::tempPath() + "/output.htm" );
        qApp->exit();
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

    void pageLoadedDynamicTitle (bool ok)
    {
        if(ok)
        {
            setWindowTitle ( TopLevel::title() );
            QFile::remove ( QDir::tempPath() + "/output.htm" );
        }
    }

    void pageLoadedStaticTitle (bool ok)
    {
        if(ok)
        {
            QFile::remove ( QDir::tempPath() + "/output.htm" );
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
        //        printer.setPrinterName ( "Print to File (PDF)" );
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
