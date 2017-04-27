#!/bin/bash
set -e

export EXIT_STATUS=0

./gradlew check || EXIT_STATUS=$?

if [[ $EXIT_STATUS -eq 0 ]]; then 

    ./gradlew docs:asciidoc || EXIT_STATUS=$?

    if [[ $EXIT_STATUS -eq 0 ]]; then 

        if [[ $TRAVIS_BRANCH == 'master' && $TRAVIS_PULL_REQUEST == 'false' ]]; then
    
            if [[ -n $TRAVIS_TAG ]]; then

                echo "Publishing Documentation"
                git config --global user.name "$GIT_NAME"
                git config --global user.email "$GIT_EMAIL"
                git config --global credential.helper "store --file=~/.git-credentials"
                echo "https://$GH_TOKEN:@github.com" > ~/.git-credentials

                git clone https://${GH_TOKEN}@github.com/grails-samples/google-bookshelf.it -b gh-pages gh-pages --single-branch > /dev/null
    
                cp -r build/docs/build/asciidoc/html5/* gh-pages/

                cd gh-pages

                git add .   

                git commit -a -m "Updating Documentation for Travis Build: https://travis-ci.org/$TRAVIS_REPO_SLUG/builds/$TRAVIS_BUILD_ID"
                git push origin HEAD
                cd ..
                rm -rf gh-pages
            fi    
        fi    
    fi    
fi    

exit $EXIT_STATUS
