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
 Dimitar D. Mitov, 2013 - 2019
 Valcho Nedelchev, 2014 - 2016
 https://github.com/ddmitov/perl-executing-browser
*/

#ifndef VIEW_H
#define VIEW_H

#include <QContextMenuEvent>
#include <QDesktopWidget>
#include <QMenu>
#include <QWebEngineView>
#include <QtWebEngineWidgets>

#include "webengine-page.h"

// ==============================
// VIEW CLASS DEFINITION:
// (QTWEBENGINE VERSION)
// ==============================
class QViewWidget : public QWebEngineView
{
    Q_OBJECT

signals:
    void startWindowClosingSignal();

public slots:
    // ==============================
    // Action taken after page is loaded:
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
        if (QWebEngineView::page()->url().scheme() != "file") {
            page()->action(QWebEnginePage::CopyImageToClipboard)->
                    setVisible(false);
            page()->action(QWebEnginePage::DownloadImageToDisk)->
                    setVisible(false);
            page()->action(QWebEnginePage::DownloadImageToDisk)->
                    setVisible(false);
            page()->action(QWebEnginePage::DownloadLinkToDisk)->
                    setVisible(false);
            page()->action(QWebEnginePage::DownloadMediaToDisk)->
                    setVisible(false);
            page()->action(QWebEnginePage::OpenLinkInNewWindow)->
                    setVisible(false);
            page()->action(QWebEnginePage::OpenLinkInThisWindow)->
                    setVisible(false);

            QMenu *menu = QWebEngineView::page()->createStandardContextMenu();
            menu->popup(event->globalPos());
        }

        if (QWebEngineView::page()->url().scheme() == "file") {
            QWebEngineContextMenuData contextMenuTest =
                    QWebEngineView::page()->contextMenuData();
            Q_ASSERT(contextMenuTest.isValid());

            if (!contextMenuTest.isContentEditable() and
                    contextMenuTest.selectedText().length() > 0) {
                QMenu menu;

                QAction *copyAct = menu
                        .addAction(qApp->property("copyLabel").toString());
                QObject::connect(copyAct, SIGNAL(triggered()),
                                 this, SLOT(qCopyAction()));

                menu.exec(mapToGlobal(event->pos()));
                this->focusWidget();
            }

            if (contextMenuTest.isContentEditable()) {
                QMenu menu;

                QAction *cutAct = menu
                        .addAction(qApp->property("cutLabel").toString());
                QObject::connect(cutAct, SIGNAL(triggered()),
                                 this, SLOT(qCutAction()));

                QAction *copyAct = menu
                        .addAction(qApp->property("copyLabel").toString());
                QObject::connect(copyAct, SIGNAL(triggered()),
                                 this, SLOT(qCopyAction()));

                QAction *pasteAct = menu
                        .addAction(qApp->property("pasteLabel").toString());
                QObject::connect(pasteAct, SIGNAL(triggered()),
                                 this, SLOT(qPasteAction()));

                QAction *selectAllAct = menu
                        .addAction(qApp->property("selectAllLabel").toString());
                QObject::connect(selectAllAct, SIGNAL(triggered()),
                                 this, SLOT(qSelectAllAction()));

                menu.exec(mapToGlobal(event->pos()));
                this->focusWidget();
            }
        }
    }

    void qCutAction()
    {
        QViewWidget::triggerPageAction(QWebEnginePage::Cut);
    }

    void qCopyAction()
    {
        QViewWidget::triggerPageAction(QWebEnginePage::Copy);
    }

    void qPasteAction()
    {
        QViewWidget::triggerPageAction(QWebEnginePage::Paste);
    }

    void qSelectAllAction()
    {
        QViewWidget::triggerPageAction(QWebEnginePage::SelectAll);
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
