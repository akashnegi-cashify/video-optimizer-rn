#!/usr/bin/env bash

#dirName=/Users/ravi/Downloads/assets_Before

declare inputDir
declare outputDir
declare fileName

for ARG in "$@"; do
  case "$ARG" in
  --input=*)
    inputDir=${ARG#--input=}
    ;;
  -i=*)
    inputDir=${ARG#-i=}
    ;;
  --output=*)
    outputDir=${ARG#--output=}
    ;;
  -o=*)
    outputDir=${ARG#-o=}
    ;;
  --file_name=*)
    fileName=${ARG#--file_name=}
    ;;
  -fn=*)
    fileName=${ARG#-fn=}
    ;;
  *)
    echo "Unknown option $ARG."
    exit 1
    ;;
  esac
done

echo "${inputDir}, ${outputDir}, ${fileName}"

if [ "${inputDir}" == null ]; then
  echo "no input dir provider, please use --input option to provide directory"
  exit 1
fi

# remove ~ from starting
if [[ ${inputDir:0:1} == "~" ]]; then
  inputDir="${inputDir:1}"
fi

if [ -z "$outputDir" ]; then
  echo "default outputDir is = ~/Workspace/Flutter/flutter_cashify_app/assets/icons/"
  outputDir="~/Workspace/Flutter/flutter_cashify_app/assets/icons/"
#  outputDir="~/Workspace/flutter_projects/flutter_cashify_app/assets/icons/"
#  exit 1
fi

#if [ -z "$outputDir" ]; then
#  outputDir="${PWD}/assets/icons/pngs"
#fi

# remove ~ from starting
if [[ ${outputDir:0:1} == "~" ]]; then
  outputDir="${outputDir:1}"
fi

if [ -z "$fileName" ]; then
  fileName=${inputDir##*/}
fi

echo "outputDir=${outputDir}"

MDPI="1.0x"
HDPI="1.5x"
XHDPI="2.0x"
XXHDPI="3.0x"
XXXHDPI="4.0x"
devicePixel=MDPI

for dir in ~/${inputDir}*/; do

  echo "${dir}"

  cd "${dir}" || exit

  #get folder name
  echo "pwd = ${PWD}"
  folder=${PWD##*/}
  echo "${folder}"

  case $folder in
  "drawable-mdpi")
    devicePixel=$MDPI
    ;;
  "drawable-hdpi")
    devicePixel=$HDPI
    ;;
  "drawable-xhdpi")
    devicePixel=$XHDPI
    ;;
  "drawable-xxhdpi")
    devicePixel=$XXHDPI
    ;;
  "drawable-xxxhdpi")
    devicePixel=$XXXHDPI
    ;;
  *)
    devicePixel='unknown'
    ;;
  esac

  outputSubDir=''
  if [ "$devicePixel" != $MDPI ]; then
    outputSubDir="${devicePixel}"
  fi

  echo $devicePixel

  if [ $devicePixel == 'unknown' ]; then
    exit 1
  fi

  fileDir=~/"${outputDir}${outputSubDir}"

  if [ ! -d "$fileDir" ]; then
    echo "creating dir $fileDir ..."
    mkdir -p "$fileDir"
  fi

  for f in *.png; do
    cp "$f" "$fileDir/$fileName"
  done
  #cd ..
  #cat "${dir}"style.scss >>"${dir}"_style.scss
  #rm "${dir}"style.scss
done
