#!/bin/bash

VERSION_gevent=1.0rc2
URL_gevent=https://gevent.googlecode.com/files/gevent-1.0rc2.tar.gz
DEPS_gevent=(greenlet hostpython python)
MD5_gevent=3061c1c431b83b730e64a547f9fb82c0 
BUILD_gevent=$BUILD_PATH/gevent/$(get_directory $URL_gevent)
RECIPE_gevent=$RECIPES_PATH/gevent

function prebuild_gevent() {
	true
}

function build_gevent() {

    if [ -d "$BUILD_PATH/python-install/lib/python3.3/site-packages/gevent" ]; then
        return
    fi

	cd $BUILD_gevent

    mv $BUILD_PATH/python-install/lib/python3.3/lib-dynload $BUILD_PATH/python-install/lib/python3.3/lib-dynload.bak 
    cp -R $BUILD_PATH/python_host/lib/python3.3/lib-dynload $BUILD_PATH/python-install/lib/python3.3/

	push_arm

    export GEVENT_RESOLVER="ares"
    export CC="$CC -DANDROID" 
	try patch -p1 < $RECIPE_gevent/android.patch

	try $BUILD_PATH/python-install/bin/python.host setup.py build
	try find build/lib.* -name "*.o" -exec $STRIP {} \;
	try find build/lib.* -name "*.so" -exec $STRIP {} \;

	try $BUILD_PATH/python-install/bin/python.host setup.py install -O2 

	pop_arm

    rm -rf $BUILD_PATH/python-install/lib/python3.3/lib-dynload
    mv $BUILD_PATH/python-install/lib/python3.3/lib-dynload.bak $BUILD_PATH/python-install/lib/python3.3/lib-dynload
}

function postbuild_gevent() {
	true
}
