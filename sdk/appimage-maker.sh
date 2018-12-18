#!/usr/bin/env bash

cd .. || exit

if [ ! "$(arch)" == "x86_64" ]; then
  printf "\\nAppImage executable can be created only on and for 64-bit Linux distributions.\\n"
  exit 1
fi

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

cp ./sdk/appimage/peb.desktop ./peb.app/peb.desktop
cp ./sdk/appimage/camel.png ./peb.app/peb.png
mkdir -p ./peb.app/usr/share/metainfo
cp ./sdk/appimage/peb.appdata.xml ./peb.app/usr/share/metainfo/peb.appdata.xml

for i in "$@"
  do
  case $i in
    --include-resources)
      cp -rf ./resources ./peb.app/resources
      cp ./resources/app.png ./peb.app/peb.png

      relocatable_perl="$(pwd)/resources/app/perl/bin/perl"
      compactor_script="$(pwd)/sdk/compactor.pl"

      if [ -e "$relocatable_perl" ]; then
        printf "\\nGoing to compact the relocatable Perl for this copy of Perl Executing Browser.\\n"
        "$relocatable_perl" "$compactor_script" "--AppImage"
      else
        printf "\\nRelocatable Perl is not found for this copy of Perl Executing Browser.\\n"
      fi
    ;;
  esac
done

linuxdeployqt="linuxdeployqt-continuous-$(arch).AppImage"

if [ ! -x "$linuxdeployqt" ]; then
  wget --tries=5 --unlink "https://github.com/probonopd/linuxdeployqt/releases/download/continuous/linuxdeployqt-continuous-x86_64.AppImage"
  chmod -v a+x "$linuxdeployqt"
fi

"./$linuxdeployqt" ./peb.app/peb -qmake='qmake -qt=qt5' -no-translations -appimage
