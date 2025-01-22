#!/usr/bin/env bash

fStageKey="1:81194165828:android:cb0ee785e389584adf3e11"
fBetaKey="1:81194165828:android:83e3d9f031f13326df3e11"
fProdKey="1:81194165828:android:17cea7d1cfbce40fdf3e11"

#RED='\033[0;31m'
GREEN='\033[0;32m'
#YELLOW='\033[0;33m'
#BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo "${GREEN}Enter Environment${NC}"
read -r env

echo "${GREEN}Enter Flavor${NC}"
read -r flavor

echo "${GREEN}Release notes line number range from CHANGELOG${NC}"
echo "${GREEN}Start Line no${NC}"
read -r startLine

echo "${GREEN}End Line no${NC}"
read -r endLine

sed -n "${startLine},${endLine}p" "./CHANGELOG.md" > "./release-notes.txt"

if [ "$flavor" == "" ]; then
  flavor="$env"
fi

if [ "$env" == "stage" ]; then
  fKey=$fStageKey
elif [ "$env" == "beta" ]; then
  fKey=$fBetaKey
else
  fKey=$fProdKey
fi

rm ./pubspec.lock

rm ./.crashlytics/dump_syms.bin

buildCommand="build apk --dart-define=env=$env --flavor $flavor --obfuscate --split-debug-info=mapping"
echo "${GREEN}executing flutter $buildCommand${NC}"
flutter $buildCommand

echo "${GREEN}Start distributing apk to firebase app distribution${NC}"
firebase appdistribution:distribute ./build/app/outputs/flutter-apk/app-$flavor-release.apk --app $fKey --release-notes-file "./release-notes.txt" --groups "trc-tester"

#exportedCrashlyticsTool="CRASHLYTICS_LOCAL_JAR=/Users/apple/Downloads/firebase-crashlytics-buildtools-2.9.1.jar"
#echo "${GREEN}export $exportedCrashlyticsTool ${NC}"
#export $exportedCrashlyticsTool

echo "${GREEN}uploading debug symbols to firebase${NC}"
firebase crashlytics:symbols:upload --app=$fKey ./mapping
