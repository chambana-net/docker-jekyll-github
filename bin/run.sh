#!/bin/bash - 

. /app/lib/common.sh

CHECK_BIN "jekyll"
CHECK_BIN "git"
CHECK_BIN "bundle"
CHECK_VAR GITHUB_USER
CHECK_VAR GITHUB_REPO

#If subdir not defined, set default.
SUBDIR=${SUBDIR:-/}
GITHUB_BRANCH=${GITHUB_BRANCH:-"master"}

if [[ -d /srv/www/.git ]]; then
	MSG "Updating respository..."
	cd /srv/www
	git checkout ${GITHUB_BRANCH}
	[[ $? -eq 0 ]] || { ERR "Branch ${GITHUB_BRANCH} doesn't exist, aborting."; exit 1; }
	git fetch --all
	git reset --hard origin/${GITHUB_BRANCH}
else
	MSG "Cloning repository..."
	rm -rf /srv/www
	mkdir /srv/www
	git clone -b ${GITHUB_BRANCH} --single-branch https://github.com/${GITHUB_USER}/${GITHUB_REPO} /srv/www
	[[ $? -eq 0 ]] || { ERR "Failed to clone repository, aborting."; exit 1; }
fi

[[ -d /srv/www/${SUBDIR} ]] || { ERR "Subdirectory $SUBDIR does not exist, aborting."; exit 1; }

MSG "Serving site..."
cd /srv/www/${SUBDIR}
[[ -e /srv/www/${SUBDIR}/Gemfile ]] && bundle install 

exec "$@"

