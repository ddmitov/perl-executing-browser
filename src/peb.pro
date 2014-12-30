
TEMPLATE = app
TARGET = peb
DEPENDPATH += .
VERSION = 0.1
TRANSLATIONS = $${TARGET}_bg_BG.ts

# Network support:
QT += network
CONFIG += openssl-linked # necessary for handling https adresses

# Macintosh specific settings:
macx {
  ##########################################################
  # To make a bundle-less application:
  # (recommended)
  # DEFINES += "BUNDLE=0"
  # CONFIG -= app_bundle
  ##########################################################
  # To make a bundle (peb.app):
  # DEFINES += "BUNDLE=1"
  # CONFIG += app_bundle
  ##########################################################
  DEFINES += "BUNDLE=0"
  CONFIG -= app_bundle

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
MOC_DIR = tmp
OBJECTS_DIR = tmp

# The domain of Perl Executing Browser:
DEFINES += PEB_DOMAIN=\\\"http://perl-executing-browser-pseudodomain/\\\"
