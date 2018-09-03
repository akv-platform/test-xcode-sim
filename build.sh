#!/bin/bash
XCODE=$1
PROJECT=$2
TARGET=$3
CONFIGURATION=$4

xcode-select -s "/Applications/$XCODE.app"
cd "$PRODJECT"
xcodebuild clean build CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO -target $3 -configuration $4
