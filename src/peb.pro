
TEMPLATE = app
TARGET = peb
TRANSLATIONS = $${TARGET}_bg_BG.ts

DEPENDPATH += .
CONFIG += openssl-linked
VERSION = 0.1

# Mac specific settings:
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

  ICON = camel.icns
}

win32 {
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

HEADERS += peb.h
SOURCES += peb.cpp

OTHER_FILES += peb.rc camel.ico

MOC_DIR = tmp
OBJECTS_DIR = tmp
