#!/usr/bin/env bash

# DEB 'control' file is required:
if [ ! -e "$(pwd)/deb/DEBIAN/control" ]; then
  printf "\\n control file is missing! \\n\\n"
  exit 1
fi

# Copy the PEB executable:
if [ -e "$(pwd)/peb" ]; then
  mkdir -p "$(pwd)/deb/usr/local/bin"
  cp -f "$(pwd)/peb" "$(pwd)/deb/usr/local/bin/peb"
fi

# If the PEB executable is not found,
# compile it and then copy it in the 'deb' folder:
if [ ! -e "$(pwd)/peb" ]; then
  cd src
  qmake -qt=qt5
  make
  cd ..
  mkdir -p "$(pwd)/deb/usr/local/bin"
  cp -f "$(pwd)/peb" "$(pwd)/deb/usr/local/bin/peb"
fi

# DEB file generation:
dpkg-deb --build --root-owner-group deb peb-qtwebengine-1.0.0-x86_64.deb
