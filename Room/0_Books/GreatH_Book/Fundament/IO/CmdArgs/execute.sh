#!/bin/sh
ghc Args.hs
./Args "arg1" "arg2" "arg3"
rm Args Args.hi Args.o
