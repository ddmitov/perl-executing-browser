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

#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QApplication>
#include <QMainWindow>
#include <QWebEngineFullScreenRequest>

#include "webengine-view.h"

// ==============================
// MAIN WINDOW CLASS DEFINITION:
// (QTWEBENGINE VERSION)
// ==============================
class QMainBrowserWindow : public QMainWindow
{
    Q_OBJECT

signals:
    void startMainWindowClosingSignal();

public slots:
    void qDisplayError(QString errorMessage)
    {
        QFileReader *resourceReader =
                new QFileReader(QString(":/html/error.html"));
        QString htmlErrorContents = resourceReader->fileContents;
        htmlErrorContents.replace("ERROR_MESSAGE", errorMessage);

        webViewWidget->setHtml(htmlErrorContents);
        showMaximized();
    }

    void qLocalServerPingSlot()
    {
        QTcpSocket localWebServerPing;
        localWebServerPing.connectToHost ("127.0.0.1",
                                          qApp->property("port").toInt());

        // Local server is pinged every second until ready:
        if (localWebServerPing.waitForConnected (1000)) {
            localServerTimer->stop();
            localServerBaseUrl = "http://localhost:" +
                    qApp->property("port").toString() + "/";
            webViewWidget->load(QUrl(localServerBaseUrl));
            showMaximized();
        }
    }

    void setMainWindowTitleSlot(QString title)
    {
        setWindowTitle(title);
    }

    void qGoFullscreen(QWebEngineFullScreenRequest request) {
        QMainWindow::showFullScreen();
        request.accept();
    }

    void closeEvent(QCloseEvent *event)
    {
        if (qApp->property("windowCloseRequested").toBool() == false) {
            event->ignore();
            emit startMainWindowClosingSignal();
        }

        if (qApp->property("windowCloseRequested").toBool() == true) {
            if (qApp->property("shutdown_command").toString().length() > 0) {
                QString shutdownUrl = localServerBaseUrl +
                        qApp->property("shutdown_command").toString();

                webViewWidget->setUrl(QUrl(shutdownUrl));
            }

            event->accept();
        }
    }

    void qExitApplicationSlot()
    {
        qDebug() << "Application exited normally.";

        QApplication::exit();
    }

public:
    QTimer *localServerTimer;
    QString localServerBaseUrl;

    QWebEngineView *webViewWidget;
    explicit QMainBrowserWindow(QWidget *parent = 0);
};

#endif // MAINWINDOW_H
