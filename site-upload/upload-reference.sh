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
RELATIVE_PATH=""
# TODO replace with regex extraction
if [ "$ARTIFACT" == "jbehave-site" ] ; then
  GROUP_ID="org.jbehave.site"
  ARTIFACT_ID="jbehave-site-frontend"
  RELATIVE_PATH="site"
elif [ "$ARTIFACT" == "jbehave-web" ] ; then
  GROUP_ID="org.jbehave.web"
  ARTIFACT_ID="jbehave-web-distribution"
  RELATIVE_PATH="web"
fi

ARTIFACT_FULL="$GROUP_ID:$ARTIFACT_ID:$VERSION:zip:bin"
VERSIONED_UPLOAD="uploads/$ARTIFACT-$VERSION"
ZIPPED_ARTIFACT="$ARTIFACT.zip"
if [ "$RELATIVE_PATH" != "" ] ; then
  REFERENCE="$REFERENCE/$RELATIVE_PATH"
fi
VERSIONED_REFERENCE="$REFERENCE/$VERSION"

echo "Uploading artifact $ARTIFACT_FULL"
rm -rf target
mvn -U org.apache.maven.plugins:maven-dependency-plugin:2.8:get -Dartifact=$ARTIFACT_FULL -Dtransitive=false -Ddest=target/$ZIPPED_ARTIFACT
scp target/$ZIPPED_ARTIFACT jbehave.org:uploads/

echo "Creating reference $VERSIONED_REFERENCE"
ssh jbehave.org "rm -rf $VERSIONED_UPLOAD; unzip -q -d uploads uploads/$ZIPPED_ARTIFACT; rm -r $VERSIONED_REFERENCE; mv $VERSIONED_UPLOAD/docs/ $VERSIONED_REFERENCE; rm uploads/$ZIPPED_ARTIFACT; rm -r $VERSIONED_UPLOAD; cd $REFERENCE; rm $QUALIFIER; ln -s $VERSION $QUALIFIER"
