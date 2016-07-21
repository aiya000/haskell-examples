#!/bin/sh
files='Redirect Redirect0'

for file in $files ; do
	ghc --make ${file}
	echo
	./${file} < text.txt
	rm ${file}; rm ${file}.hi; rm ${file}.o
	echo '-----'
done
