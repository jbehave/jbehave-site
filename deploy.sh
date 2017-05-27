set -e
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

CWD=`pwd`
MVN="mvn -s $CWD/../site/settings-nexus.xml" 
PROFILES=sonatype-oss-release,release

$MVN deploy -P$PROFILES

echo "The deploy has been staged."

echo "Next steps are:"
echo "- Nexus Staging Repository (https://oss.sonatype.org/index.html#stagingRepositories) to close and release the jbehave staging."

