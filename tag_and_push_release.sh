# Tag the current commit as a release

git stash 2> /dev/null 1> /dev/null
FILE_VER=$(./bumpver.sh | awk '{print $4}')
LAST_TAG=$(git describe --tags `git rev-list --tags --max-count=1`)
echo -e "Last version:    $LAST_TAG"
echo -e "Current version: $FILE_VER"
git stash pop 2> /dev/null

if [ "$FILE_VER" == "$LAST_TAG" ]
then
    echo "Please run bumpver"
    exit
fi

if [ "$1" == "dry" ]
then
    echo "dryrun"
    exit
fi

git tag $FILE_VER
git push
git push --tags
