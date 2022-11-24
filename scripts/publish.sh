#!/usr/bin/env bash

set -u -e -o pipefail

readonly currentDir=$(
  cd "$(dirname "$0")"
  pwd
)

#change to root dir
cd "${currentDir}"/..

dryRun=false
skipInstall=false
skipCompile=false
skipPublish=false
clean=false
s3Deploy=false
bucket=''

# include parse_yaml function
source ./scripts/_parse_yaml.sh

# read yaml file
eval $(parse_yaml pubspec.yaml "config_")
versionPrefix="$config_name"
versionSuffix="v$config_web_version"
declare env
for ARG in "$@"; do
  case "$ARG" in
  --skip-install)
    skipInstall=true
    ;;
  --skip-compile)
    skipCompile=true
    skipInstall=true
    ;;
  --skip-publish)
    skipPublish=true
    ;;
  --s3Deploy)
    s3Deploy=true
    ;;
  --env=*)
    case ${ARG#--env=} in
    stage)
      env="stage"
      ;;
    test)
      env="test"
      ;;
    beta)
      env="beta"
      ;;
    prod)
      env="prod"
      ;;
    esac
    ;;
  --dry-run=*)
    dryRun=${ARG#--dry-run=}
    ;;
  --clean)
    clean=true
    ;;
  --help)
    echo "publish <options...>" "publish to server with given options"
    echo "--env" "Run with given environment variable eg <'test', 'stage', 'beta'>"
    echo "--skip-install" "Run through without installing node_modules by using upgrade:cli"
    echo "--skip-compile" "Run through without compiling source code by using yarn build <env...>"
    echo "--dry-run" "Run through without making any changes"
    echo "--clean" "Run through with cleaning previously generated dist directory"
    echo
    exit 1
    ;;
  *)
    echo "ERROR" "Unknown option $ARG."
    exit 1
    ;;
  esac
done

if [[ ${clean} == true ]]; then
  echo "Cleaning dist directory"
  if [[ ${dryRun} == false ]]; then
    rm -rf dist/*
  fi
fi

artifactId="__${versionPrefix}__${versionSuffix}__${env}__"

#check for env
if [[ -z ${env} ]]; then
  echo "unknown env variable please use --env=<options...>"
  exit 1
fi

#if [[ ${skipInstall} == false ]]; then
#  echo 'Installing project dependencies'
#  if [[ ${dryRun} == false ]]; then
#    if yarn install; then
#      echo "install packages successful"
#    else
#      echo "Error is not recoverable: exiting now"
#      exit 1
#    fi
#  fi
#fi

if [[ ${skipCompile} == false ]]; then
  echo "Start building project for Environment $env"
  if [[ ${dryRun} == false ]]; then
    if flutter build web --web-renderer canvaskit; then
      echo "building react project successful"
    else
      echo "Error is not recoverable: exiting now"
      exit
    fi
  fi
fi

buildDir=./build/web/
echo "copy static assets"
cp ./appspec.json ${buildDir}/appspec.json

echo "Add environment specific assets"
if [[ ${dryRun} == false ]]; then
  case ${env} in
  stage | test | beta)
    cp ./robots.disallow.txt ${buildDir}/robots.txt
    ;;
  prod)
    cp ./robots.txt ${buildDir}
    ;;
  esac
fi

################################################# Start Server upload ##################################################
echo "creating tar file for build project to publish"
if [[ ${skipPublish} == false ]]; then
  if [[ ${s3Deploy} == false ]]; then
    if [[ ${dryRun} == false ]]; then
      echo "Start compressing dist directory to upload on aws..."
      if tar -zcf "${artifactId}".tar.gz -C ${buildDir} .; then
        echo "compress successful"
      else
        echo "Error is not recoverable: exiting now"
        exit
      fi
    fi
    if [[ ${env} == "prod" ]]; then
      echo "Start Uploading to csh-prod-deployments"
      if [[ ${dryRun} == false ]]; then
        if aws s3 --profile stage --region ap-south-1 cp "${artifactId}".tar.gz s3://csh-prod-deployments/; then
          echo "Uploaded to s3://csh-prod-deployments/$artifactId.tar.gz"
        else
          echo "Error is not recoverable: exiting now"
          exit
        fi
      fi
    else
      echo "Start Uploading to csh-stage-deployments"
      if [[ ${dryRun} == false ]]; then
        if aws s3 --profile stage --region ap-south-1 cp "${artifactId}".tar.gz s3://csh-stage-deployments/; then
          echo "Uploaded to s3://csh-stage-deployments/$artifactId.tar.gz"
        else
          echo "Error is not recoverable: exiting now"
          exit
        fi
      fi
    fi
    echo "Deleting ${artifactId}.tar.gz"
    if [[ ${dryRun} == false ]]; then
      rm "${artifactId}".tar.gz
    fi
  else
    (
      cd dist/browser
      aws s3 cp . s3://${bucket} --recursive
    )
  fi
fi
################################################### End Server upload ##################################################
printf "Publish Success!"
