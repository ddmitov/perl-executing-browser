# Perl Executing Browser Project File

# This program is free software;
# you can redistribute it and/or modify it under the terms of the
# GNU Lesser General Public License,
# as published by the Free Software Foundation;
# either version 3 of the License, or (at your option) any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY;
# without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.
# Dimitar D. Mitov, 2013 - 2018
# Valcho Nedelchev, 2014 - 2016
# https://github.com/ddmitov/perl-executing-browser

message ("Going to configure Perl Executing Browser for Qt $$[QT_VERSION]")

lessThan (QT_MAJOR_VERSION, 5) {
    error ("Perl Executing Browser requires Qt 5.")
}

greaterThan (QT_MAJOR_VERSION, 4) {
    message ("Qt Header files: $$[QT_INSTALL_HEADERS]")
    message ("Qt Libraries: $$[QT_INSTALL_LIBS]")

    ##########################################################
    # ANNULEN QTWEBKIT
    # Updated QtWebKit headers and libraries for
    # Qt versions 5.6.x or higher can be downloaded from:
    # https://github.com/annulen/webkit/releases

    # To use QtWebKit or QtWebEngine depending on the Qt version,
    # which is the default setting:
    # ANNULEN_QTWEBKIT = 0
    # QtWebKit is the default web engine for Qt versions up to 5.5.x and
    # QtWebEngine is the default web engine for Qt versions 5.6.x or higher

    # To use an updated QtWebKit version from
    # the repository of Konstantin Tokarev (annulen) with
    # a Qt version 5.6.x or higher:
    # ANNULEN_QTWEBKIT = 1

    # This setting has no effect on Qt versions 5.5 or lower.
    ##########################################################

    ANNULEN_QTWEBKIT = 0

    DEFINES += "ANNULEN_QTWEBKIT=$$ANNULEN_QTWEBKIT"

    ##########################################################
    # MAC BUNDLE

    # To make a bundle-less binary:
    # BUNDLE = 0
    # CONFIG -= app_bundle
    # By default bundle-less binary is compiled.

    # To make a bundled binary (peb.app):
    # BUNDLE = 1
    # CONFIG += app_bundle
    ##########################################################

    macx {
        BUNDLE = 0
        CONFIG -= app_bundle

        DEFINES += "BUNDLE=$$BUNDLE"

        equals (BUNDLE, 0) {
            message ("Configured without Mac OSX bundle support.")
        }
        equals (BUNDLE, 1) {
            message ("Configured with Mac OSX bundle support.")
        }

        ICON = resources/icons/camel.icns
    }

    # Binary basics:
    CONFIG += release
    TEMPLATE = app
    TARGET = peb

    # Network support:
    QT += network

    # HTTPS support:
    CONFIG += openssl-linked

    # HTML engine:
    lessThan (QT_MINOR_VERSION, 6) {
        QT += widgets webkitwidgets
    }

    greaterThan (QT_MINOR_VERSION, 5) {
        equals (ANNULEN_QTWEBKIT, 0) {
            QT += widgets webenginewidgets
        }

        equals (ANNULEN_QTWEBKIT, 1) {
            QT += widgets webkitwidgets
        }
    }

    # Printing support:
    lessThan (QT_MINOR_VERSION, 6) {
        QT += printsupport
    }

    greaterThan (QT_MINOR_VERSION, 5) {
        equals (ANNULEN_QTWEBKIT, 1) {
            QT += printsupport
        }
    }

    lessThan (QT_MINOR_VERSION, 6) {
        # Source files:
        SOURCES += \
            main.cpp \
            file-reader.cpp \
            main-window.cpp \
            port-scanner.cpp \
            script-handler.cpp \
            webkit-page.cpp \
            webkit-view.cpp

        # Header files:
        HEADERS += \
            file-reader.h \
            port-scanner.h \
            script-handler.h \
            webkit-main-window.h \
            webkit-page.h \
            webkit-view.h
    }

    greaterThan (QT_MINOR_VERSION, 5) {
        equals (ANNULEN_QTWEBKIT, 0) {
            # Source files:
            SOURCES += \
                main.cpp \
                file-reader.cpp \
                main-window.cpp \
                port-scanner.cpp \
                script-handler.cpp \
                webengine-page.cpp \
                webengine-view.cpp

            # Header files:
            HEADERS += \
                file-reader.h \
                port-scanner.h \
                script-handler.h \
                webengine-main-window.h \
                webengine-page.h \
                webengine-view.h
        }

        equals (ANNULEN_QTWEBKIT, 1) {
            # Source files:
            SOURCES += \
                main.cpp \
                file-reader.cpp \
                main-window.cpp \
                port-scanner.cpp \
                script-handler.cpp \
                webkit-page.cpp \
                webkit-view.cpp

            # Header files:
            HEADERS += \
                file-reader.h \
                port-scanner.h \
                script-handler.h \
                webkit-main-window.h \
                webkit-page.h \
                webkit-view.h
        }
    }

    # Resources:
    RESOURCES += resources/peb.qrc
    win32 {
        OTHER_FILES += resources/peb.rc resources/icon/camel.ico
        RC_FILE = resources/peb.rc
    }

    # Destination directory for the compiled binary:
    DESTDIR = $$PWD/../

    # Temporary folder:
    MOC_DIR = tmp
    OBJECTS_DIR = tmp
    RCC_DIR = tmp
}
