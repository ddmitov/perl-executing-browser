#! /bin/sh

# Sometimes the Qt libraries that PEB depends on are not available on PATH.
# This script can start a QtWebEngine build of PEB with no Qt libraries on PATH,
# if the following libraries are placed in a folder named 'qt'
# inside the folder of PEB binary and this script:

# qt/libicudata.so.56.1
# qt/libicui18n.so.56.1
# qt/libicuuc.so.56.1
# qt/libQt5Core.so.5.8.0
# qt/libQt5Gui.so.5.8.0
# qt/libQt5Network.so.5.8.0
# qt/libQt5Positioning.so.5.8.0
# qt/libQt5PrintSupport.so.5.8.0
# qt/libQt5Qml.so.5.8.0
# qt/libQt5QuickWidgets.so.5.8.0
# qt/libQt5WebChannel.so.5.8.0
# qt/libQt5WebEngineCore.so.5.8.0
# qt/libQt5WebEngineWidgets.so.5.8.0
# qt/libQt5Widgets.so.5.8.0
# qt/libqxcb.so

# This file list was created using the 'ldd' utility and a Qt5.8 build of PEB.

export NO_AT_BRIDGE=1
export LD_LIBRARY_PATH=$(pwd)/qt
export QT_QPA_PLATFORM_PLUGIN_PATH=$(pwd)/qt
./peb
