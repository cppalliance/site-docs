#!/bin/sh

# This script is used to build the Antora-UI

npm_version=$(npm --version 2>/dev/null)
if [ -z "$npm_version" ]; then
  echo "npm is not installed"
  exit 1
fi

if [ ! -d "node_modules" ] || [ "$(find package.json -prune -printf '%T@\n' | cut -d . -f 1)" -gt "$(find node_modules -prune -printf '%T@\n' | cut -d . -f 1)" ]; then
  npm install
fi

gulp_version=$(gulp --version 2>/dev/null)
if [ -n "$gulp_version" ]; then
  GULP_CMD='gulp'
else
  npx_version=$(npx --version 2>/dev/null)
  if [ -z "$npx_version" ]; then
    echo "Neither gulp nor npx are installed"
    exit 1
  else
    GULP_CMD='npx gulp'
  fi
fi

$GULP_CMD bundle
