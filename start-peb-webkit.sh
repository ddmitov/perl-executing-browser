#! /bin/sh

# Sometimes the Qt libraries that PEB depends on are not available on PATH.
# This script can start a QtWebKit build of PEB with no Qt libraries on PATH,
# if the following libraries are placed in a folder named 'qt'
# inside the folder of PEB binary and this script:

# qt/libgstapp-1.0.so.0
# qt/libgstaudio-1.0.so.0
# qt/libgstbase-1.0.so.0
# qt/libgstpbutils-1.0.so.0
# qt/libgstreamer-1.0.so.0
# qt/libgsttag-1.0.so.0
# qt/libgstvideo-1.0.so.0
# qt/libicudata.so.54
# qt/libicui18n.so.54
# qt/libicuuc.so.54
# qt/libQt5Core.so.5
# qt/libQt5DBus.so.5
# qt/libQt5Gui.so.5
# qt/libQt5Network.so.5
# qt/libQt5OpenGL.so.5
# qt/libQt5Positioning.so.5
# qt/libQt5PrintSupport.so.5
# qt/libQt5Qml.so.5
# qt/libQt5Quick.so.5
# qt/libQt5Sensors.so.5
# qt/libQt5Sql.so.5
# qt/libQt5WebChannel.so.5
# qt/libQt5WebKit.so.5
# qt/libQt5WebKitWidgets.so.5
# qt/libQt5Widgets.so.5
# qt/libQt5XcbQpa.so.5
# qt/libqxcb.so

# This file list was created using the 'ldd' utility and a Qt5.5 build of PEB.

export LD_LIBRARY_PATH=$(pwd)/qt
export QT_QPA_PLATFORM_PLUGIN_PATH=$(pwd)/qt
./peb
