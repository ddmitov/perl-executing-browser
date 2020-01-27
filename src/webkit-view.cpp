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
 Dimitar D. Mitov, 2013 - 2020
 Valcho Nedelchev, 2014 - 2016
 https://github.com/ddmitov/perl-executing-browser
*/

#include <QShortcut>

#include <webkit-view.h>

// ==============================
// VIEW CLASS CONSTRUCTOR:
// (QTWEBKIT VERSION)
// ==============================
QViewWidget::QViewWidget()
    : QWebView(0)
{
    // Default labels for the context menu:
    qApp->setProperty("cutLabel", "Cut");
    qApp->setProperty("copyLabel", "Copy");
    qApp->setProperty("pasteLabel", "Paste");
    qApp->setProperty("selectAllLabel", "Select All");

    // Keyboard shortcut:
    QShortcut *qWebInspestorShortcut =
            new QShortcut(QKeySequence("Ctrl+I"), this);
    QObject::connect(qWebInspestorShortcut, SIGNAL(activated()),
                     this, SLOT(qStartQWebInspector()));

    // Starting of a QPage instance:
    mainPage = new QPage();

    // Signal and slot for changing window title:
    QObject::connect(mainPage, SIGNAL(pageLoadedSignal()),
                     this, SLOT(qPageLoadedSlot()));

    // Signals and slots for closing windows:
    QObject::connect(mainPage, SIGNAL(hideWindowSignal()),
                     this, SLOT(qHideWindowSlot()));

    QObject::connect(mainPage, SIGNAL(closeWindowSignal()),
                     this, SLOT(qCloseWindowSlot()));

    // Installing of the started QPage instance:
    setPage(mainPage);
}
