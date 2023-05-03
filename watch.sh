#!/bin/bash
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

##Run initially
shopt -s globstar
cd $1
path=$(pwd)
 
for i in ./**/*
do
    filePath="$path/${i//.\//}"
    $SCRIPTPATH/mergeFiles.sh $filePath;
done;
cd $SCRIPTPATH

##WatchForChange
fswatch -0 -r $1 | xargs -0 -n 1 -I {} $SCRIPTPATH/mergeFiles.sh {}

