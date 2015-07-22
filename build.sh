#!/usr/bin/env bash

if [ "$#" -ne 1 ] || [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
    printf "Downloads, builds, and bundles a tagged version of stampit.\n"
    printf "Usage: build.sh TAG\n\n"
    printf "TAG is an existing tag in the https://github.com/stampit-org/stampit repository.\n\n"
    exit 1
fi

printf "Downloading and building stampit#%s...\n" $1

rm -rf build
git clone --branch $1 --single-branch --depth 1 https://github.com/stampit-org/stampit.git build
cd build
npm install
npm run build
cd ..

printf "Bundling stampit#%s for the web...\n" $1

webpack && MINIFY=1 webpack

printf "\nReview and test the bundle, then commit, tag, and push it:\n\n"
printf "  git add .\n"
printf "  git commit -m MSG\n"
printf "  git tag -a %s -m MSG\n" $1
printf "  git push --follow-tags\n\n"
printf "MSG should match the tag message in the https://github.com/stampit-org/stampit repository.\n\n"