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

#ifndef FILE_WRITER_H
#define FILE_WRITER_H

#include <QObject>

// ==============================
// FILE WRITER CLASS DEFINITION:
// ==============================
class QFileWriter : public QObject
{
    Q_OBJECT

public:
    explicit QFileWriter(QString filePath, QString fileContents);
};

#endif // FILE_WRITER_H
