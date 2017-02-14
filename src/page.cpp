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

#include <QNetworkCookieJar>
#include <QNetworkProxyFactory>
#include <QWebHistory>

#include "access-manager.h"
#include "page.h"

// ==============================
// WEB PAGE CLASS CONSTRUCTOR:
// ==============================
QPage::QPage()
    : QWebPage(0)
{
    // QWebPage settings:
    QNetworkProxyFactory::setUseSystemConfiguration(true);
    QWebSettings::globalSettings()->
            setDefaultTextEncoding(QString("utf-8"));

    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::PluginsEnabled, false);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::JavaEnabled, false);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::LocalContentCanAccessRemoteUrls, false);

    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::AutoLoadImages, true);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::DeveloperExtrasEnabled, true);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::JavascriptEnabled, true);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::JavascriptCanOpenWindows, true);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::PrivateBrowsingEnabled, true);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::SpatialNavigationEnabled, true);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::LinksIncludedInFocusChain, true);
    QWebSettings::globalSettings()->
            setAttribute(QWebSettings::XSSAuditingEnabled, true);

    // No download of files:
    setForwardUnsupportedContent(false);

    // All links are handled by the application itself:
    setLinkDelegationPolicy(QWebPage::DontDelegateLinks);

    // Disabled cache:
    QWebSettings::setMaximumPagesInCache(0);
    QWebSettings::setObjectCacheCapacities(0, 0, 0);

    // Disabled history:
    QWebHistory *history = this->history();
    history->setMaximumItemCount(0);

    // Scroll bars:
    mainFrame()->setScrollBarPolicy(Qt::Horizontal,
                                              Qt::ScrollBarAsNeeded);
    mainFrame()->setScrollBarPolicy(Qt::Vertical,
                                              Qt::ScrollBarAsNeeded);

    // Regular expression for detection of HTML file extensions:
    htmlFileNameExtensionMarker.setPattern(".htm{0,1}");
    htmlFileNameExtensionMarker.setCaseSensitivity(Qt::CaseInsensitive);

    // Default labels for JavaScript 'Alert', 'Confirm' and 'Prompt' dialogs:
    alertTitle = "Alert";
    confirmTitle = "Confirmation";
    promptTitle = "Prompt";

    okLabel = "Ok";
    cancelLabel = "Cancel";
    yesLabel = "Yes";
    noLabel = "No";

    // Initialization of a modified Network Access Manager:
    QAccessManager *networkAccessManager = new QAccessManager();

    // Cookies and HTTPS support:
    QNetworkCookieJar *cookieJar = new QNetworkCookieJar;
    networkAccessManager->setCookieJar(cookieJar);

    // Using the modified Network Access Manager:
    setNetworkAccessManager(networkAccessManager);

    // Signal and slot for SSL errors:
    QObject::connect(networkAccessManager,
                     SIGNAL(sslErrors(QNetworkReply *, QList<QSslError>)),
                     this,
                     SLOT(qSslErrorsSlot(QNetworkReply *, QList<QSslError>)));

    // Signal and slot for other network errors:
    QObject::connect(networkAccessManager,
                     SIGNAL(finished(QNetworkReply *)),
                     this,
                     SLOT(qNetworkReply(QNetworkReply *)));

    // Signal and slot for the detection of page status:
    QObject::connect(this,
                     SIGNAL(pageStatusSignal(QString)),
                     networkAccessManager,
                     SLOT(qPageStatusSlot(QString)));

    // Signal and slot for starting local scripts:
    QObject::connect(networkAccessManager,
                     SIGNAL(handleScriptSignal(QUrl, QByteArray)),
                     this,
                     SLOT(qHandleScriptSlot(QUrl, QByteArray)));

    // Signals and slots for closing windows:
    QObject::connect(this, SIGNAL(closeAllScriptsSignal()),
                     this, SLOT(qCloseAllScriptsSlot()));

    QObject::connect(networkAccessManager, SIGNAL(closeWindowSignal()),
                     this, SLOT(qCloseWindowTransmitterSlot()));

    // Signals and slots for actions taken after page is loaded:
    QObject::connect(this, SIGNAL(loadFinished(bool)),
                     this, SLOT(qPageLoadedSlot(bool)));

    // Signal and slot for injection of browser-specific JavaScript:
    QObject::connect(this, SIGNAL(frameCreated(QWebFrame *)),
                     this, SLOT(qFrameCustomizerSlot(QWebFrame *)));

    lastTargetFrame = currentFrame();
    windowCloseRequested = false;
}
