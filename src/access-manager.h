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
#include <QDesktopServices>
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
        // ==============================
        // Start page redirection:
        // ==============================
        if ((operation == GetOperation) and
                request.url().host() ==
                qApp->property("pseudoDomain").toString() and
                request.url().fileName().length() == 0) {
            QNetworkRequest startPageRequest;
            startPageRequest
                    .setUrl(QUrl(qApp->property("startPage").toString()));

            return QAccessManager::createRequest
                    (QAccessManager::GetOperation,
                     QNetworkRequest(startPageRequest));
        }

        // ==============================
        // GET requests to the browser pseudodomain:
        // ==============================
        if (operation == GetOperation and
                request.url().host() ==
                qApp->property("pseudoDomain").toString() and
                (!request.url().path().contains(".function"))) {

            // Compose the full file path:
            QString fullFilePath = QDir::toNativeSeparators
                    ((qApp->property("application").toString())
                     + request.url().path());

            // Check if file exists:
            QFile file(fullFilePath);
            if (file.exists()) {
                // Get the MIME type of the local file:
                QMimeDatabase mimeDatabase;
                QMimeType type = mimeDatabase.mimeTypeForFile(fullFilePath);
                // qDebug() << "MIME type:" << type.name();
                QString mimeType = type.name();

                // Handle local Perl scripts:
                if (mimeType == "application/x-perl") {
                    QByteArray emptyPostDataArray;
                    emit handleScriptSignal(
                                request.url(), emptyPostDataArray);

                    QLocalReply *reply = new QLocalReply(request.url(),
                                                         emptyString,
                                                         emptyString);
                    return reply;
                }

                // Handle other supported local files:
                if (mimeType == "text/html" or
                        mimeType == "text/xml" or
                        mimeType == "text/css" or
                        mimeType == "application/javascript" or
                        mimeType == "application/json" or
                        mimeType == "image/gif" or
                        mimeType == "image/jpeg" or
                        mimeType == "image/png" or
                        mimeType == "image/svg+xml" or
                        mimeType == "application/vnd.ms-fontobject" or
                        mimeType == "application/x-font-ttf" or
                        mimeType == "application/font-sfnt" or
                        mimeType.contains("application/font-woff")) {

                    qDebug() << "Local link requested:"
                            << request.url().toString();

                    QFileReader *resourceReader =
                            new QFileReader(QString(fullFilePath));
                    QString fileContents = resourceReader->fileContents;

                    QLocalReply *reply = new QLocalReply(request.url(),
                                                         fileContents,
                                                         mimeType);
                    return reply;
                } else {
                    qDebug() << "File type not supported:" << fullFilePath;

                    QDesktopServices::openUrl(
                                QUrl::fromLocalFile(fullFilePath));

                    QLocalReply *reply = new QLocalReply(request.url(),
                                                         emptyString,
                                                         emptyString);
                    return reply;
                }
            } else {
                qDebug() << "File not found:" << fullFilePath;

                QFileReader *resourceReader =
                        new QFileReader(QString(":/html/error.html"));
                QString htmlErrorContents = resourceReader->fileContents;

                QString errorMessage =
                        "<div><br>File not found:<br>" +
                        fullFilePath + "<br><br>" +
                        "<a href='http://local-pseudodomain/'>start page</a>" +
                        "</div>";
                htmlErrorContents.replace("ERROR_MESSAGE", errorMessage);

                QString mimeType = "text/html";

                QLocalReply *reply = new QLocalReply(request.url(),
                                                     htmlErrorContents,
                                                     mimeType);
                return reply;
            }
        }

        // ==============================
        // POST requests to the browser pseudodomain:
        // ==============================
        if (operation == PostOperation and
                request.url().host() ==
                qApp->property("pseudoDomain").toString()) {

            if (outgoingData) {
                QByteArray postDataArray = outgoingData->readAll();
                emit handleScriptSignal(request.url(), postDataArray);
            }

            QLocalReply *reply = new QLocalReply(request.url(),
                                                 emptyString,
                                                 emptyString);
            return reply;
        }

        // ==============================
        // Window closing URL:
        // ==============================
        if (operation == GetOperation and
                request.url().fileName() == "close-window.function") {
            emit closeWindowSignal();

            QLocalReply *reply = new QLocalReply(request.url(),
                                                 emptyString,
                                                 emptyString);
            return reply;
        }

        qDebug() << "Link requested:" << request.url().toString();

        return QNetworkAccessManager::createRequest
                (QNetworkAccessManager::GetOperation,
                 QNetworkRequest(request));
    }

private:
    QString emptyString;
};

#endif // ACCESSMANAGER_H
