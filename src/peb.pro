message ("")
message ("Starting Perl Executing Browser (PEB) build procedure...")
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
message ("Qt Settings: $$[QT_INSTALL_SETTINGS]")
message ("")

TEMPLATE = app
TARGET = peb
DEPENDPATH += .
VERSION = 0.1
TRANSLATIONS = $${TARGET}_bg_BG.ts

CONFIG (debug, debug|release) { 
    DESTDIR = ../
}
CONFIG (release, debug|release) { 
    DESTDIR = ../
}

# Network support:
QT += network
CONFIG += openssl-linked # necessary for handling https adresses

# Macintosh specific settings:
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

  ##########################################################
  # Set the version number of QMAKE_MAC_SDK to
  # the version number of your MacOSX SDK.
  # Updating MacOSX SDK (Xcode) without changing the
  # version number of QMAKE_MAC_SDK may
  # prevent you from successfully compiling the program.
  ##########################################################
  QMAKE_MAC_SDK = macosx10.9

  ICON = icons/camel.icns
}

# Windows specific settings:
win32 {
  # Resource and icon files:
  OTHER_FILES += peb.rc icons/camel.ico
  RC_FILE = peb.rc
}

# Qt4 specific settings:
lessThan (QT_MAJOR_VERSION, 5) {
  QT += webkit
}

# Qt5 specific settings:
greaterThan (QT_MAJOR_VERSION, 4) {
  QT += widgets webkitwidgets printsupport
  DEFINES += HAVE_QT5
}

# Source files:
HEADERS += peb.h
SOURCES += peb.cpp

# Temporary folder:
MOC_DIR = ../tmp
OBJECTS_DIR = ../tmp
RCC_DIR = ../tmp

# The domain of Perl Executing Browser:
PEB_DOMAIN = "http://perl-executing-browser-pseudodomain/"

DEFINES += PEB_DOMAIN=\\\"$$PEB_DOMAIN\\\"
message ("PEB pseudo-domain: $$PEB_DOMAIN")

##########################################################
# To guard against security issues of user-supplied Perl scripts:
# SCRIPT_CENSORING = 1
# If this option is enabled,
# every Perl script going to be executed by the browser
# is scanned by a special super-script, censor.pl, and
# if any security issues are found, the offending script
# is blocked and error message is displayed.
##########################################################
SCRIPT_CENSORING = 1

DEFINES += "SCRIPT_CENSORING=$$SCRIPT_CENSORING"

equals (SCRIPT_CENSORING, 0) {
    message ("Going to build without script censoring support...")
}
equals (SCRIPT_CENSORING, 1) {
    message ("Going to build with script censoring support...")
}

message ("")
