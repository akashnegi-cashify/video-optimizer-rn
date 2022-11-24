#!/usr/bin/env bash

readonly currentDir=$(
  cd "$(dirname "$0")" || exit 1
  pwd
)

#change to root dir
cd "${currentDir}"/.. || exit 1

source "./scripts/_logger.sh"

#variables

source='<your-app-source-name>'
type='android'
version="1.0.0"
module="core"
tag='Localizer'
defaultLang='en'
serviceGroup="localization"
serviceIdentifier="loc1"
production=false
#languages='hi,en-IN'
languages='hi','te','bn',
env='stage'

fileName="intl_en"
#fileName="intl_messages"
extension=".arb"

searchPath="${module}"

#DIR="$(cd ".." && pwd)"
DIR="$(pwd)"
searchDir="${currentDir}/../lib"

separator='=========================================================================='
separator2='--------------------------------------------------------------------------'

for ARG in "$@"; do
  case "$ARG" in
  --s=*)
    source=${ARG#--s=}
    ;;
  --dl)
    defaultLang=${ARG#--dl=}
    ;;
  --m=*)
    module=${ARG#--m=}
    ;;
  --p)
    production=true
    ;;
  --l=*)
    languages=${ARG#--l=}
    ;;
  --v=*)
    version=${ARG#--v=}
    ;;
  --env=*)
    case ${ARG#--env=} in
    stage)
      env="stage"
      serviceGroup="localization"
      ;;
    beta)
      env="prod"
      ;;
    prod)
      env="prod"
      serviceIdentifier="loc1"
      ;;
    esac
    ;;

  --h)
    logHeader "publish <options...>" "publish to server with given options"
    logInfo "--env" "Run with given environment variable eg <'test', 'stage', 'beta', 'prod'>"
    logInfo "--s" "Source name eg <'CashifyApp', 'CashifyiOS', 'Cashify' >"
    logInfo "--v" "Version of Localization"
    logInfo "--dl" "Default Language to be used for conversion"
    logInfo "--m" "Namespace to be send"
    logInfo "--sg" "Service Group"
    logInfo "--p" "Enable Production"
    logInfo "--la" "Languages separated by ',' to be downloaded eg 'hi,en-IN'"
    logFooter
    exit 1
    ;;
  *)
    logError "ERROR" "Unknown option $ARG."
    exit 1
    ;;
  esac
done

logHeader ${tag} ${separator}
logHeader ${tag} "Default Language = ${defaultLang}"
logHeader ${tag} ${separator}

# Base Url to be used
if [[ ${env} == 'prod' ]]; then
  baseUrl="https://${serviceIdentifier}.ep.cashify.in"
else
  baseUrl="http://${serviceGroup}.api.${env}.cashify.in"
fi

if [[ ${production} == false ]]; then
  logError ${tag} "Download not allowed in non production mode"
fi
logInfo ${tag} "Searching for default localize files (find ${searchDir} -type f -path *${searchPath}/* -name ${fileName}${extension})"

#while IFS= read -r -d '' searchedFile;
for searchedFile in $(find ${searchDir} -type f -path *${searchPath}/* -name ${fileName}${extension}); do
  echo ${separator2}
  logHeader ${tag} "${searchedFile}"
  searchedFileName=${searchedFile##*/}
  searchedFilePath=$(dirname ${searchedFile})

  # Moved to parent so that sub folder for other language later on mapped
  searchedFilePath=$(dirname ${searchedFilePath})

  logInfo ${tag} "File Name: ${searchedFileName}"
  logInfo ${tag} "File Path: ${searchedFilePath}"

  module=$(echo ${module} | tr '[:upper:]' '[:lower:]')
  logDebug ${tag} "NameSpace === ${module}"
  #curl request for file upload

  url="${baseUrl}/v1/request-translation"
  echo "${url} ${searchedFile}"
  dart ./scripts/upload-file.dart ${url} ${source} ${version} ${module} ${searchedFile}

  #check for successful upload
  if [[ $? -eq 0 ]]; then
    logDebug ${tag} "Successfully uploaded"
  #error while uploading file
  else
    logError ${tag} "Error in uploading file"
  fi
  # Downloading file block
  if [[ ${production} == true ]]; then

    logHeader ${tag} "Starting Downloading file for all languages"
    languages=$(echo ${languages} | tr "," "\n")
    for language in ${languages}; do
      logDebug ${tag} "Language ${language}"

      url="${baseUrl}/v1/translation?ck=${source}&cv=${version}&ns=${module}&ln=${language}&ft=json"
      logDebug ${tag} "Url ${url}"
      response=$(curl -s --write-out "|%{http_code}" --request GET \
        --url "${url}")
      response="$(echo "$response" | tr -d '\n')"
      response="$(echo "$response" | tr -d ' ')"
      # shellcheck disable=SC2206
      res=(${response//|/ })
      # 0 for response and 1 for status_code
      logDebug ${tag} "Translation Response Status ${response}"
      status_code=${res[1]}
      # download file from url
      if [[ ${status_code} == 200 ]]; then
        fileUrl=$(echo ${res[0]} | sed -e 's/{"url":"\(.*\)"}/\1/')
        logInfo ${tag} "Download url ${fileUrl}"

        downloadFolder="${module}"

        logInfo ${tag} "Download started"
        downloadLocation="${searchedFilePath}/${downloadFolder}"
        if [[ ! -d ${downloadLocation} ]]; then
          mkdir -p ${downloadLocation}
        fi

        logInfo ${tag} "Downloading Location : ==== ${downloadLocation}"
        downloadResponse=$(curl -s -o "${downloadLocation}/intl_${language}.arb" --write-out "|%{http_code}" --request GET \
          --url ${fileUrl})
        downloadResponse=("${downloadResponse//|/ }")
        status_code=${res[1]}
        if [[ $? == 0 ]]; then
          if [[ ${status_code} == 200 ]]; then
            logDebug ${tag} "Downloaded successfully"
          else
            logError ${tag} "File Download error for ${module} language ${language} url:"
            exit 1
          fi
        else
          logError ${tag} "File Download error for ${module} language ${language} url:"
          exit 1
        fi
      else
        logError ${tag} "File Download error for ${module} language ${language}"
        exit 1
      fi
    done

  fi

done
# <"$(find "${searchDir}" -type f -path "*${searchPath}/*" -name ${fileName}${extension} -print0)"

echo ${separator2}
echo ${separator}
