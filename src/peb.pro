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
# Dimitar D. Mitov, 2013 - 2017
# Valcho Nedelchev, 2014 - 2016
# https://github.com/ddmitov/perl-executing-browser

message ("Going to configure Perl Executing Browser for Qt $$[QT_VERSION]")

lessThan (QT_MAJOR_VERSION, 5) {
    error ("Perl Executing Browser requires Qt 5.")
}

greaterThan (QT_MAJOR_VERSION, 4) {
    message ("Qt Header files: $$[QT_INSTALL_HEADERS]")
    message ("Qt Libraries: $$[QT_INSTALL_LIBS]")

    macx {
        ##########################################################
        # MACINTOSH-SPECIFIC SETTING:
        # To make a bundle-less binary:
        # BUNDLE = 0
        # CONFIG -= app_bundle
        # By default bundle-less binary is compiled.
        # To make a bundled binary (peb.app):
        # BUNDLE = 1
        # CONFIG += app_bundle
        ##########################################################
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

    ##########################################################

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
        QT += widgets webenginewidgets
    }

    # Printing support:
    lessThan (QT_MINOR_VERSION, 6) {
        QT += printsupport
    }

    lessThan (QT_MINOR_VERSION, 6) {
        # Source files:
        SOURCES += \
            main.cpp \
            file-reader.cpp \
            main-window.cpp \
            script-handler.cpp \
            webkit-page.cpp \
            webkit-view.cpp

        # Header files:
        HEADERS += \
            file-reader.h \
            script-handler.h \
            webkit-main-window.h \
            webkit-page.h \
            webkit-view.h
    }

    greaterThan (QT_MINOR_VERSION, 5) {
        # Source files:
        SOURCES += \
            main.cpp \
            file-reader.cpp \
            main-window.cpp \
            script-handler.cpp \
            webengine-page.cpp \
            webengine-view.cpp

        # Header files:
        HEADERS += \
            file-reader.h \
            script-handler.h \
            webengine-main-window.h \
            webengine-page.h \
            webengine-view.h
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
