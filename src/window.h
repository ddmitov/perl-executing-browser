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

#ifndef MAIN_WINDOW_H
#define MAIN_WINDOW_H

#include <QMainWindow>

#include "view.h"

// ==============================
// MAIN WINDOW CLASS DEFINITION
// ==============================
class QMainBrowserWindow : public QMainWindow
{
    Q_OBJECT

public slots:

    // Slot for setting the title of the main window:
    void qSetMainWindowTitleSlot(QString title)
    {
        setWindowTitle(title);
    }

    // Main window close event slot:
    void closeEvent(QCloseEvent *event)
    {
        this->mainViewWidget->page()->deleteLater();
        event->accept();
    }

public:

    QWebEngineView *mainViewWidget;

    explicit QMainBrowserWindow(QWidget *parent = 0);
};

#endif // MAIN_WINDOW_H
