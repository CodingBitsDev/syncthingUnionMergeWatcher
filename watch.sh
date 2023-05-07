
#!/bin/bash
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

shopt -s globstar
cd $1

#wait until folder is a syncthing folder
path=$(pwd)
until [ -d "$path/.stfolder" ]; do
    echo "Not a Syncthing folder. .stfolder is missing"
    sleep 5;
done
 
##Run initially
for i in ./**/*
do
    filePath="$path/${i//.\//}"
    $SCRIPTPATH/mergeFiles.sh $filePath;
done;
cd $SCRIPTPATH

##WatchForChange
fswatch -0 -r $1 | xargs -0 -n 1 -I {} $SCRIPTPATH/mergeFiles.sh {}

