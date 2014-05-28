#! /bin/sh

# http://lemirep.wordpress.com/2013/06/01/deploying-qt-applications-on-linux-and-windows-3/

# To start a Qt5 build of Perl Executing Browser on a machine where Qt5 libraries are not installed,
# you can place the following libraries in subfolders relative to the folder of this script:

# qt5/i386/lib/libicudata.so.51
# qt5/i386/lib/libicui18n.so.51
# qt5/i386/lib/libicuuc.so.51
# qt5/i386/lib/libQt5Core.so.5
# qt5/i386/lib/libQt5DBus.so.5
# qt5/i386/lib/libQt5Gui.so.5
# qt5/i386/lib/libQt5Network.so.5
# qt5/i386/lib/libQt5OpenGL.so.5
# qt5/i386/lib/libQt5Positioning.so.5
# qt5/i386/lib/libQt5PrintSupport.so.5
# qt5/i386/lib/libQt5Qml.so.5
# qt5/i386/lib/libQt5Quick.so.5
# qt5/i386/lib/libQt5Sensors.so.5
# qt5/i386/lib/libQt5Sql.so.5
# qt5/i386/lib/libQt5WebKit.so.5
# qt5/i386/lib/libQt5WebKitWidgets.so.5
# qt5/i386/lib/libQt5Widgets.so.5
# qt5/i386/platforms/libqxcb.so

# Tested with Qt 5.2.0.

export LD_LIBRARY_PATH=$(pwd)/qt5/i386/lib
export QT_QPA_PLATFORM_PLUGIN_PATH=$(pwd)/qt5/i386/platforms
export QT_ACCESSIBILITY=0
./peb-qt5
