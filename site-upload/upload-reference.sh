#!/bin/bash

ARTIFACT=$1
VERSION=$2
QUALIFIER=$3

if [ "$ARTIFACT" == "" ] || [ "$VERSION" == "" ] || [ "$QUALIFIER" == "" ]; then
  echo "usage: upload-reference.sh <artifact> <version> <qualifier>"
  exit;
fi

REFERENCE="/var/www/jbehave.org/reference"
GROUP_ID="org.jbehave"
ARTIFACT_ID="jbehave-distribution"
PATH=""
# TODO replace with regex extraction
if [ "$ARTIFACT" == "jbehave-site" ] ; then
  GROUP_ID="org.jbehave.site"
  ARTIFACT_ID="jbehave-site-frontend"
  PATH="site"
elif [ "$ARTIFACT" == "jbehave-web" ] ; then
  GROUP_ID="org.jbehave.web"
  ARTIFACT_ID="jbehave-web-distribution"
  PATH="web"
fi

ARTIFACT_FULL="$GROUP_ID:$ARTIFACT_ID:$VERSION:zip:bin"
VERSIONED_ARTIFACT="uploads/$ARTIFACT-$VERSION"
ZIPPED_ARTIFACT="$ARTIFACT.zip"
if [ "$PATH" != "" ] ; then
  REFERENCE="$REFERENCE/$PATH"
fi
VERSIONED_REFERENCE="$REFERENCE/$VERSION"

$MVN_HOME/bin/mvn org.apache.maven.plugins:maven-dependency-plugin:2.4:get -Dartifact=$ARTIFACT_FULL -Dtransitive=false -Ddest=target/$ZIPPED_ARTIFACT

/usr/bin/scp target/$ZIPPED_ARTIFACT jbehave.org:uploads/
/usr/bin/ssh jbehave.org "rm -rf $VERSIONED_ARTIFACT; unzip -q -d uploads uploads/$ZIPPED_ARTIFACT; rm -r $VERSIONED_REFERENCE; mv $VERSIONED_ARTIFACT/docs/ $VERSIONED_REFERENCE; cd $REFERENCE; rm $QUALIFIER; ln -s $VERSION $QUALIFIER"
