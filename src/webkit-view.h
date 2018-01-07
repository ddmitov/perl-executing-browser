/*
 Perl Executing Browser

 This program is free software;
 you can redistribute it and/or modify it under the terms of the
 GNU Lesser General Public License,
 as published by the Free Software Foundation;
 either version 3 of the License, or (at your option) any later version.
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY;
 without even the implied warranty of MERCHANTABILITY or
 FITNESS FOR A PARTICULAR PURPOSE.
 Dimitar D. Mitov, 2013 - 2018
 Valcho Nedelchev, 2014 - 2016
 https://github.com/ddmitov/perl-executing-browser
*/

#ifndef VIEW_H
#define VIEW_H

#include <QContextMenuEvent>
#include <QDesktopWidget>
#include <QMenu>
#include <QWebInspector>
#include <QWebView>

#include "webkit-page.h"

#ifndef QT_NO_PRINTER
#include <QPrintPreviewDialog>
#include <QtPrintSupport/QPrinter>
#include <QtPrintSupport/QPrintDialog>
#endif

// ==============================
// VIEW CLASS DEFINITION:
// (QTWEBKIT VERSION)
// ==============================
class QViewWidget : public QWebView
{
    Q_OBJECT

signals:
    void startWindowClosingSignal();

public slots:
    // ==============================
    // Actions taken after page is loaded:
    // ==============================
    void qPageLoadedSlot()
    {
        setWindowTitle(QViewWidget::title());
    }

    // ==============================
    // Context menu:
    // ==============================
    void contextMenuEvent(QContextMenuEvent *event)
    {
        if (mainPage->mainFrame()->url().scheme() != "file" and
                mainPage->mainFrame()->url().host() != "localhost") {
            page()->action(QWebPage::CopyImageToClipboard)->setVisible(false);
            page()->action(QWebPage::DownloadImageToDisk)->setVisible(false);
            page()->action(QWebPage::DownloadLinkToDisk)->setVisible(false);
            page()->action(QWebPage::OpenFrameInNewWindow)->setVisible(false);
            page()->action(QWebPage::OpenImageInNewWindow)->setVisible(false);
            page()->action(QWebPage::OpenLinkInNewWindow)->setVisible(false);
            page()->action(QWebPage::OpenLinkInThisWindow)->setVisible(false);
            page()->action(QWebPage::OpenLink)->setVisible(false);

            QMenu *menu = QWebView::page()->createStandardContextMenu();
            menu->popup(event->globalPos());
        }

        if (mainPage->mainFrame()->url().scheme() == "file" or
                mainPage->mainFrame()->url().host() == "localhost") {
            QWebHitTestResult contextMenuTest =
                    mainPage->mainFrame()->hitTestContent(event->pos());

            QMenu menu;

            if (!contextMenuTest.isContentEditable()) {
                if (!contextMenuTest.isContentSelected()) {
                    QAction *selectAllAct =
                            menu.addAction(
                                qApp->property("selectAllLabel").toString());
                    QObject::connect(selectAllAct, SIGNAL(triggered()),
                                     this, SLOT(qSelectAllAction()));
                }

                if (contextMenuTest.isContentSelected()) {
                    QAction *copyAct =
                            menu.addAction(
                                qApp->property("copyLabel").toString());
                    QObject::connect(copyAct, SIGNAL(triggered()),
                                     this, SLOT(qCopyAction()));
                }
            }

            if (contextMenuTest.isContentEditable()) {
                QAction *cutAct =
                        menu.addAction(
                            qApp->property("cutLabel").toString());
                QObject::connect(cutAct, SIGNAL(triggered()),
                                 this, SLOT(qCutAction()));

                QAction *copyAct =
                        menu.addAction(
                            qApp->property("copyLabel").toString());
                QObject::connect(copyAct, SIGNAL(triggered()),
                                 this, SLOT(qCopyAction()));

                QAction *pasteAct =
                        menu.addAction(
                            qApp->property("pasteLabel").toString());
                QObject::connect(pasteAct, SIGNAL(triggered()),
                                 this, SLOT(qPasteAction()));

                QAction *selectAllAct =
                        menu.addAction(
                            qApp->property("selectAllLabel").toString());
                QObject::connect(selectAllAct, SIGNAL(triggered()),
                                 this, SLOT(qSelectAllAction()));
            }

            menu.exec(mapToGlobal(event->pos()));
            this->focusWidget();
        }
    }

    void qCutAction()
    {
        QViewWidget::triggerPageAction(QWebPage::Cut);
    }

    void qCopyAction()
    {
        QViewWidget::triggerPageAction(QWebPage::Copy);
    }

    void qPasteAction()
    {
        QViewWidget::triggerPageAction(QWebPage::Paste);
    }

    void qSelectAllAction()
    {
        QViewWidget::triggerPageAction(QWebPage::SelectAll);
    }

    void qStartPrintPreviewSlot()
    {
#ifndef QT_NO_PRINTER
        QPrinter printer(QPrinter::HighResolution);
        QPrintPreviewDialog preview(&printer, this);
        preview.setWindowModality(Qt::WindowModal);
        preview.setMinimumSize(QDesktopWidget()
                               .screen()->rect().width() * 0.8,
                               QDesktopWidget()
                               .screen()->rect().height() * 0.8);
        connect(&preview, SIGNAL(paintRequested(QPrinter*)),
                SLOT(qPrintPreviewSlot(QPrinter*)));
        preview.exec();
#endif
    }

    void qPrintPreviewSlot(QPrinter *printer)
    {
#ifdef QT_NO_PRINTER
        Q_UNUSED(printer);
#else
        QViewWidget::print(printer);
#endif
    }

    void qPrintSlot()
    {
#ifndef QT_NO_PRINTER
        QPrinter printer;
        QPrintDialog *printDialog = new QPrintDialog(&printer);
        printDialog->setWindowModality(Qt::WindowModal);
        QSize dialogSize = printDialog->sizeHint();
        QRect screenRect = QDesktopWidget().screen()->rect();
        printDialog->move(QPoint((screenRect.width() / 2)
                                 - (dialogSize.width() / 2),
                                 (screenRect.height() / 2)
                                 - (dialogSize.height() / 2)));
        if (printDialog->exec() == QDialog::Accepted) {
            QViewWidget::print(&printer);
        }
        printDialog->close();
        printDialog->deleteLater();
#endif
    }

    // ==============================
    // QWebInspector window:
    // ==============================
    void qStartQWebInspector()
    {
        QWebInspector *inspector = new QWebInspector;
        inspector->setPage(QViewWidget::page());
        inspector->setGeometry(qApp->desktop()->availableGeometry());
        inspector->showMaximized();
    }

    // ==============================
    // Close window:
    // ==============================
    void qCloseWindowSlot()
    {
        qApp->setProperty("windowCloseRequested", true);
        this->parentWidget()->close();
    }

public:
    QViewWidget();

private:
    QPage *mainPage;
};

#endif // VIEW_H
