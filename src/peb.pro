# Perl Executing Browser QtWebEngine Project File

# This program is free software;
# you can redistribute it and/or modify it under the terms of the
# GNU Lesser General Public License,
# as published by the Free Software Foundation;
# either version 3 of the License, or (at your option) any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY;
# without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.
# Dimitar D. Mitov, 2013 - 2024
# Valcho Nedelchev, 2014 - 2016
# https://github.com/ddmitov/perl-executing-browser

lessThan (QT_MAJOR_VERSION, 5) {
    error ("Perl Executing Browser QtWebEngine requires minimal Qt version 5.9.")
}

lessThan (QT_MINOR_VERSION, 9) {
    error ("Perl Executing Browser QtWebEngine requires minimal Qt version 5.9.")
}

# Binary basics:
CONFIG += release
TEMPLATE = app
TARGET = peb

# HTML engine:
QT += widgets webenginewidgets

# Source files:
SOURCES += \
    main.cpp \
    window.cpp \
    script-handler.cpp \
    page.cpp \
    view.cpp

# Header files:
HEADERS += \
    script-handler.h \
    window.h \
    page.h \
    view.h

# Resources:
RESOURCES += resources/peb.qrc

# Destination directory for the compiled binary:
DESTDIR = $$PWD/../

# Temporary folder:
MOC_DIR = tmp
OBJECTS_DIR = tmp
RCC_DIR = tmp
