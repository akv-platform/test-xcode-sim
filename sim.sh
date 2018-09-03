#!/bin/bash
XCODE=$1
PROJECT=$2
CONFIGURATION=$3
GUID=$4


if [ ! $XCODE ];then
	echo "1st param must be the name of Xcode within /Application dir without .app extention"
	ERROR=1
fi

if [ ! $PROJECT ];then
	echo "2nd param must be the folder name of the project to build"
	ERROR=1
fi

if [ "x$CONFIGURATION" != xDebug -a "x$CONFIGURATION" != xRelease ];then
	echo "3rd param must be either Debug or Release, $CONFIGURATION got "
	ERROR=1
fi

if [ ! $GUID ];then
	echo "4th param must be the GUID of the simulator"
	ERROR=1
fi

test $ERROR && exit $ERROR

if [ ! -d "$PROJECT" ];then
	echo "$PROJECT directory does not exist"
	exit 2
fi

pwd
app=`ls -d $PROJECT/build/$CONFIGURATION-iphoneos/*.app`
ec=$?
echo "Exit code=$ec"
test $ec -eq 0 || exit $ec

sudo xcode-select -s "/Applications/$XCODE.app"
ec=$?
echo "Exit code=$ec"
test $ec -eq 0 || exit $ec


echo "Start shutdown booted if any"
xcrun simctl shutdown booted

echo "Start simulator $GUID for XCode=$XCODE"
xcrun simctl boot $GUID
ec=$?
echo "Exit code=$ec"
test $ec -eq 0 || exit $ec

echo "Wait 25 sec"
sleep 25
echo "try to open safari"
xcrun simctl openurl booted http://google.com
ec=$?
echo "Exit code=$ec"
test $ec -eq 0 || exit $ec

echo "instal app: $app"
xcrun simctl install booted "$app"
ec=$?
echo "Exit code=$ec"
test $ec -eq 0 || exit $ec

appid=test.`basename "$app"|sed 's/.app//'`
echo "launch app: $id"
xcrun simctl launch booted $appid
ec=$?
echo "Exit code=$ec"
test $ec -eq 0 || exit $ec

echo "get screenshot: $id.png"
xcrun simctl io booted screenshot "$id.png"
ec=$?
echo "Exit code=$ec"
test $ec -eq 0 || exit $ec

echo "terminate: $id"
xcrun simctl terminate booted $id
ec=$?
echo "Exit code=$ec"
test $ec -eq 0 || exit $ec

echo "uninstall: $id"
xcrun simctl uninstall booted $id
ec=$?
echo "Exit code=$ec"
test $ec -eq 0 || exit $ec

echo "shutdown similator"
xcrun simctl shutdown booted
ec=$?
echo "Exit code=$ec"
test $ec -eq 0 || exit $ec

