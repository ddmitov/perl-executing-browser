
message ("")
message ("Starting Perl Executing Browser (PEB) build procedure...")
message ("")


##########################################################
# Application name:
# ATTENTION - replace spaces and commas with underscore like that:
# "Perl_Executing_Browser" but not "Perl Executing Browser"!
##########################################################
APPLICATION_NAME = "Perl_Executing_Browser"

DEFINES += APPLICATION_NAME=\\\"$$APPLICATION_NAME\\\"


##########################################################
# Application version:
##########################################################
APPLICATION_VERSION = "0.1"

DEFINES += APPLICATION_VERSION=\\\"$$APPLICATION_VERSION\\\"
message ("Application version: $$APPLICATION_VERSION")


##########################################################
# The pseudo-domain of the browser:
##########################################################
PSEUDO_DOMAIN = "perl-executing-browser-pseudodomain"

DEFINES += PSEUDO_DOMAIN=\\\"$$PSEUDO_DOMAIN\\\"
message ("Local pseudo-domain: $$PSEUDO_DOMAIN")


##########################################################
# To guard against some security issue
# with user-supplied Perl scripts:
# SCRIPT_CENSORING = 1
# If this option is enabled,
# every Perl script going to be executed by the browser
# is scanned by a special super-script, censor.pl, and
# if any security issues are found, the offending script
# is blocked and error message is displayed.
##########################################################
# To turn off security checks of user-supplied Perl scripts:
# SCRIPT_CENSORING = 0
##########################################################
SCRIPT_CENSORING = 1

DEFINES += "SCRIPT_CENSORING=$$SCRIPT_CENSORING"

equals (SCRIPT_CENSORING, 0) {
    message ("Going to build without script censoring support.")
}
equals (SCRIPT_CENSORING, 1) {
    message ("Going to build with script censoring support.")
}


##########################################################
# Interaction with the Perl debugger -
# not available on Windows:
##########################################################
!win32 {
    ##########################################################
    # To switch off Perl debugger interaction:
    # PERL_DEBUGGER_INTERACTION = 0
    # If PEB is going to be compiled for end users and
    # interaction with the biult-in Perl debugger is
    # not needed or not wanted for security reasons,
    # this functionality can be turned off.
    ##########################################################
    # To compile with Perl debugger interaction:
    # PERL_DEBUGGER_INTERACTION = 1
    ##########################################################
    PERL_DEBUGGER_INTERACTION = 1

    DEFINES += "PERL_DEBUGGER_INTERACTION=$$PERL_DEBUGGER_INTERACTION"

    equals (PERL_DEBUGGER_INTERACTION, 0) {
        message ("Going to build without Perl debugger interaction capability.")
    }
    equals (PERL_DEBUGGER_INTERACTION, 1) {
        message ("Going to build with Perl debugger interaction capability.")
    }
}


##########################################################
# Macintosh specific settings:
##########################################################
macx {
    ##########################################################
    # To make a bundle-less application: (recommended)
    # BUNDLE = 0
    # CONFIG -= app_bundle
    ##########################################################
    # To make a bundle (peb.app):
    # BUNDLE = 1
    # CONFIG += app_bundle
    ##########################################################
    BUNDLE = 0
    CONFIG -= app_bundle

    DEFINES += "BUNDLE=$$BUNDLE"

    equals (BUNDLE, 0) {
        message ("Going to build without Mac OSX bundle support...")
    }
    equals (BUNDLE, 1) {
        message ("Going to build with Mac OSX bundle support...")
    }

    ICON = icons/camel.icns
}


##########################################################
# NO CONFIGURATION OPTIONS BELOW THIS POINT.
##########################################################
message ("")
message ("Qt version: $$[QT_VERSION]")
message ("Qt is installed in: $$[QT_INSTALL_PREFIX]")
message ("Qt resources can be found in the following locations:")
message ("Qt Documentation: $$[QT_INSTALL_DOCS]")
message ("Qt Header files: $$[QT_INSTALL_HEADERS]")
message ("Qt Libraries: $$[QT_INSTALL_LIBS]")
message ("Qt Binary files (executables): $$[QT_INSTALL_BINS]")
message ("Qt Plugins: $$[QT_INSTALL_PLUGINS]")
message ("Qt Data files: $$[QT_INSTALL_DATA]")
message ("Qt Translation files: $$[QT_INSTALL_TRANSLATIONS]")
message ("")

TEMPLATE = app
TARGET = peb
DEFINES += HAVE_QT5
DEPENDPATH += .
VERSION = APPLICATION_VERSION

# Network support:
QT += network
CONFIG += openssl-linked # necessary for handling https adresses

# Webkit support:
QT += widgets webkitwidgets

# Printing support:
QT += printsupport

# Source files:
HEADERS += peb.h
SOURCES += peb.cpp

# Translation(s):
TRANSLATIONS = resources/translations/$${TARGET}_bg_BG.ts \

isEmpty (QMAKE_LUPDATE) {
    win32: QMAKE_LUPDATE = $$[QT_INSTALL_BINS]\lupdate.exe
    else: QMAKE_LUPDATE = $$[QT_INSTALL_BINS]/lupdate
}

isEmpty (QMAKE_LRELEASE) {
    win32: QMAKE_LRELEASE = $$[QT_INSTALL_BINS]\lrelease.exe
    else: QMAKE_LRELEASE = $$[QT_INSTALL_BINS]/lrelease
}

win32 {
    system ($$QMAKE_LUPDATE $$PWD\peb.pro)
    system ($$QMAKE_LRELEASE $$PWD\peb.pro)
} else {
    system ($$QMAKE_LUPDATE $$PWD/peb.pro)
    system ($$QMAKE_LRELEASE $$PWD/peb.pro)
}

# No Perl debugger support for Windows:
win32 {
    PERL_DEBUGGER_INTERACTION = 0
    DEFINES += "PERL_DEBUGGER_INTERACTION=$$PERL_DEBUGGER_INTERACTION"
    RESOURCES += resources/peb.qrc
    OTHER_FILES += resources/peb.rc resources/icons/camel.ico
    RC_FILE = resources/peb.rc
}

!win32 {
    # Resources:
    equals (PERL_DEBUGGER_INTERACTION, 0) {
        RESOURCES += resources/peb.qrc
    }

    equals (PERL_DEBUGGER_INTERACTION, 1) {
        RESOURCES += resources/peb.qrc \
        resources/peb-perl-debugger.qrc
    }
}

# Temporary folder:
MOC_DIR = ../tmp
OBJECTS_DIR = ../tmp
RCC_DIR = ../tmp

# Destination directory for the compiled binary:
CONFIG (debug, debug|release) {
    DESTDIR = ../
}

CONFIG (release, debug|release) {
    DESTDIR = ../
}
