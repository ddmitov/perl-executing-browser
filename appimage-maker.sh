#!/usr/bin/env bash

make_appimage() {
  printf "\nGoing to create an AppImage from this copy of Perl Executing Browser.\n\n"
  ./linuxdeployqt-continuous-x86_64.AppImage ./peb.app/peb -qmake=${qmake} -no-translations
  ./linuxdeployqt-continuous-x86_64.AppImage ./peb.app/peb -qmake=${qmake} -no-translations -appimage
}

mkdir peb.app

cp peb peb.app/peb
cp -r perl peb.app/perl
cp -r resources peb.app/resources

cp sdk/peb.desktop peb.app/peb.desktop
cp src/resources/icon/camel.png peb.app/peb.png

cp -r sdk peb.app/sdk
cd peb.app

relocatable_perl="./perl/bin/perl"
if [ -e "$relocatable_perl" ]; then
  printf "\nGoing to compact the relocatable Perl for this copy of Perl Executing Browser.\n"
  $relocatable_perl ./sdk/compactor.pl --nobackup
else
  printf "\nRelocatable Perl is not found for this copy of Perl Executing Browser.\n"
fi

rm -rf sdk
cd ..

if [ ! -x linuxdeployqt-continuous-x86_64.AppImage ]; then
  wget --tries=5 --unlink "https://github.com/probonopd/linuxdeployqt/releases/download/continuous/linuxdeployqt-continuous-x86_64.AppImage"
  chmod -v a+x linuxdeployqt-continuous-x86_64.AppImage
fi

qmake=$(ldd ./peb | grep libQt5Core | cut -d' ' -f3 | sed 's/lib\/libQt5Core.*/bin\/qmake/')

if [ -e "$qmake" ]; then
  make_appimage
else
  qmake=$(qmake -qt=qt5 --version | grep Using | cut -d' ' -f6)
  qmake=$qmake/qt5/bin/qmake
  make_appimage
fi
