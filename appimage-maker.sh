#!/usr/bin/env bash

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

if [ "$1" = "--add-resources" ]; then
  cp -rf ./resources ./peb.app/resources

  perl5lib="PERL5LIB=$(pwd)/perl/lib"
  export perl5lib
  relocatable_perl="$(pwd)/perl/bin/perl"
  compactor_script="$(pwd)/sdk/compactor.pl"

  if [ -e "$relocatable_perl" ]; then
    printf "\\nGoing to compact the relocatable Perl for this copy of Perl Executing Browser.\\n"
    "$relocatable_perl" "$compactor_script"

    mkdir ./peb.app/perl
    cp -rf ./perl/bin ./peb.app/perl/bin
    cp -rf ./perl/lib ./peb.app/perl/lib

    rm -rf ./perl/bin
    rm -rf ./perl/lib
    cp ./perl/bin-original ./perl/bin
    cp ./perl/lib-original ./perl/lib
  else
    printf "\\nRelocatable Perl is not found for this copy of Perl Executing Browser.\\n"
  fi
fi

if [ "$1" = "--add-perl-only" ]; then
  cp -rf ./perl ./peb.app/perl
fi

if [ ! -x linuxdeployqt-continuous-x86_64.AppImage ]; then
  wget --tries=5 --unlink "https://github.com/probonopd/linuxdeployqt/releases/download/continuous/linuxdeployqt-continuous-x86_64.AppImage"
  chmod -v a+x linuxdeployqt-continuous-x86_64.AppImage
fi

printf "\\nGoing to create an AppImage from this copy of Perl Executing Browser.\\n"
./linuxdeployqt-continuous-x86_64.AppImage ./peb.app/peb -qmake='qmake -qt=qt5' -no-translations -appimage
