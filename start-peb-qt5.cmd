
rem http://lemirep.wordpress.com/2013/06/01/deploying-qt-applications-on-linux-and-windows-3/

rem To start a Qt5 build of Perl Executing Browser on a machine where Qt5 libraries are not installed,
rem you can place the following libraries in subfolders relative to the folder of this script:

rem qt5/i386/lib/libicudata.so.51
rem qt5/win32/lib/icudt51.dll
rem qt5/win32/lib/icuin51.dll
rem qt5/win32/lib/icuuc51.dll
rem qt5/win32/lib/libgcc_s_dw2-1.dll
rem qt5/win32/lib/libstdc++-6.dll
rem qt5/win32/lib/libwinpthread-1.dll
rem qt5/win32/lib/Qt5Core.dll
rem qt5/win32/lib/Qt5Gui.dll
rem qt5/win32/lib/Qt5Multimedia.dll
rem qt5/win32/lib/Qt5MultimediaWidgets.dll
rem qt5/win32/lib/Qt5Network.dll
rem qt5/win32/lib/Qt5OpenGL.dll
rem qt5/win32/lib/Qt5Positioning.dll
rem qt5/win32/lib/Qt5PrintSupport.dll
rem qt5/win32/lib/Qt5Qml.dll
rem qt5/win32/lib/Qt5Quick.dll
rem qt5/win32/lib/Qt5Sensors.dll
rem qt5/win32/lib/Qt5Sql.dll
rem qt5/win32/lib/Qt5WebKit.dll
rem qt5/win32/lib/Qt5WebKitWidgets.dll
rem qt5/win32/lib/Qt5Widgets.dll
rem qt5/win32/platforms/qwindows.dll

rem However, using windeployqt to deploy Perl Executing Browser and its dependancies is recommended.

rem Tested with Qt 5.2.0.

export LD_LIBRARY_PATH

SET PATH=%cd%\qt5\win32\lib;%PATH%
SET QT_QPA_PLATFORM_PLUGIN_PATH=%cd%\qt5\win32\platforms
peb-qt5.exe
