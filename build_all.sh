#!/bin/bash

GUID=$1
if [ ! $GUID ];then
	echo "1st param must be the GUID of the simulator"
	ERROR=1
fi

test $ERROR && exit $ERROR
script_dir=`dirname $0`

# if XCODEs are not set with the environment varialble
# try to set from the script
if [ x$XCODES = x ]; then
. "$script_dir/xcodes.sh"
fi

# XCODES is the list of versions
for xcode in $XCODES;do
	sudo xcode-select -s "/Applications/$XCODE.app"

	project=`echo $xcode|tr [:upper:] [:lower:]|sed 's/[_.]//g'`
	target=`basename $project`

	#build the release of the application
	$script_dir/build.sh "$xcode" "$project" "$target" Release
	ec=$?
	echo "exit code: $ec"
	test $ec -ne 0 &&  exit $ec

	#try to run in the simulator
	$script_dir/sim.sh "$xcode" "$project" Debug $GUID
	ec=$?
	echo "exit code: $ec"
	test $ec -ne 0 &&  exit $ec

	#build the debug of the application
	$script_dir/build.sh "$xcode" "$project" "$target" Debug
	ec=$?
	echo "exit code: $ec"
	test $ec -ne 0 &&  exit $ec

	#try to run in the simulator
	$script_dir/sim.sh "$xcode" "$project" Debug $GUID
	ec=$?
	echo "exit code: $ec"
	test $ec -ne 0 &&  exit $ec
done
