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

#include <QFile>
#include <QTextStream>

#include "file-reader.h"

// ==============================
// FILE READER CONSTRUCTOR:
// Usefull for both files inside binary resources and files on disk
// ==============================
QFileReader::QFileReader(QString filePath)
    : QObject(0)
{
    QString fileName(filePath);
    QFile file(fileName);
    file.open(QIODevice::ReadOnly | QIODevice::Text);
    QTextStream fileStream(&file);
    fileContents = fileStream.readAll();
    file.close();
}
