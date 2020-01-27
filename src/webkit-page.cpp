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

#include <QNetworkAccessManager>
#include <QNetworkCookieJar>
#include <QNetworkProxyFactory>

#include "webkit-page.h"

// ==============================
// LOCAL PAGE CLASS CONSTRUCTOR:
// (QTWEBKIT VERSION)
// ==============================
QPage::QPage()
    : QWebPage(0)
{
    // QWebPage settings:
    QNetworkProxyFactory::setUseSystemConfiguration(true);

    QWebSettings::globalSettings()->
            setDefaultTextEncoding(QString("utf-8"));

    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::JavaEnabled, false);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::JavascriptCanOpenWindows, false);

    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::AutoLoadImages, true);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::DeveloperExtrasEnabled, true);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::JavascriptEnabled, true);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::LocalContentCanAccessRemoteUrls, true);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::PluginsEnabled, true);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::XSSAuditingEnabled, true);

    // Signal and slot for actions taken after page is loaded:
    QObject::connect(this, SIGNAL(loadFinished(bool)),
                     this, SLOT(qPageLoadedSlot(bool)));

    // Default dialog and context menu labels:
    okLabel = "Ok";
    cancelLabel = "Cancel";
    yesLabel = "Yes";
    noLabel = "No";

    // Close requested indicator:
    closeRequested = false;
}
