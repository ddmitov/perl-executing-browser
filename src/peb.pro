lessThan (QT_MAJOR_VERSION, 5) {
    error ("Perl Executing Browser requires Qt5.1 - Qt5.5 headers.")
}

equals (QT_MAJOR_VERSION, 5) {
    lessThan (QT_MINOR_VERSION, 1) {
        error ("Perl Executing Browser requires Qt5.1 - Qt5.5 headers.")
    }

    greaterThan (QT_MINOR_VERSION, 5) {
        error ("Perl Executing Browser requires Qt5.1 - Qt5.5 headers.")
    }

    message ("Starting Perl Executing Browser configuration.")
    message ("Qt version: $$[QT_VERSION]")
    message ("Qt Header files: $$[QT_INSTALL_HEADERS]")
    message ("Qt Libraries: $$[QT_INSTALL_LIBS]")

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
            message ("Building without Perl debugger interaction capability.")
        }
        equals (PERL_DEBUGGER_INTERACTION, 1) {
            message ("Building with Perl debugger interaction capability.")
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
            message ("Building without Mac OSX bundle support.")
        }
        equals (BUNDLE, 1) {
            message ("Building with Mac OSX bundle support.")
        }

        ICON = icons/camel.icns
    }

    ##########################################################
    # NO CONFIGURATION OPTIONS BELOW THIS POINT.
    ##########################################################
    TEMPLATE = app
    TARGET = peb
    DEFINES += HAVE_QT5
    DEPENDPATH += .

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

    # Destination directory for the compiled binary:
    DESTDIR = $$PWD/../

    # Temporary folder:
    MOC_DIR = tmp
    OBJECTS_DIR = tmp
    RCC_DIR = tmp
}
