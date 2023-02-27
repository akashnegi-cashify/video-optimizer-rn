#!/usr/bin/env bash

set -u -e -o pipefail

clean=false
pending=false

for ARG in "$@"; do
  case "$ARG" in
  --clean)
    clean=true
    ;;
  --pending)
    pending=true
    ;;
  --help)
    echo "--clean : " "Run through with flutter clean"
    echo "--pending : " "Run where pubspec.lock file is not generated"
    echo
    exit 1
    ;;
  *)
    echo "ERROR : " "Unknown option $ARG."
    exit 1
    ;;
  esac
done

function mClean() {
  if [[ ${clean} == true ]]; then
    echo "flutter clean"
    flutter clean
  fi
}

function pubGet() {
  if [ ! -e pubspec.lock ]; then
    echo "flutter pub get"
    flutter pub get
  fi
}

function deleteLock() {
  if [[ ${pending} == false ]]; then
    echo "deleting pubspec.lock"
    rm -vf pubspec.lock
  fi
}

for file in ./*; do
  if [[ ! -f $file ]]; then
    cd "$file"
    if [ -e pubspec.yaml ]; then
      echo "-------------------- $file --------------------"
      deleteLock
      mClean
      pubGet
      sleep 3
    else
      echo "not a flutter module $file"
    fi
    cd ..
  fi
done
