#!/bin/sh

git submodule update --init

for module in $( ls ./.git/modules ); do
	echo "set $module to sparse-checkout"
	cd ${module}
	git config core.sparsecheckout true
	cd ../
	echo '/code-gen' > ./.git/modules/${module}/info/sparse-checkout
	cd ${module}
	git read-tree -mu master
	cd ../
done