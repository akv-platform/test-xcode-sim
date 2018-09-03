#!/bin/bash
script_dir=`dirname $0`
. "$script_dir/xcodes.sh"
for xcode in $XCODES;do
	project=`echo $xcode|tr [:upper:] [:lower:]`
	target=`basename $project`
	$script_dir/build.sh "$xcode" "$project" "$target" Release
	$script_dir/build.sh "$xcode" "$project" "$target" Debug
done
