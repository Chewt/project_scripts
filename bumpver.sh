# Bump version number in project

# Where is the version number kept?
VERSION_FILE=Makefile

# Store the current version and split it into its parts
VERSION=$(awk -F'v' '/VERSION =/ {print $2}' $VERSION_FILE | grep -o -E '.*[^\"]' )
MAJOR=$(echo $VERSION | awk -F'.' '{print $1}')
MINOR=$(echo $VERSION | awk -F'.' '{print $2}')
FIX=$(  echo $VERSION | awk -F'.' '{print $3}')

# Bump the chosen version number, or display the current version
if [ "$1" == "" ]
then
    echo "Current version is v$MAJOR.$MINOR.$FIX"
    exit
elif [ "$1" == "major" ]
then
    MAJOR=$(($MAJOR + 1))
    MINOR="0"
    FIX="0"
elif [ "$1" == "minor" ]
then
    MINOR=$(($MINOR + 1))
    FIX="0"
elif [ "$1" == "fix" ]
then
    FIX=$(($FIX + 1))
fi

# Change the version number, or do a dry run
if [ "$2" == "dry" ]
then
    echo "Preview:"
    sed -e 's,VERSION = .*$,VERSION = \\"v'$MAJOR'\.'$MINOR'\.'$FIX'\\",' $VERSION_FILE | grep VERSION 
else
    sed -i -e 's,VERSION = .*$,VERSION = \\"v'$MAJOR'\.'$MINOR'\.'$FIX'\\",' $VERSION_FILE 
fi
