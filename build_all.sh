#!/bin/bash
script_dir=`dirname $0`
. "$script_dir/xcodes.sh"
for xcode in $XCODES;do
	project=`echo xcode|tr [:upper:] [:lower:]`
	target=project
	$script_dir/build "$xcode" "$project" "$target" Release
	$script_dir/build "$xcode" "$project" "$target" Debug
done
