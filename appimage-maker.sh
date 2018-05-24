#!/usr/bin/env bash

mkdir peb.app

cp ./peb ./peb.app/peb
cp ./sdk/peb.desktop ./peb.app/peb.desktop
cp ./src/resources/icon/camel.png ./peb.app/peb.png

cp -r ./perl ./peb.app/perl

cp -r ./resources ./peb.app/resources

# cp -r sdk peb.app/sdk
# relocatable_perl="./peb.app/perl/bin/perl"
#
# if [ -e "$relocatable_perl" ]; then
#   printf "\\nGoing to compact the relocatable Perl for this copy of Perl Executing Browser.\\n"
#   $relocatable_perl ./peb.app/sdk/compactor.pl --nobackup
# else
#   printf "\\nRelocatable Perl is not found for this copy of Perl Executing Browser.\\n"
# fi
#
# rm -rf sdk

if [ ! -x linuxdeployqt-continuous-x86_64.AppImage ]; then
  wget --tries=5 --unlink "https://github.com/probonopd/linuxdeployqt/releases/download/continuous/linuxdeployqt-continuous-x86_64.AppImage"
  chmod -v a+x linuxdeployqt-continuous-x86_64.AppImage
fi

printf "\\nGoing to create an AppImage from this copy of Perl Executing Browser.\\n"
./linuxdeployqt-continuous-x86_64.AppImage ./peb.app/peb -qmake='qmake -qt=qt5' -no-translations -appimage
