#!/usr/bin/env bash

#######################################
# log debug level
# Arguments:
#   param1 - message
# Arguments:
#   param2 - tag
#######################################
function logHeader() {
  local tag=${1:-'Undefined Tag'}
  local msg=${2:-'Undefined msg'}
  echo "====== [${tag}]: ${msg}" >/dev/stdout
}

#######################################
# log Footer with separator
#######################################
function logFooter() {
  echo "========================" >/dev/stdout
}

#######################################
# log debug level
# Arguments:
#   param1 - tag
# Arguments:
#   param2 - message
#######################################
function logInfo() {
  local tag=${1:-'Undefined Tag'}
  local msg=${2:-'Undefined msg'}
  echo "======        [${tag}]: ${msg}" >/dev/stdout
}

#######################################
# log debug level
# Arguments:
#   param1 - tag required
# Arguments:
#   param2 - message required
#######################################
function logDebug() {
  local tag=${1:-'Undefined Tag'}
  local msg=${2:-'Undefined Msg'}
  echo "======        [${tag}]: ${msg}" >/dev/stdout
}

#######################################
# log warn level
# Arguments:
#   param1 - tag
# Arguments:
#   param2 - message
#######################################
function logWarn() {
  local tag=${1:-'Undefined Tag'}
  local msg=${2:-'Undefined msg'}
  echo "======        [${tag}]: ${msg}" >/dev/stdout
}

#######################################
# log warn level
# Arguments:
#   param1 - tag
# Arguments:
#   param2 - message
#######################################
function logError() {
  local tag=${1:-'Undefined Tag'}
  local msg=${2:-'Undefined msg'}
  echo "======        [${tag}]: ${msg}" >/dev/stdout
}
