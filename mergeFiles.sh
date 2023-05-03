#!/bin/bash
scriptPath="$( cd -- $(dirname $0) >/dev/null 2>&1 ; pwd -P )"

basePath=$scriptPath/data

path="$(echo $1 | rev | cut -d"/" -f2-  | rev)"
addedPath=${path//$basePath/}
fileName=$(echo $1 | rev | cut -d"/" -f1 | rev)

fileEnd=$(echo $fileName | rev | cut -d"." -f1 | rev)
fileRest="$(echo $fileName | rev | cut -d"." -f2-  | rev)"
SYNC_STUB='sync-conflict'

#test.sync-conflict-20230503-000534-BKYYLMD.md
SYNC_STUB='sync-conflict'
if [[ "$fileName" == *"$SYNC_STUB"* ]] && [ -f "$1" ]; then
  if [[ "$fileEnd" == *"$SYNC_STUB"* ]]; then
    fileEnd=""
    echo "path $path/$fileName | $fileRest $fileEnd" 
  else
    fileRest="$(echo $fileRest | rev | cut -d"." -f2-  | rev)"
  fi
  if [ -z "$var" ]; then
    origFile="$fileRest.$fileEnd"
  else
    origFile=$fileRest
  fi
  git merge-file "$path/$origFile" "$basePath/.stversions/$addedPath/$origFile" "$path/$fileName" --union
  rm "$path/$fileName"
  sleep 0.1
  #echo "$path/$origFile $basePath/.stversions/$addedPath/$origFile $path$/fileName" 
#else 
 #echo "[$fileName]"
fi


