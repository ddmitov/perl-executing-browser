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

#include "window.h"

// ==============================
// MAIN WINDOW CLASS CONSTRUCTOR
// ==============================
QMainBrowserWindow::QMainBrowserWindow(QWidget *parent)
    : QMainWindow(parent)
{
    mainViewWidget = new QViewWidget();

    setCentralWidget(mainViewWidget);
    showMaximized();

    // Signal and slot for setting the title of the main window:
    QObject::connect(
        this->mainViewWidget,
        SIGNAL(titleChanged(QString)),
        this,
        SLOT(qSetMainWindowTitleSlot(QString))
    );
}
