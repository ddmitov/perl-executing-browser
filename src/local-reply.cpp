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

#include <QTimer>

#include "local-reply.h"

// ==============================
// LOCAL REPLY CONSTRUCTOR:
// ==============================
struct QLocalReplyPrivate
{
    QByteArray data;
    int offset;
};

QLocalReply::QLocalReply(const QUrl &url)
    : QNetworkReply()
{
    setFinished(true);
    open(ReadOnly | Unbuffered);

    reply = new QLocalReplyPrivate;
    reply->offset = 0;

    setUrl(url);

    QTimer::singleShot(0, this, SIGNAL(metaDataChanged()));

    setAttribute(QNetworkRequest::HttpStatusCodeAttribute, 204);

    QTimer::singleShot(0, this, SIGNAL(readyRead()));
    QTimer::singleShot(0, this, SIGNAL(finished()));
}

QLocalReply::~QLocalReply()
{
    delete reply;
}

qint64 QLocalReply::size() const
{
    return reply->data.size();
}

void QLocalReply::abort()
{
    // !!! No need to implement code here, but must be declared !!!
}

qint64 QLocalReply::bytesAvailable() const
{
    return size();
}

bool QLocalReply::isSequential() const
{
    return true;
}

qint64 QLocalReply::read(char *data, qint64 maxSize)
{
    return readData(data, maxSize);
}

qint64 QLocalReply::readData(char *data, qint64 maxSize)
{
    if (reply->offset >= reply->data.size()) {
        return -1;
    }

    qint64 number = qMin(maxSize, (qint64) reply->data.size() - reply->offset);
    memcpy(data, reply->data.constData() + reply->offset, number);
    reply->offset += number;
    return number;
}
