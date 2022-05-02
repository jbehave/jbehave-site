#!/usr/bin/env bash
set -e

NAME=$1
VERSION=$2
QUALIFIER=$3
NEXT=$4

if [ "$NAME" == "" ] || [ "$VERSION" == "" ] || [ "$QUALIFIER" == "" ] || [ "$NEXT" == "" ] ; then
  echo "usage: release.sh <name> <version> <qualifier> <next>"
  echo "Name:       jbehave|jbehave-site|jbehave-web"
  echo "Version:    release version"
  echo "Qualifier:  stable|preview"
  echo "Next:       next snapshot version"
  echo "Examples:"
  echo "            release.sh jbehave 5.0 stable 5.1-SNAPSHOT"
  echo "            release.sh jbehave 5.0-beta-1 preview 5.0-SNAPSHOT"
  exit;
fi

CWD=`pwd`
MVN="mvn -s $CWD/../site/settings.xml"
PROFILES=reporting,distribution

$MVN --batch-mode release:prepare -P$PROFILES -DreleaseVersion=$VERSION -Dtag=$NAME-$VERSION -DdevelopmentVersion=$NEXT 
$MVN release:perform -P$PROFILES -Dmaven.wagon.http.ssl.insecure=true -Dmaven.wagon.http.ssl.allowall=true

cd $CWD/../site/site-upload

./upload-download.sh $NAME $VERSION $QUALIFIER
./upload-reference.sh $NAME $VERSION $QUALIFIER

cd $CWD

echo "The release $NAME $VERSION $QUALIFIER has been staged."

echo "Next steps are:"
echo "- Nexus Staging Repository (https://s01.oss.sonatype.org/index.html#stagingRepositories) to close and release the jbehave staging."
echo "- git push changes to remotes"

