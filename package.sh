#!/bin/bash

NAME=ncnn

##### package android lib
ANDROIDPKGNAME=${NAME}-android-lib
rm -rf $ANDROIDPKGNAME
mkdir -p $ANDROIDPKGNAME
mkdir -p $ANDROIDPKGNAME/armeabi-v7a
mkdir -p $ANDROIDPKGNAME/arm64-v8a
mkdir -p $ANDROIDPKGNAME/include
cp build-android-armv7/install/lib/lib${NAME}.a $ANDROIDPKGNAME/armeabi-v7a/
cp build-android-aarch64/install/lib/lib${NAME}.a $ANDROIDPKGNAME/arm64-v8a/
cp build-android-aarch64/install/include/* $ANDROIDPKGNAME/include/
rm -f $ANDROIDPKGNAME.zip
zip -9 -r $ANDROIDPKGNAME.zip $ANDROIDPKGNAME

##### package ios framework
IOSPKGNAME=${NAME}.framework
rm -rf $IOSPKGNAME
mkdir -p $IOSPKGNAME/Versions/A/Headers
mkdir -p $IOSPKGNAME/Versions/A/Resources
ln -s A $IOSPKGNAME/Versions/Current
ln -s Versions/Current/Headers $IOSPKGNAME/Headers
ln -s Versions/Current/Resources $IOSPKGNAME/Resources
ln -s Versions/Current/${NAME} $IOSPKGNAME/${NAME}
lipo -extract armv7 build-ios/install/lib/lib${NAME}.a -o build-ios/install/lib/lib${NAME}_armv7.a
lipo -extract armv7s build-ios/install/lib/lib${NAME}.a -o build-ios/install/lib/lib${NAME}_armv7s.a
lipo -extract arm64 build-ios/install/lib/lib${NAME}.a -o build-ios/install/lib/lib${NAME}_arm64.a
lipo -create \
    build-ios/install/lib/lib${NAME}_armv7.a \
    build-ios/install/lib/lib${NAME}_armv7s.a \
    build-ios/install/lib/lib${NAME}_arm64.a \
    build-ios-sim/install/lib/lib${NAME}.a \
    -o $IOSPKGNAME/Versions/A/${NAME}
cp -r build-ios/install/include/* $IOSPKGNAME/Versions/A/Headers/
cp Info.plist ${IOSPKGNAME}/Versions/A/Resources/
rm -f $IOSPKGNAME.zip
zip -9 -y -r $IOSPKGNAME.zip $IOSPKGNAME

