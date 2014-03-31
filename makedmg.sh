#!/bin/sh

macdeployqt_bin=$(which macdeployqt)
peb_bundle=$1

create_dmg() {
  echo "Starting package creation..."
  echo "$macdeployqt_bin $peb_bundle -dmg"
  $macdeployqt_bin $peb_bundle -dmg
  outdir=$(dirname $peb_bundle)
  ls "$outdir/peb.dmg"
  echo "Finished."
}

echo "Perl Executing Browser DMG Packer, v0.2"
echo "Usage: makedmg.sh peb.app"
echo 

if [ -z "$macdeployqt_bin" ]
	then
	echo "No macdeployqt found in PATH"
	if [ -z "$QTDIR" ]
		then
	    echo "Need to set QTDIR environment variable."
	    echo "Enter full path to the main Qt SDK directory:"
	    read qtdirname
	    set QTDIR = $qtdirname
	    if [ -z "$QTDIR" ]
	    	then
	    	echo "No QTDIR was set. I have quit now."
	    	exit
	    fi
	    echo ""
	fi
	macdeployqt_bin="$QTDIR/bin/macdeployqt"
fi

if [ -z "$1" ]
	then
    echo "No command line argument supplied."
    echo "Trying to guess where peb.app is."
    peb_bundle=$(ls -d */peb.app)
    if [ -z "$peb_bundle" ]
        then
        echo "Enter full or relative path to peb.app: "
        read peb_bundle
    else
        echo "Found [$peb_bundle]"
    fi
fi

create_dmg
exit 0
