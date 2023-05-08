@echo off

rem Step 1: Check if resource.car file exists
if not exist resource.car (
  echo Put your resource.car in the folder
  exit /b
)

echo resource.car file found

rem Step 2: Check if corona-archiver.py file exists
if not exist corona-archiver.py (
  echo Download Corona Archiver and put it in this folder
  exit /b
)

echo Corona Archiver file found

rem Step 3: Check if unluac_2021_06_10.jar file exists
if not exist unluac_2021_06_10.jar (
  echo Download unluac_2021_06_10.jar and put it in this folder
  exit /b
)

echo Unluac file found

rem Step 4: Create Compilated and Decompilated folders
if exist Compilated rmdir /s /q Compilated
if exist Decompilated rmdir /s /q Decompilated

mkdir Compilated
mkdir Decompilated

echo Created Compilated and Decompilated folders

rem Step 5: Run corona-archiver.py command
python corona-archiver.py -u resource.car Compilated/

echo Extracting files from resource.car

rem Step 6: Loop through files in Compilated folder and run unluac command
for %%f in (Compilated\*) do (
  if /I "%%~nxf"=="build.settings" (
    java -jar unluac_2021_06_10.jar "Compilated\%%~nxf" > "Decompilated\%%~nf.settings"
  ) else (
    java -jar unluac_2021_06_10.jar "Compilated\%%~nxf" > "Decompilated\%%~nf.lua"
    echo Decompiling %%~nxf
  )
)

echo Decompilation complete

rem Step 7: Delete Compilated folder
rmdir /s /q Compilated

echo Deleted Compilated folder

rem Step 8: Print success message
echo Success, files are located in Decompilated folder
