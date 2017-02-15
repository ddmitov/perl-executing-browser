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
 Dimitar D. Mitov, 2013 - 2017
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

#include "page.h"

// ==============================
// PRINT SUPPORT:
// ==============================
#ifndef QT_NO_PRINTER
#include <QPrintPreviewDialog>
#include <QtPrintSupport/QPrinter>
#include <QtPrintSupport/QPrintDialog>
#endif

// ==============================
// VIEW CLASS DEFINITION:
// ==============================
class QViewWidget : public QWebView
{
    Q_OBJECT

signals:
    void initiateWindowClosingSignal();

public slots:
    // ==============================
    // Change window title:
    // ==============================
    void qChangeTitleSlot()
    {
        setWindowTitle(QViewWidget::title());
    }

    // ==============================
    // Context menu:
    // ==============================
    void contextMenuEvent(QContextMenuEvent *event)
    {
        QWebHitTestResult qWebHitTestResult =
                mainPage->mainFrame()->hitTestContent(event->pos());
        QMenu menu;

        QString printPreviewLabel;
        QString printLabel;

        QString cutLabel;
        QString copyLabel;
        QString pasteLabel;
        QString selectAllLabel;

        QFileReader *resourceReader =
                new QFileReader(QString(":/peb.js"));
        QString pebJavaScript = resourceReader->fileContents;

        mainPage->currentFrame()->evaluateJavaScript(pebJavaScript);

        QVariant contextMenuJsResult =
                mainPage->currentFrame()->
                evaluateJavaScript("pebFindContextMenu()");

        QJsonDocument contextMenuJsonDocument =
                QJsonDocument::fromJson(
                    contextMenuJsResult.toString().toUtf8());

        QJsonObject contextMenuJsonObject =
                contextMenuJsonDocument.object();

        if (contextMenuJsonObject.length() > 0) {
            if (contextMenuJsonObject["printPreview"].toString()
                    .length() > 0) {
                printPreviewLabel =
                        contextMenuJsonObject["printPreview"].toString();
            }

            if (contextMenuJsonObject["print"].toString().length() > 0) {
                printLabel = contextMenuJsonObject["print"].toString();
            }

            if (contextMenuJsonObject["cut"].toString().length() > 0) {
                cutLabel = contextMenuJsonObject["cut"].toString();
            }

            if (contextMenuJsonObject["copy"].toString().length() > 0) {
                copyLabel = contextMenuJsonObject["copy"].toString();
            }

            if (contextMenuJsonObject["paste"].toString().length() > 0) {
                pasteLabel = contextMenuJsonObject["paste"].toString();
            }

            if (contextMenuJsonObject["selectAll"].toString().length() > 0) {
                selectAllLabel = contextMenuJsonObject["selectAll"]
                        .toString();
            }
        } else {
            printPreviewLabel = "Print Preview";
            printLabel = "Print";

            cutLabel = "Cut";
            copyLabel = "Copy";
            pasteLabel = "Paste";
            selectAllLabel = "Select All";
        }

        if ((qWebHitTestResult.isContentEditable() and
                qWebHitTestResult.linkUrl().isEmpty() and
                qWebHitTestResult.imageUrl().isEmpty()) or
                qWebHitTestResult.isContentSelected()) {

            if (cutLabel.length() > 0) {
                QAction *cutAct = menu.addAction(cutLabel);
                QObject::connect(cutAct, SIGNAL(triggered()),
                                 this, SLOT(qCutAction()));
            }

            if (copyLabel.length() > 0) {
                QAction *copyAct = menu.addAction(copyLabel);
                QObject::connect(copyAct, SIGNAL(triggered()),
                                 this, SLOT(qCopyAction()));
            }

            if (pasteLabel.length() > 0) {
                QAction *pasteAct = menu.addAction(pasteLabel);
                QObject::connect(pasteAct, SIGNAL(triggered()),
                                 this, SLOT(qPasteAction()));
            }

            if (selectAllLabel.length() > 0) {
                QAction *selectAllAct = menu.addAction(selectAllLabel);
                QObject::connect(selectAllAct, SIGNAL(triggered()),
                                 this, SLOT(qSelectAllAction()));
            }
        }

        if (!qWebHitTestResult.isContentEditable() and
                qWebHitTestResult.linkUrl().isEmpty() and
                qWebHitTestResult.imageUrl().isEmpty() and
                (!qWebHitTestResult.isContentSelected())) {

            if (printPreviewLabel.length() > 0) {
                QAction *printPreviewAct = menu.addAction(printPreviewLabel);
                QObject::connect(printPreviewAct, SIGNAL(triggered()),
                                 this, SLOT(qStartPrintPreviewSlot()));
            }

            if (printLabel.length() > 0) {
                QAction *printAct = menu.addAction(printLabel);
                QObject::connect(printAct, SIGNAL(triggered()),
                                 this, SLOT(qPrintSlot()));
            }

            if (selectAllLabel.length() > 0) {
                QAction *selectAllAct = menu.addAction(selectAllLabel);
                QObject::connect(selectAllAct, SIGNAL(triggered()),
                                 this, SLOT(qSelectAllAction()));
            }
        }

        menu.exec(mapToGlobal(event->pos()));
        this->focusWidget();
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
        qDebug() << "Printing requested.";

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
    // Script errors window:
    // ==============================
    void qDisplayScriptErrorsSlot(QString errors)
    {
        QViewWidget *errorsWindow = new QViewWidget();
        errorsWindow->setHtml(errors,
                              QUrl(qApp->property("pseudoDomain").toString()));
        errorsWindow->setFocus();
        errorsWindow->show();
    }

    // ==============================
    // QWebInspector window:
    // ==============================
    void qStartQWebInspector()
    {
        qDebug() << "QWebInspector started.";

        QWebInspector *inspector = new QWebInspector;
        inspector->setPage(QViewWidget::page());
        inspector->show();
    }

    // ==============================
    // Window-closing routines:
    // ==============================
    void closeEvent(QCloseEvent *event)
    {
        if (windowCloseRequested == false) {
            event->ignore();
            emit initiateWindowClosingSignal();
        }

        if (windowCloseRequested == true) {
            event->accept();
        }
    }

    void qCloseWindowSlot()
    {
        if (!this->parentWidget()) {
            windowCloseRequested = true;
            this->close();
        }

        if (this->parentWidget()) {
            qApp->setProperty("mainWindowCloseRequested", true);
            this->parentWidget()->close();
        }
    }

public:
    QViewWidget();

    // ==============================
    // New window:
    // ==============================
    QWebView *createWindow(QWebPage::WebWindowType type)
    {
        Q_UNUSED(type);

        QFileReader *htmlReader =
                new QFileReader(QString(":/html/loading.html"));
        QString loadingContents = htmlReader->fileContents;

        QWebView *window = new QViewWidget();
        window->setHtml(loadingContents);
        window->setGeometry(qApp->desktop()->availableGeometry());
        window->showMaximized();

        qDebug() << "New window opened.";

        return window;
    }

private:
    QPage *mainPage;

    bool windowCloseRequested;
};

#endif // VIEW_H
