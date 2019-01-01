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
#include <QFile>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QProcess>

#include "file-reader.h"
#include "port-scanner.h"
#include "server-starter.h"

// ==============================
// SERVER STARTER CONSTRUCTOR:
// ==============================
QServerStarter::QServerStarter(QString localServerSettingsFilePath)
    : QObject(0)
{
    bool localServerSettingsCorrect = false;
    QString localServerFullPath;
    QString port;
    QStringList localServerCommandLine;

    QFileReader *localServerSettingsReader =
            new QFileReader(localServerSettingsFilePath);
    QString localServerSettings =
            localServerSettingsReader->fileContents;

    QJsonDocument localServerJsonDocument =
            QJsonDocument::fromJson(localServerSettings.toUtf8());

    QJsonObject localServerJson;

    if (!localServerJsonDocument.isNull()) {
        localServerJson = localServerJsonDocument.object();
        if (!localServerJson.isEmpty()) {
            localServerSettingsCorrect = true;
        }
    }

    if (localServerSettingsCorrect == true) {
        // Local server full path:
        QString localServerFullPathSetting =
                qApp->property("application").toString() + "/" +
                localServerJson["file"].toString();

        QFile localServerFile(localServerFullPathSetting);

        if (localServerFile.exists()) {
            localServerFullPath = localServerFullPathSetting;
            localServerCommandLine.append(localServerFullPath);
        } else {
            displayErrorSignal(QString("Local server file is not found."));
        }

        // Local server port:
        QJsonArray ports = localServerJson["ports"].toArray();

        qint16 firstPort = ports[0].toInt();
        qint16 lastPort = ports[1].toInt();

        if (firstPort == 0) {
            localServerSettingsCorrect = false;
            displayErrorSignal(QString("No local server port is set."));
        }

        if (firstPort > 0) {
            if (lastPort == 0) {
                lastPort = firstPort;
            }

            QPortScanner *portScanner = new QPortScanner(firstPort, lastPort);

            if (portScanner->portScannerError.length() == 0) {
                port = QString::number(portScanner->port);
                qApp->setProperty("port", port);
            }

            if (portScanner->portScannerError.length() > 0) {
                displayErrorSignal(portScanner->portScannerError);
            }
        }

        // Local server command line arguments.
        // Local server port must be defined at this point!
        QJsonArray commandLineArgumentsArray =
                localServerJson["command-line-arguments"].toArray();
        foreach (QVariant argument, commandLineArgumentsArray) {
            QString argumentString = argument.toString();
            argumentString.replace("#PORT#", port);
            localServerCommandLine.append(argumentString);
        }

        // Local server shutdown command:
        if (localServerJson["shutdown_command"].toString().length() > 0) {;
            qApp->setProperty(
                        "shutdown_command",
                        localServerJson["shutdown_command"].toString());
        }
    }

    if (localServerSettingsCorrect == false) {
        displayErrorSignal(
                    localServerSettingsFilePath + "<br>" +
                    "is empty or malformed.");
    }

    // Local server has to be started as
    // a detached process for its proper operation:
    if (localServerSettingsCorrect == true) {
        QProcess localServer;
        localServer.startDetached (
                    qApp->property("perlInterpreter").toString(),
                    localServerCommandLine);

        // Local server is pinged every second until ready,
        // but after 5 seconds of being unaivailable,
        // a timeout message is displayed.
        // If local server is up and running for less than 5 seconds,
        // its index page is loaded.
        localServerTester = new QTimer();

        QObject::connect(localServerTester, SIGNAL (timeout()),
                         this, SLOT(qLocalServerPingSlot()));
        localServerTester->start(1000);
    }
}
