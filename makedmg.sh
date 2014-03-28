#! /bin/sh

echo "Perl Executing Browser DMG Packer, v.0.1"
echo "Usage: makedmg peb.app"
echo " "

if [ -z "$QTDIR" ]; then
    echo "Need to set QTDIR environment variable."
    echo "Enter full path to the main Qt SDK directory:"
    read qtdirname
    set QTDIR = $qtdirname
    echo " "
fi

if [ -z "$1" ]; then
    echo "No command line argument supplied."
    echo "Enter full or relative path to peb.app:"
    read peb_bundle
    echo "Starting package creation..."
    $QTDIR/bin/macdeployqt -dmg $peb_bundle
    echo "Finished."
    exit 0
fi

echo "Starting package creation..."
$QTDIR/bin/macdeployqt -dmg $1
echo "Finished."
