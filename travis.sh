#!/bin/bash
set -o errexit
set -v

# We manage the git clone manually so that we have "origin/master" available to 
# us for diffing
if [ -v TRAVIS ]; then
  git fetch origin master
  echo "TRAVIS_REPO_SLUG: $TRAVIS_REPO_SLUG"
  git clone https://github.com/$TRAVIS_REPO_SLUG.git $TRAVIS_REPO_SLUG
  cd $TRAVIS_REPO_SLUG
  git fetch origin
  git checkout "origin/$TRAVIS_BRANCH"
fi

cd cli
npm install
./node_modules/.bin/flow
node dist/cli.js run-ci-tests ..
