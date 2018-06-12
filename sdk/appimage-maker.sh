#!/usr/bin/env bash

cd .. || exit

if [ ! -e ./peb.app ]; then
  mkdir ./peb.app
fi

if [ -e ./peb ]; then
  cp -f ./peb ./peb.app/peb
else
  cd ./src || exit

  qmake -qt=qt5
  make

  cd .. || exit
  cp -f ./peb ./peb.app/peb
fi

cp ./sdk/peb.desktop ./peb.app/peb.desktop
cp ./src/resources/icon/camel.png ./peb.app/peb.png

cp -rf ./resources ./peb.app/resources

relocatable_perl="$(pwd)/perl/bin/perl"
compactor_script="$(pwd)/sdk/compactor.pl"

if [ -e "$relocatable_perl" ]; then
  printf "\\nGoing to compact the relocatable Perl for this copy of Perl Executing Browser.\\n"
  "$relocatable_perl" "$compactor_script" "--AppImage"
else
  printf "\\nRelocatable Perl is not found for this copy of Perl Executing Browser.\\n"
fi

linuxdeployqt="linuxdeployqt-continuous-$(arch).AppImage"

if [ ! -x "$linuxdeployqt" ]; then
  wget --tries=5 --unlink "https://github.com/probonopd/linuxdeployqt/releases/download/continuous/$linuxdeployqt"
  chmod -v a+x "$linuxdeployqt"
fi

"./$linuxdeployqt" ./peb.app/peb -qmake='qmake -qt=qt5' -no-translations -appimage
