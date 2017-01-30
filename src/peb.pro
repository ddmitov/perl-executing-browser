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
# Dimitar D. Mitov, 2013 - 2016
# Valcho Nedelchev, 2014 - 2016
# https://github.com/ddmitov/perl-executing-browser

message ("Going to configure Perl Executing Browser for Qt $$[QT_VERSION]")

lessThan (QT_MAJOR_VERSION, 5) {
    error ("Perl Executing Browser requires at least Qt 5.1 headers.")
}

equals (QT_MAJOR_VERSION, 5) {
    lessThan (QT_MINOR_VERSION, 1) {
        error ("Perl Executing Browser requires at least Qt 5.1 headers.")
    }

    greaterThan (QT_MINOR_VERSION, 5) {
        packagesExist(webkitwidgets) {
            message ("Going to build with manually added QtWebKit libraries.")
        }

        !packagesExist(webkitwidgets) {
            error ("QtWebKit libraries are not found.")
        }
    }

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

        ICON = icons/camel.icns
    }

    ##########################################################
    # ADMINISTRATIVE PRIVILEGES CHECK:
    # To disable administrative privileges check:
    # ADMIN_PRIVILEGES_CHECK = 0
    # By default administrative privileges check is disabled.
    # To enable administrative privileges check:
    # ADMIN_PRIVILEGES_CHECK = 1
    ##########################################################

    ADMIN_PRIVILEGES_CHECK = 0

    DEFINES += "ADMIN_PRIVILEGES_CHECK=$$ADMIN_PRIVILEGES_CHECK"

    equals (ADMIN_PRIVILEGES_CHECK, 0) {
        message ("Configured without administrative privileges check.")
    }
    equals (ADMIN_PRIVILEGES_CHECK, 1) {
        message ("Configured with administrative privileges check.")
    }

    ##########################################################
    # PERL DEBUGGER GUI:
    # To enable Perl debugger GUI:
    # PERL_DEBUGGER_GUI = 1
    # By default Perl debugger GUI is enabled.
    # To disable Perl debugger GUI:
    # PERL_DEBUGGER_GUI = 0
    # If PEB is going to be compiled for end users and
    # interaction with the biult-in Perl debugger is
    # not needed or not wanted for security reasons,
    # this functionality can be turned off.
    ##########################################################

    PERL_DEBUGGER_GUI = 1

    DEFINES += "PERL_DEBUGGER_GUI=$$PERL_DEBUGGER_GUI"

    equals (PERL_DEBUGGER_GUI, 0) {
        message ("Configured without Perl debugger GUI.")
    }
    equals (PERL_DEBUGGER_GUI, 1) {
        message ("Configured with Perl debugger GUI.")
    }

    ##########################################################

    # Binary basics:
    # CONFIG+=debug
    CONFIG+=release
    TEMPLATE = app
    TARGET = peb

    # Network support:
    QT += network

    # HTTPS support:
    CONFIG += openssl-linked

    # Webkit support:
    QT += widgets webkitwidgets

    # Printing support:
    QT += printsupport

    # Source files:
    HEADERS += peb.h
    SOURCES += peb.cpp

    # Resources:
    RESOURCES += resources/peb.qrc
    win32 {
        OTHER_FILES += resources/peb.rc resources/icons/camel.ico
        RC_FILE = resources/peb.rc
    }

    # Destination directory for the compiled binary:
    DESTDIR = $$PWD/../

    # Temporary folder:
    MOC_DIR = tmp
    OBJECTS_DIR = tmp
    RCC_DIR = tmp
}
