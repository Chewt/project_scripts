#!/usr/bin/bash

# Get last release tag
LATEST_TAG=$(git describe --tags `git rev-list --tags --max-count=1`)

# store all commits since last release
git log --pretty=format:'* %s%n%b' $LATEST_TAG..HEAD > unsorted.txt

# seperate the Fix commits from other commits
echo -e "##### Bugfixes\n" > fix_commits.txt
awk -v RS='' -v ORS='\n\n' '/\* Fix/{print >> "fix_commits.txt"; next} {print > "other_commits.txt"}' unsorted.txt

# Set up release_notes.md
echo -e "#### Release Notes\n" > release_notes.md

# combine commits
cat other_commits.txt fix_commits.txt >> release_notes.md

# remove temp files
rm unsorted.txt fix_commits.txt other_commits.txt
