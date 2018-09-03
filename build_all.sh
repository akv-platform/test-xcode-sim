#!/bin/bash
script_dir=`dirname $0`
. "$script_dir/xcodes.sh"
for xcode in $XCODES;do
	project=`echo $xcode|tr [:upper:] [:lower:]|sed 's/[_.]//g'`
	target=`basename $project`
	$script_dir/build.sh "$xcode" "$project" "$target" Release
	ec=$?
	echo "exit code: $ec"
	test $ec -ne 0 &&  exit $ec
	$script_dir/build.sh "$xcode" "$project" "$target" Debug
	ec=$?
	echo "exit code: $ec"
	test $ec -ne 0 &&  exit $ec
done
