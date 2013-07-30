#!/bin/bash
find -name "*.pyo" | xargs rm
find -name "*.py" | xargs rm
find -name "*.a" | xargs rm
chmod +w lib/libpython2.7.so
find -name "*.so" | xargs /var/lib/jenkins/tools/android-ndk-r9/toolchains/x86-4.6/prebuilt/linux-x86/bin/i686-linux-android-strip

rm -rf share/
rm -rf bin/
rm -rf lib/pkgconfig/

pushd include
mv python2.7/pyconfig.h .
rm -rf python2.7/*
mv pyconfig.h python2.7/
popd

pushd lib/python2.7
rm site-packages/README
mv site-packages/* .
rm -rf site-packages/
rm -rf ctypes/
rm -rf pkgconfig/
rm -rf sqlite3/
rm -rf email/
rm -rf lib2to3/
rm -rf distutils/
rm -rf bsddb/
rm -rf pydoc*
rm -rf test/
rm -rf multiprocessing/
rm -rf lib-tk/
rm -rf idlelib/
rm -rf unittest/
rm -rf wsgiref/
rm -rf xml/
rm -rf compiler/
rm -rf curses/
rm mailbox.pyc
rm pdb.pyc
rm ftplib.pyc
rm bdb.pyc
rm audiodev.pyc
popd
