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

#include <QShortcut>

#include <view.h>

// ==============================
// VIEW CLASS CONSTRUCTOR:
// ==============================
QViewWidget::QViewWidget()
    : QWebView(0)
{
    // Keyboard shortcuts:
#ifndef QT_NO_PRINTER
    QShortcut *printShortcut = new QShortcut(QKeySequence("Ctrl+P"), this);
    QObject::connect(printShortcut, SIGNAL(activated()),
                     this, SLOT(qPrintSlot()));
#endif

    QShortcut *qWebInspestorShortcut =
            new QShortcut(QKeySequence("Ctrl+I"), this);
    QObject::connect(qWebInspestorShortcut, SIGNAL(activated()),
                     this, SLOT(qStartQWebInspector()));

    // Starting of a QPage instance:
    mainPage = new QPage();

    // Signal and slot for displaying script errors:
    QObject::connect(mainPage, SIGNAL(displayScriptErrorsSignal(QString)),
                     this, SLOT(qDisplayScriptErrorsSlot(QString)));

    // Signals and slots for printing:
    QObject::connect(mainPage, SIGNAL(printPreviewSignal()),
                     this, SLOT(qStartPrintPreviewSlot()));
    QObject::connect(mainPage, SIGNAL(printSignal()),
                     this, SLOT(qPrintSlot()));

    // Signal and slot for changing window title:
    QObject::connect(mainPage, SIGNAL(changeTitleSignal()),
                     this, SLOT(qChangeTitleSlot()));

    // Signal and slot for selecting files or folders from URL:
    QObject::connect(mainPage, SIGNAL(selectInodeSignal(QNetworkRequest)),
                     this, SLOT(qSelectInodesSlot(QNetworkRequest)));

    // Signals and slots for closing windows:
    QObject::connect(this, SIGNAL(initiateWindowClosingSignal()),
                     mainPage, SLOT(qInitiateWindowClosingSlot()));

    QObject::connect(mainPage, SIGNAL(closeWindowSignal()),
                     this, SLOT(qCloseWindowSlot()));

    // Installing of the started QPage instance:
    setPage(mainPage);

    // Initialization of a variable necessary for
    // user input check before closing a new window
    // (any window opened after the initial one):
    windowCloseRequested = false;
}
