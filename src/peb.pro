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

    message ("Perl Executing Browser using Qt $$[QT_VERSION]")
    message ("Qt Header files: $$[QT_INSTALL_HEADERS]")
    message ("Qt Libraries: $$[QT_INSTALL_LIBS]")

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
            message ("Configured without Mac OSX bundle support.")
        }
        equals (BUNDLE, 1) {
            message ("Configured with Mac OSX bundle support.")
        }

        ICON = icons/camel.icns
    }

    ##########################################################
    # Perl Debugger Interaction:
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
        message ("Configured without Perl debugger interaction capability.")
    }
    equals (PERL_DEBUGGER_INTERACTION, 1) {
        message ("Configured with Perl debugger interaction capability.")
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
