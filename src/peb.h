#ifndef PEB_H
#define PEB_H

#include <qwebview.h>
#include <qwebpage.h>
#include <QtGui>
#include <QApplication>

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

    void reloadSlot()
    {
        reload();
    };

    void backSlot()
    {
        back();
    };

    void forwardSlot()
    {
        forward();
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

    void changeTitle(bool ok)
    {
        if(ok)
        {
        setWindowTitle ( TopLevel::title() );
        }
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
