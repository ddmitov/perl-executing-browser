
TEMPLATE = app
TARGET = peb
DEPENDPATH += .
CONFIG += openssl-linked

# http://doc.crossplatform.ru/qt/4.5.0/deployment-mac.html
# http://www.zestymeta.com/2013/02/qt-osx-app-bundles-and-you.html
# http://leonid.shevtsov.me/en/how-to-create-icns-icons-for-os-x
# http://iconverticons.com/online/
macx {
  CONFIG -= app_bundle
  ICON = camel-icon-32.icns
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
