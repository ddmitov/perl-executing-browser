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

#ifndef EXITHANDLER_H
#define EXITHANDLER_H

#include <QApplication>
#include <QDebug>

// ==============================
// EXIT HANDLER CLASS DEFINITION:
// ==============================
class QExitHandler : public QObject
{
    Q_OBJECT

public slots:
    void qExitApplicationSlot()
    {
        qDebug() << qApp->applicationName().toLatin1().constData()
                << qApp->applicationVersion().toLatin1().constData()
                << "terminated normally.";

        QApplication::exit();
    }

public:
    QExitHandler();
};

#endif // EXITHANDLER_H
