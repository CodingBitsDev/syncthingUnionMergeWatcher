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
conflictFile="test.sync-conflict-20230503-000534-BKYYLMD$RANDOM.md"
histFIle1="test~20230507-130111.md"
histFIle2="test~20230507-131003.md"

#Create files and history files
echo "1" > ./$folder/test.md
touch ./$folder/.stversions/test
cp ./$folder/test.md ./$folder/.stversions/$histFIle1
echo "2" >> ./$folder/test.md
#cp ./$folder/test.md ./$folder/.stversions/$histFIle2

#Create conflictFile
cp ./$folder/test.md ./$conflictFile
echo "3" >> ./$folder/test.md
echo "a" >> ./$conflictFile
cp ./$conflictFile ./$folder
rm ./$conflictFile
