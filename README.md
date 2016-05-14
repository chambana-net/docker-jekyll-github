docker-jekyll-github
====================
A container for automatically pulling a Jekyll site from Github, building, and hosting it.

Usage
-----
The container exposes port 4000 by default. You can use the following environment variables for configuration:
* `GITHUB_USER`: The user on Github from which to clone the repository.
* `GITHUB_REPO`: The name of the repository to clone.
* `GITHUB_BRANCH`: (Optional) If you want to use a branch other than master, specify it here.
* `GITHUB_SUBDIR`: (Optional) If your site is in a subdirectory of the repository, specify it here.

Tips
----
This container currently just runs `jekyll serve`, so it is highly recommended to run this behind a proxy if it is in a production environment.
