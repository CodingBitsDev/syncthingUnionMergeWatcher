folder="data";
if [ -d "./$folder" ] 
then
   rm -rf ./$folder 
fi
mkdir ./$folder
cd $folder
mkdir .stversions
mkdir .stfolder
cd ..
sleep 2
syncFile="test.sync-conflict-20230503-000534-BKYYLMD$RANDOM.md"
echo "1" > ./$folder/test.md
echo "2" >> ./$folder/test.md
cp ./$folder/test.md ./$folder/.stversions/test.md
cp ./$folder/test.md ./$syncFile
echo "3" >> ./$folder/test.md
echo "a" >> ./$syncFile
cp ./$syncFile ./$folder
rm ./$syncFile
