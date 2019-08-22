#!/usr/bin/env bash

cd .. || exit

if [ ! "$(arch)" == "x86_64" ]; then
  printf "\\nAppImage executable can be created only on and for 64-bit Linux distributions.\\n"
  exit 1
fi

mode="none"

for i in "$@"
  do
  case $i in
    --include-resources)
      mode="include-resources"
    ;;
  esac

  case $i in
    --no-resources)
      mode="no-resources"
    ;;
  esac
done

if [ $mode == "none" ]; then
  printf "appimage-maker --include-resources\\n"
  printf " to pack a PEB-based application or\\n"
  printf "appimage-maker --no-resources\\n"
  printf " to pack only a PEB executable\\n"
  exit 1
fi

if [ ! -e "$(pwd)/peb" ]; then
  cd "$(pwd)/src" || exit

  qmake -qt=qt5
  make

  cd .. || exit
fi

linuxdeployqt="linuxdeployqt-continuous-$(arch).AppImage"

if [ ! -x "$linuxdeployqt" ]; then
  wget --tries=5 --unlink "https://github.com/probonopd/linuxdeployqt/releases/download/continuous/linuxdeployqt-continuous-x86_64.AppImage"
  chmod -v a+x "$linuxdeployqt"
fi

if [ $mode == "no-resources" ]; then
  rm -rf "$(pwd)/peb.app"
  mkdir "$(pwd)/peb.app"

  cp "$(pwd)/peb" "$(pwd)/peb.app/peb"
  cp "$(pwd)/sdk/appimage/peb.desktop" "$(pwd)/peb.app/peb.desktop"
  cp "$(pwd)/src/resources/icon/camel.png" "$(pwd)/peb.app/app.png"

  mkdir -p "$(pwd)/peb.app/usr/share/metainfo"
  cp "$(pwd)/sdk/appimage/peb.appdata.xml" "$(pwd)/peb.app/usr/share/metainfo/peb.appdata.xml"

  cp -r "$(pwd)/doc" "$(pwd)/peb.app/doc"
  cp "$(pwd)/CREDITS.md" "$(pwd)/peb.app/CREDITS.md"
  cp "$(pwd)/LICENSE.md" "$(pwd)/peb.app/LICENSE.md"
  cp "$(pwd)/README.md" "$(pwd)/peb.app/README.md"

  "$(pwd)/$linuxdeployqt" "--appimage-extract"
  "$(pwd)/squashfs-root/AppRun" "$(pwd)/peb.app/peb" -qmake='qmake -qt=qt5' -no-translations -appimage

  rm -rf "$(pwd)/peb.app"
  rm -rf "$(pwd)/squashfs-root"
fi

if [ $mode == "include-resources" ]; then
  package_desktop_file="$(ls ./resources/app/*.desktop)"
  if [ ! -e "$package_desktop_file" ]; then
    printf "\\nPackage .desktop file is missing!\\n"
    exit 1
  fi

  appimage_name="$(basename "$package_desktop_file" .desktop)"

  rm -rf "$(pwd)/$appimage_name.app"
  mkdir "$(pwd)/$appimage_name.app"

  cp -f "$(pwd)/peb" "$(pwd)/$appimage_name.app/$appimage_name"
  cp -f "$package_desktop_file" "$(pwd)/$appimage_name.app/$appimage_name.desktop"

  mkdir "$(pwd)/$appimage_name.app/resources/"

  declare -a RESOURCES
  RESOURCES=($(ls --ignore=perl "$(pwd)/resources"))

  for RESOURCE in "${RESOURCES[@]}"; do
  	cp -r "$(pwd)/resources/${RESOURCE}" "$(pwd)/$appimage_name.app/resources/${RESOURCE}";
  done

  if [ -e "$(pwd)/resources/app.png" ]; then
    cp -f "$(pwd)/resources/app.png" "$(pwd)/$appimage_name.app/app.png"
  fi

  if [ -e "$(pwd)/resources/app/$appimage_name.appdata.xml" ]; then
    mkdir -p "$(pwd)/$appimage_name.app/usr/share/metainfo"
    cp -f "$(pwd)/resources/app/$appimage_name.appdata.xml" "$(pwd)/$appimage_name.app/usr/share/metainfo/$appimage_name.appdata.xml"
  fi

  rm -f "$(pwd)/$appimage_name.app/resources/app/$appimage_name.desktop"
  rm -f "$(pwd)/$appimage_name.app/resources/app/$appimage_name.appdata.xml"

  cp -r "$(pwd)/doc" "$(pwd)/$appimage_name.app/doc"
  cp "$(pwd)/CREDITS.md" "$(pwd)/$appimage_name.app/CREDITS.md"
  cp "$(pwd)/LICENSE.md" "$(pwd)/$appimage_name.app/LICENSE.md"
  cp "$(pwd)/README.md" "$(pwd)/$appimage_name.app/README.md"

  if [ $appimage_name == "peb-demo" ]; then
    export VERSION="1.0.0"
    rm -f "$(pwd)/$appimage_name.app/resources/app/index-windows.html"
    rm -f "$(pwd)/$appimage_name.app/resources/app/perl-scripts/clock.pl"
    rm -f "$(pwd)/$appimage_name.app/resources/app/perl-scripts/input.pl"
  fi

  relocatable_perl="$(pwd)/resources/perl/bin/perl"
  compactor_script="$(pwd)/sdk/compactor.pl"

  if [ -e "$relocatable_perl" ]; then
    printf "\\nGoing to compact the relocatable Perl for this copy of Perl Executing Browser.\\n"
    "$relocatable_perl" "$compactor_script" "--appimage=$appimage_name"
  else
    printf "\\nRelocatable Perl is not found for this copy of Perl Executing Browser.\\n"
  fi

  "$(pwd)/$linuxdeployqt" "--appimage-extract"
  "$(pwd)/squashfs-root/AppRun" "$(pwd)/$appimage_name.app/$appimage_name" -qmake='qmake -qt=qt5' -no-translations -appimage

  rm -rf "$(pwd)/squashfs-root"
  rm -rf "$(pwd)/$appimage_name.app"
fi
