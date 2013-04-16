#!/bin/bash

VERSION_greenlet=0.4.0
URL_greenlet=https://pypi.python.org/packages/source/g/greenlet/greenlet-0.4.0.zip
DEPS_greenlet=(hostpython python)
MD5_greenlet=87887570082caadc08fb1f8671dbed71
BUILD_greenlet=$BUILD_PATH/greenlet/$(get_directory $URL_greenlet)
RECIPE_greenlet=$RECIPES_PATH/greenlet

function prebuild_greenlet() {
	true
}

function build_greenlet() {

    if [ -f "$BUILD_PATH/python-install/lib/python2.7/site-packages/greenlet.so" ]; then
        return
    fi

	cd $BUILD_greenlet

	push_arm

	#export CC="$CC -I$BUILD_openssl/include"
	#export LDFLAGS="$LDFLAGS -L$LIBS_PATH -L$BUILD_openssl"

	try $BUILD_PATH/python-install/bin/python.host setup.py build
	try find build/lib.* -name "*.o" -exec $STRIP {} \;
	try find build/lib.* -name "*.so" -exec $STRIP {} \;

	try $BUILD_PATH/python-install/bin/python.host setup.py install -O2

	pop_arm
}

function postbuild_greenlet() {
	true
}
