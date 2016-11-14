set -e

NAME=$1
VERSION=$2
QUALIFIER="latest"

if [ "$NAME" == "" ] || [ "$VERSION" == "" ]; then
  echo "usage: shapshot.sh <artifact> <version>"
  echo "e.g.: snapshot.sh jbehave 3.3-SNAPSHOT"
  exit;
fi
 
CWD=`pwd`
MVN="mvn -s $CWD/../site/settings-nexus.xml" 
PROFILES=reporting,distribution

$MVN -U clean deploy -P$PROFILES

cd $CWD/../site/site-upload

./upload-download.sh $NAME $VERSION $QUALIFIER
./upload-reference.sh $NAME $VERSION $QUALIFIER

CWD=`pwd`
