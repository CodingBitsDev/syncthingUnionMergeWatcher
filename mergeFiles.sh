#!/bin/bash
scriptPath="$( cd -- $(dirname $0) >/dev/null 2>&1 ; pwd -P )"

fileName=$(echo $1 | rev | cut -d"/" -f1 | rev)
path="$(echo $1 | rev | cut -d"/" -f2-  | rev)"

#find path with .stfolder inside since syncthing has that
basePath=$path
while [ ! -d "$basePath/.stfolder" ] && [ ! -z "$basePath" ]; do
  basePath="$(echo $basePath | rev | cut -d"/" -f2-  | rev)"
done

addedPath=${path//$basePath/}

fileEnd=$(echo $fileName | rev | cut -d"." -f1 | rev)
fileRest="$(echo $fileName | rev | cut -d"." -f2-  | rev)"
SYNC_STUB='sync-conflict'

#test.sync-conflict-20230503-000534-BKYYLMD.md
SYNC_STUB='sync-conflict'
#Check if file is sync-conflict and exists (meanning it was created not removed)
if [[ "$fileName" == *"$SYNC_STUB"* ]] && [ -f "$1" ]; then
  if [[ "$fileEnd" == *"$SYNC_STUB"* ]]; then
    fileEnd=""
    echo "path $path/$fileName | $fileRest $fileEnd" 
  else
    fileRest="$(echo $fileRest | rev | cut -d"." -f2-  | rev)"
  fi
  #if no file end just take file rest as the name
  if [ -z "$fileEnd" ]; then
    origFile=$fileRest
  else
    origFile="$fileRest.$fileEnd"
  fi
  commonVersion="$basePath/.stversions/$addedPath/$origFile"
  if [ -f "$commonVersion" ]; then
    git merge-file "$path/$origFile" "$commonVersion" "$path/$fileName" --union
  else
    touch ./empty
    git merge-file "$path/$origFile" "./empty" "$path/$fileName" --union
    rm ./empty
  fi
  rm "$path/$fileName"
  sleep 0.1
  #echo "$path/$origFile $basePath/.stversions/$addedPath/$origFile $path$/fileName" 
#else 
 #echo "[$fileName]"
fi


