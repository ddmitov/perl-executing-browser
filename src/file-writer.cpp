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

#include "file-writer.h"

// ==============================
// FILE READER CONSTRUCTOR:
// ==============================
QFileWriter::QFileWriter(QString filePath, QString fileContents)
    : QObject(0)
{
  QFile file(filePath);
  if (file.open(QIODevice::ReadWrite | QIODevice::Text)) {
      QTextStream fileStream(&file);
      fileStream << fileContents <<endl;
      file.close();
  }
}
