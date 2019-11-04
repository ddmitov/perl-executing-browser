#!/usr/bin/env bash

# Version:
export VERSION="1.0.0"

# Architecture check:
if [ ! "$(arch)" == "x86_64" ]; then
  printf "\\nAppImage executable can be created only on and for 64-bit Linux distributions.\\n"
  exit 1
fi

# Go to to PEB source directory:
cd "$(pwd)/src" || exit

# Remove temporary files:
rm -rf tmp
rm -f .qmake.stash
rm -f Makefile

# Compile PEB:
qmake -qt=qt5
make

# Go back to the PEB root directory:
cd .. || exit

# If no 'linuxdeployqt' is found, it is downloaded from the web:
linuxdeployqt="linuxdeployqt-continuous-$(arch).AppImage"
if [ ! -x "$linuxdeployqt" ]; then
  wget --tries=5 --unlink "https://github.com/probonopd/linuxdeployqt/releases/download/continuous/linuxdeployqt-continuous-x86_64.AppImage"
  chmod -v a+x "$linuxdeployqt"
fi

# AppImage desktop file is mandatory:
package_desktop_file="$(ls ./resources/app/appimage/*.desktop)"
if [ ! -e "$package_desktop_file" ]; then
  printf "\\nPackage .desktop file is missing!\\n"
  exit 1
fi

# AppImage name:
appimage_name="$(basename "$package_desktop_file" .desktop)"

# Temporary directory for the creation of the AppImage:
rm -rf "$(pwd)/$appimage_name.app"
mkdir "$(pwd)/$appimage_name.app"

# Main executable:
cp -f "$(pwd)/peb" "$(pwd)/$appimage_name.app/$appimage_name"

# Desktop file:
cp -f "$package_desktop_file" "$(pwd)/$appimage_name.app/$appimage_name.desktop"

# AppImage icon:
if [ -e "$(pwd)/resources/app.png" ]; then
  cp -f "$(pwd)/resources/app.png" "$(pwd)/$appimage_name.app/app.png"
fi

# AppImage metadata file:
if [ -e "$(pwd)/resources/app/appimage/$appimage_name.appdata.xml" ]; then
  mkdir -p "$(pwd)/$appimage_name.app/usr/share/metainfo"
  cp -f "$(pwd)/resources/app/appimage/$appimage_name.appdata.xml" "$(pwd)/$appimage_name.app/usr/share/metainfo/$appimage_name.appdata.xml"
fi

# Documentation:
cp -r "$(pwd)/doc" "$(pwd)/$appimage_name.app/doc"
cp "$(pwd)/CREDITS.md" "$(pwd)/$appimage_name.app/CREDITS.md"
cp "$(pwd)/LICENSE.md" "$(pwd)/$appimage_name.app/LICENSE.md"
cp "$(pwd)/README.md" "$(pwd)/$appimage_name.app/README.md"

# Resources:
cp -r "$(pwd)/resources" "$(pwd)/$appimage_name.app/resources"

# File cleaning:
rm -f "$(pwd)/$appimage_name.app/resources/app/$appimage_name.desktop"
rm -f "$(pwd)/$appimage_name.app/resources/app/$appimage_name.appdata.xml"

# Extraction of the contents of 'linuxdeployqt' tool -
# it is necessary for operation inside the PEB AppImage Builder Docker Container:
if [ -x "$linuxdeployqt" ]; then
  "$(pwd)/$linuxdeployqt" "--appimage-extract"
else
  printf "\\n$linuxdeployqt is missing!\\n"
  exit 1
fi

# AppImage generation:
"$(pwd)/squashfs-root/AppRun" "$(pwd)/$appimage_name.app/$appimage_name" -qmake='qmake -qt=qt5' -no-translations -appimage

# Removal of the temporary directories:
rm -rf "$(pwd)/squashfs-root"
rm -rf "$(pwd)/$appimage_name.app"
