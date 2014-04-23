
TEMPLATE = app
TARGET = peb
TRANSLATIONS = $${TARGET}_en_US.ts $${TARGET}_bg_BG.ts

DEPENDPATH += .
CONFIG += openssl-linked
VERSION = 0.1

# Mac specific settings:
macx {
  # To make a bundle-less application:
  # DEFINES += "BUNDLE=0"
  # CONFIG -= app_bundle
  # To make a bundle (peb.app):
  # DEFINES += "BUNDLE=1"
  # CONFIG += app_bundle
  DEFINES += "BUNDLE=1"
  CONFIG += app_bundle
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

OTHER_FILES += \
    peb.rc \
    camel.ico
