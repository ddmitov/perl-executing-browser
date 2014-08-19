
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
# To link statically QuaZip library for unpacking root folder from a zip file:
# DEFINES += "ZIP=1"
# ZIP_SUPPORT = 1
#######################################################################################
DEFINES += "ZIP=0"
ZIP_SUPPORT = 0

equals (ZIP_SUPPORT, 1) {
    message ("Building with ZIP support...")
    DEFINES += "QUAZIP_STATIC=1"
    INCLUDEPATH += <. zlib>
    HEADERS += quazip/crypt.h quazip/ioapi.h quazip/JlCompress.h \
    quazip/quaadler32.h quazip/quachecksum32.h quazip/quacrc32.h \
    quazip/quagzipfile.h quazip/quaziodevice.h quazip/quazipdir.h \
    quazip/quazipfile.h quazip/quazipfileinfo.h quazip/quazip_global.h \
    quazip/quazip.h quazip/zip.h quazip/quazipnewinfo.h quazip/unzip.h
    SOURCES += quazip/unzip.c  quazip/zip.c \
    quazip/JlCompress.cpp quazip/qioapi.cpp quazip/quaadler32.cpp \
    quazip/quacrc32.cpp quazip/quagzipfile.cpp quazip/quaziodevice.cpp \
    quazip/quazip.cpp quazip/quazipdir.cpp quazip/quazipfile.cpp \
    quazip/quazipfileinfo.cpp quazip/quazipnewinfo.cpp
}

OTHER_FILES += peb.rc camel.ico
