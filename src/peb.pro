
TEMPLATE = app
TARGET = peb
TRANSLATIONS = $${TARGET}_bg_BG.ts

DEPENDPATH += .
CONFIG += openssl-linked
VERSION = 0.1

# Mac specific settings:
macx {
  #############################
  # To make a bundle-less application:
  # (recommended)
  # DEFINES += "BUNDLE=0"
  # CONFIG -= app_bundle
  #############################
  # To make a bundle (peb.app):
  # DEFINES += "BUNDLE=1"
  # CONFIG += app_bundle
  #############################
  DEFINES += "BUNDLE=0"
  CONFIG -= app_bundle
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

#######################################################################################
# To link statically OSDaB-Zip library for unpacking root folder from a zip file:
# DEFINES += "ZIP=1"
# ZIP_SUPPORT = 1
#######################################################################################
DEFINES += "ZIP=1"
ZIP_SUPPORT = 1

equals (ZIP_SUPPORT, 1) {
    message ("Building with ZIP support...")
    INCLUDEPATH += <. zlib>
    HEADERS += osdabzip/unzip.h osdabzip/unzip_p.h \
    osdabzip/zip.h osdabzip/zip_p.h \
    osdabzip/zipentry_p.h osdabzip/zipglobal.h
    SOURCES += osdabzip/unzip.cpp osdabzip/zip.cpp osdabzip/zipglobal.cpp
}

OTHER_FILES += peb.rc camel.ico

MOC_DIR = tmp
OBJECTS_DIR = tmp
