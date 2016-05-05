#!/bin/bash - 

. /opt/chambana/lib/common.sh

CHECK_BIN "jekyll"
CHECK_BIN "git"
CHECK_VAR GITHUB_USER
CHECK_VAR GITHUB_REPO

#If subdir not defined, set default.
SUBDIR=${SUBDIR:-/}
GITHUB_BRANCH=${GITHUB_BRANCH:-"master"}

MSG "Cloning repository..."
git clone -b ${GITHUB_BRANCH} --single-branch https://github.com/${GITHUB_USER}/${GITHUB_REPO} /srv/www
[[ $? -eq 0 ]] || { ERR "Failed to clone repository, aborting."; exit 1; }
[[ -d /srv/www/${SUBDIR} ]] || { ERR "Subdirectory $SUBDIR does not exist, aborting."; exit 1; }

MSG "Serving site..."
cd /srv/www/${SUBDIR}
jekyll serve
