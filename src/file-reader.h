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

#ifndef FILE_READER_H
#define FILE_READER_H

#include <QObject>

// ==============================
// FILE READER CLASS DEFINITION:
// Usefull for both files inside binary resources and files on disk
// ==============================
class QFileReader : public QObject
{
    Q_OBJECT

public:
    explicit QFileReader(QString filePath);
    QString fileContents;
};

#endif // FILE_READER_H
