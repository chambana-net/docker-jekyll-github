#!/bin/bash - 

. /app/lib/common.sh

CHECK_BIN "jekyll"
CHECK_BIN "git"
CHECK_BIN "bundle"
CHECK_VAR JEKYLL_GITHUB_USER
CHECK_VAR JEKYLL_GITHUB_REPO

if [[ -d /srv/www/.git ]]; then
	MSG "Updating respository..."
	cd /srv/www
	git checkout ${JEKYLL_GITHUB_BRANCH}
	[[ $? -eq 0 ]] || { ERR "Branch ${JEKYLL_GITHUB_BRANCH} doesn't exist, aborting."; exit 1; }
	git fetch --all
	git reset --hard origin/${JEKYLL_GITHUB_BRANCH}
else
	MSG "Cloning repository..."
	rm -rf /srv/www
	mkdir /srv/www
	git clone -b ${JEKYLL_GITHUB_BRANCH} --single-branch https://github.com/${JEKYLL_GITHUB_USER}/${JEKYLL_GITHUB_REPO} /srv/www
	[[ $? -eq 0 ]] || { ERR "Failed to clone repository, aborting."; exit 1; }
fi

[[ -d /srv/www/${JEKYLL_GITHUB_SUBDIR} ]] || { ERR "Subdirectory $JEKYLL_GITHUB_SUBDIR does not exist, aborting."; exit 1; }

MSG "Serving site..."
cd /srv/www/${JEKYLL_GITHUB_SUBDIR}
[[ -e /srv/www/${JEKYLL_GITHUB_SUBDIR}/Gemfile ]] && bundle install 

exec "$@"

