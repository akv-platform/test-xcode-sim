#!/bin/bash
XCODE=$1
PROJECT=$2
TARGET=$3
CONFIGURATION=$4

if [ ! $XCODE ];then
	echo "1st param must be the name of Xcode within /Application dir without .app extention"
	ERROR=1
fi

if [ ! $PROJECT ];then
	echo "2nd param must be the folder name of the project to build"
	ERROR=1
fi

if [ ! $TARGET ];then
	echo "3rd param must be the target name set in Xcode"
	ERROR=1
fi

if [ $CONFIGURATION != Debug -a $CONFIGURATION != Release ];then
	echo "4th param must be either Debug or Release, $CONFIGURATION got "
	ERROR=1
fi

test $ERROR && exit $ERROR

xcode-select -s "/Applications/$XCODE.app"
cd "$PROJECT"
xcodebuild clean build CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO -target $3 -configuration $4
