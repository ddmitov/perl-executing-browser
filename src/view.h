/*
 Perl Executing Browser QtWebEngine

 This program is free software;
 you can redistribute it and/or modify it under the terms of the
 GNU Lesser General Public License,
 as published by the Free Software Foundation;
 either version 3 of the License, or (at your option) any later version.
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY;
 without even the implied warranty of MERCHANTABILITY or
 FITNESS FOR A PARTICULAR PURPOSE.
 Dimitar D. Mitov, 2013 - 2024
 Valcho Nedelchev, 2014 - 2016
 https://github.com/ddmitov/perl-executing-browser
*/

#ifndef VIEW_H
#define VIEW_H

#include <QContextMenuEvent>
#include <QMenu>
#include <QWebEngineView>
#include <QtWebEngineWidgets>

#include "page.h"

// ==============================
// VIEW CLASS DEFINITION
// ==============================
class QViewWidget : public QWebEngineView
{
    Q_OBJECT

public slots:

    // Context menu:
   void contextMenuEvent(QContextMenuEvent *event)
   {
       QWebEngineContextMenuData contextMenuTest =
               QWebEngineView::page()->contextMenuData();

       Q_ASSERT(contextMenuTest.isValid());

       if (!contextMenuTest.isContentEditable()) {
           if (contextMenuTest.selectedText().length() > 0) {
               QMenu menu;

               QAction *copyAct = menu.addAction(QString("Copy"));

               QObject::connect(
                   copyAct,
                   SIGNAL(triggered()),
                   this,
                   SLOT(qCopyAction())
               );

               menu.exec(mapToGlobal(event->pos()));
               this->focusWidget();
           }
       }

       if (contextMenuTest.isContentEditable()) {
           QMenu menu;

           QAction *cutAct = menu.addAction(QString("Cut"));

           QObject::connect(
               cutAct,
               SIGNAL(triggered()),
               this,
               SLOT(qCutAction())
           );

           QAction *copyAct = menu.addAction(QString("Copy"));

           QObject::connect(
               copyAct,
               SIGNAL(triggered()),
               this,
               SLOT(qCopyAction())
           );

           QAction *pasteAct = menu.addAction(QString("Paste"));

           QObject::connect(
               pasteAct,
               SIGNAL(triggered()),
               this,
               SLOT(qPasteAction())
           );

           QAction *selectAllAct = menu.addAction(QString("Select All"));

           QObject::connect(
               selectAllAct,
               SIGNAL(triggered()),
               this,
               SLOT(qSelectAllAction())
           );

           menu.exec(mapToGlobal(event->pos()));

           this->focusWidget();
       }
   }

   // Context menu Cut action:
    void qCutAction()
    {
        QViewWidget::triggerPageAction(QWebEnginePage::Cut);
    }

    // Context menu Copy action:
    void qCopyAction()
    {
        QViewWidget::triggerPageAction(QWebEnginePage::Copy);
    }

    // Context menu Paste action:
    void qPasteAction()
    {
        QViewWidget::triggerPageAction(QWebEnginePage::Paste);
    }

    // Context menu Select All action:
    void qSelectAllAction()
    {
        QViewWidget::triggerPageAction(QWebEnginePage::SelectAll);
    }

public:

    QViewWidget();

private:

    QPage *mainPage;
};

#endif // VIEW_H
