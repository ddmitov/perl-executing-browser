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

#ifndef ACCESSMANAGER_H
#define ACCESSMANAGER_H

#include <QApplication>
#include <QDesktopWidget>
#include <QDir>
#include <QMimeDatabase>
#include <QtNetwork/QNetworkAccessManager>

#include "file-reader.h"
#include "local-reply.h"
#include "script-handler.h"

// ==============================
// ACCESS MANAGER CLASS DEFINITION:
// ==============================
class QAccessManager : public QNetworkAccessManager
{
    Q_OBJECT

signals:
    void handleScriptSignal(QUrl url, QByteArray postDataArray);
    void closeWindowSignal();

protected:
    virtual QNetworkReply *createRequest(Operation operation,
                                         const QNetworkRequest &request,
                                         QIODevice *outgoingData = 0)
    {
        if (request.url().host() ==
                qApp->property("pseudoDomain").toString() and
                (!request.url().path().contains(".function"))) {

            // Compose the full file path:
            QString fullFilePath = QDir::toNativeSeparators
                    ((qApp->property("application").toString())
                     + request.url().path());

            // Get the MIME type of the local file:
            QMimeDatabase mimeDatabase;
            QMimeType type = mimeDatabase.mimeTypeForFile(fullFilePath);
            QString mimeType = type.name();

            // Handle local Perl scripts:
            if (mimeType == "application/x-perl") {
                QByteArray postDataArray;

                // GET requests to the browser pseudodomain:
                if (operation == GetOperation) {
                    emit handleScriptSignal(request.url(), postDataArray);

                    QLocalReply *reply = new QLocalReply(request.url());
                    return reply;
                }

                // POST requests to the browser pseudodomain:
                if (operation == PostOperation) {
                    if (outgoingData) {
                        QByteArray postDataArray = outgoingData->readAll();
                        emit handleScriptSignal(request.url(),
                                                postDataArray);
                    }

                    QLocalReply *reply = new QLocalReply(request.url());
                    return reply;
                }
            }
        }

        // Window closing URL:
        if (operation == GetOperation and
                request.url().fileName() == "close-window.function") {
            emit closeWindowSignal();

            QLocalReply *reply = new QLocalReply(request.url());
            return reply;
        }

        return QNetworkAccessManager::createRequest
                (QNetworkAccessManager::GetOperation,
                 QNetworkRequest(request));
    }
};

#endif // ACCESSMANAGER_H
