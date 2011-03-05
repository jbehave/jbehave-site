# Requires the 'release' profile in your ~/.m2/settings.xml
#
#    <profile>
#      <id>release</id>
#      <activation>
#        <name>performRelease</name>
#        <property>
#          <value>true</value>
#        </property>
#      </activation>
#      <properties>
#        <gpg.passphrase>[Your pgp passphrase]</gpg.passphrase>
#      </properties>
#    </profile>

NAME=$1
VERSION=$2
QUALIFIER=$3
NEXT=$4

if [ "$NAME" == "" ] || [ "$VERSION" == "" ] || [ "$QUALIFIER" == "" ] || [ "$NEXT" == "" ] ; then
  echo "usage: release.sh <name> <version> <qualifier> <next>"
  echo "e.g.: release.sh jbehave 3.3-beta-1 preview 3.3-SNAPSHOT"
  echo "e.g.: release.sh jbehave 3.3 stable 3.4-SNAPSHOT"
  exit;
fi

mvn --batch-mode release:prepare -Preporting,distribution -DreleaseVersion=$VERSION -Dtag=$NAME-$VERSION -DdevelopmentVersion=$NEXT 
mvn release:perform -Preporting,distribution

CWD=`pwd`

cd $CWD/distribution
./upload-download.sh $VERSION $QUALIFIER
./upload-references.sh $VERSION $QUALIFIER
cd $CWD

# From Nexus Staging: close and release 

