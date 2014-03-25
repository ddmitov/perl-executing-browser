
TEMPLATE = app
TARGET = peb
DEPENDPATH += .
CONFIG += openssl-linked

# http://doc.crossplatform.ru/qt/4.5.0/deployment-mac.html
macx {
CONFIG -= app_bundle
}

lessThan (QT_MAJOR_VERSION, 5) {
  QT += webkit
}

greaterThan (QT_MAJOR_VERSION, 4) {
  QT += widgets webkitwidgets
  DEFINES += HAVE_QT5
}

HEADERS += peb.h
SOURCES += peb.cpp
