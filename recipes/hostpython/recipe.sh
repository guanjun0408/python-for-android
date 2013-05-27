#!/bin/bash

VERSION_hostpython=3.3.2
URL_hostpython=http://python.org/ftp/python/$VERSION_hostpython/Python-$VERSION_hostpython.tar.bz2
MD5_hostpython=7dffe775f3bea68a44f762a3490e5e28


# must be generated ?
BUILD_hostpython=$BUILD_PATH/hostpython/$(get_directory $URL_hostpython)
RECIPE_hostpython=$RECIPES_PATH/hostpython

function prebuild_hostpython() {
	cd $BUILD_hostpython
}

function build_hostpython() {
	# placeholder for building
	cd $BUILD_hostpython

	# don't do the build if we already got hostpython binary
	if [ -f hostpython ]; then
		return
	fi

    ./configure --prefix="$BUILD_PATH/python_host"
    try make
    try make install
    try cp Parser/pgen hostpgen

	if [ -f python.exe ]; then
		try cp python.exe hostpython
	elif [ -f python ]; then
		try cp python hostpython
	else
		error "Unable to found the python executable?"
		exit 1
	fi
}

function postbuild_hostpython() {
	# placeholder for post build
	true
}
