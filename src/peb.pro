
TEMPLATE = app
TARGET = peb
DEPENDPATH += .
CONFIG += openssl-linked

# http://doc.crossplatform.ru/qt/4.5.0/deployment-mac.html
# http://www.zestymeta.com/2013/02/qt-osx-app-bundles-and-you.html
# http://leonid.shevtsov.me/en/how-to-create-icns-icons-for-os-x
# http://iconverticons.com/online/
# http://stackoverflow.com/questions/3348711/add-a-define-to-qmake-with-a-value

# Mac specific settings:
macx {
  # To make a bundle-less application:
  # DEFINES += "BUNDLE=0"
  # CONFIG -= app_bundle
  # To make a bundle (peb.app):
  # DEFINES += "BUNDLE=1"
  # CONFIG += app_bundle
  DEFINES += "BUNDLE=0"
  CONFIG -= app_bundle
  ICON = camel-icon-32.icns
}

# Qt4 specific settings:
lessThan (QT_MAJOR_VERSION, 5) {
  QT += webkit
}

# Qt5 specific settings:
greaterThan (QT_MAJOR_VERSION, 4) {
  QT += widgets webkitwidgets
  DEFINES += HAVE_QT5
}

HEADERS += peb.h
SOURCES += peb.cpp
