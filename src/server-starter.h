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

#include <QtWidgets/QApplication>
#include <QObject>
#include <QTimer>
#include <QTcpSocket>
#include <QUrl>

#ifndef SERVER_STARTER_H
#define SERVER_STARTER_H

// ==============================
// SERVER STARTER CLASS DEFINITION:
// ==============================
class QServerStarter : public QObject
{
    Q_OBJECT

signals:
    void loadUrlSignal(QUrl url);
    void displayErrorSignal(QString errorString);

public slots:
    void qLocalServerPingSlot()
    {
        QTcpSocket localWebServerPing;
        localWebServerPing.connectToHost ("127.0.0.1",
                                          qApp->property("port").toInt());

        // Local server is pinged every second until ready:
        if (localWebServerPing.waitForConnected (1000)) {
            localServerTester->stop();

            QString localServerBaseUrl = "http://localhost:" +
                    qApp->property("port").toString() + "/";
            qApp->setProperty("local_server_base_url", localServerBaseUrl);

            loadUrlSignal(QUrl(localServerBaseUrl));
        }

        localServerWait++;

        if (localServerWait > 5) {
            localServerTester->stop();
            displayErrorSignal(QString("Local server timed out."));
        }
    }

public:
    QTimer *localServerTester;
    int localServerWait;

    explicit QServerStarter(QString localServerSettingsFilePath);
};

#endif // SERVER_STARTER_H
