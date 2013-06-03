set -e

NAME=$1
VERSION=$2
QUALIFIER="latest"

if [ "$NAME" == "" ] || [ "$VERSION" == "" ]; then
  echo "usage: shapshot.sh <artifact> <version>"
  echo "e.g.: snapshot.sh jbehave 3.3-SNAPSHOT"
  exit;
fi

mvn -U clean deploy -Preporting,distribution

CWD=`pwd`
cd $CWD/../jbehave-site/site-upload

./upload-download.sh $NAME $VERSION $QUALIFIER
./upload-reference.sh $NAME $VERSION $QUALIFIER

CWD=`pwd`
