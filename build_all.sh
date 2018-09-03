#!/bin/bash
script_dir=`dirname $0`
. "$script_dir/xcodes.sh"
for xcode in $XCODES;do
	project=`echo $xcode|tr [:upper:] [:lower:]|sed 's/[_.]//g'`
	target=`basename $project`
	$script_dir/build.sh "$xcode" "$project" "$target" Release
	ec=$?
	test $ec || exit $ec
	$script_dir/build.sh "$xcode" "$project" "$target" Debug
	test $ec || exit $ec
done
