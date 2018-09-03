#!/bin/bash
GUID=$1
if [ ! $GUID ];then
	echo "1st param must be the GUID of the simulator"
	ERROR=1
fi

test $ERROR && exit $ERROR
script_dir=`dirname $0`
. "$script_dir/xcodes.sh"
for xcode in $XCODES;do
	project=`echo $xcode|tr [:upper:] [:lower:]|sed 's/[_.]//g'`
	target=`basename $project`
	$script_dir/sim.sh "$xcode" "$project" Release $GUID
	ec=$?
	echo "exit code: $ec"
	test $ec -ne 0 &&  exit $ec
	$script_dir/sim.sh "$xcode" "$project" Debug $GUID
	ec=$?
	echo "exit code: $ec"
	test $ec -ne 0 &&  exit $ec
done
