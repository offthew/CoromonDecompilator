#!/bin/bash

# Step 1: Check if resource.car file exists
if [ ! -e resource.car ]; then
  echo "Put your resource.car in the folder"
  exit 1
fi

echo "resource.car file found"

# Step 2: Check if corona-archiver.py file exists
if [ ! -e corona-archiver.py ]; then
  echo "Download Corona Archiver and put it in this folder"
  exit 1
fi

echo "Corona Archiver file found"

# Step 3: Check if unluac_2021_06_10.jar file exists
if [ ! -e unluac_2021_06_10.jar ]; then
  echo "Download unluac_2021_06_10.jar and put it in this folder"
  exit 1
fi

echo "Unluac file found"

# Step 4: Create Compilated and Decompilated folders
if [ -d Compilated ]; then
  rm -rf Compilated
fi

if [ -d Decompilated ]; then
  rm -rf Decompilated
fi

mkdir Compilated
mkdir Decompilated

echo "Created Compilated and Decompilated folders"

# Step 5: Run corona-archiver.py command
python3 corona-archiver.py -u resource.car Compilated/

echo "Extracting files from resource.car"

# Step 6: Loop through files in Compilated folder and run unluac command
for f in Compilated/*; do
  file_name=$(basename "$f")
  file_base_name="${file_name%.*}"
  if [ "$file_name" == "build.settings" ]; then
    java -jar unluac_2021_06_10.jar "Compilated/$file_name" > "Decompilated/$file_base_name.settings"
  else
    java -jar unluac_2021_06_10.jar "Compilated/$file_name" > "Decompilated/$file_base_name.lua"
    echo "Decompiling $file_name"
  fi
done

echo "Decompilation complete"

# Step 7: Delete Compilated folder
rm -rf Compilated

echo "Deleted Compilated folder"

# Step 8: Print success message
echo "Success, files are located in Decompilated folder"
