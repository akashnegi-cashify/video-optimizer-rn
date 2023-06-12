#!/usr/bin/env bash

#set -u -e -o pipefail

#cd "$file"

admin_ui="flutter_admin_ui"
packages="flutter_packages"

echo "Enter project name"
echo "1. $admin_ui"
echo "2. $packages"
read -r input

if [ $input == "1" ]; then
  project=$admin_ui
else
  project=$packages
fi

dart run ./scripts/read_current_versions.dart "$project.git"

echo "Enter updated version"
read -r version

if [ -e pubspec.yaml ]; then

  sed -i '' '/.*'"$project"'.git/,/ref:.*/c\
      url: https://github.com/reglobe/'"$project"'.git\
      ref: '"$version"'\
' pubspec.yaml

fi

echo "run flutter pub get, press (y) for yes, (n) for no"
read -r value

if [ $value == "y" ]; then
  flutter pub get
fi
