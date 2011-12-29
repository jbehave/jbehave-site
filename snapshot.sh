set -e

VERSION=$1
QUALIFIER="latest"

if [ "$VERSION" == "" ] ; then
  echo "usage: snapshot.sh <version>"
  echo "e.g.: snapshot.sh 3.3-SNAPSHOT"
  exit;
fi

mvn clean deploy -Preporting,distribution

CWD=`pwd`

cd $CWD/distribution
./upload-download.sh $VERSION $QUALIFIER
./upload-reference.sh $VERSION $QUALIFIER
cd $CWD
