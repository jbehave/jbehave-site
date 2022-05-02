#!/bin/bash

ARTIFACT=$1
VERSION=$2
QUALIFIER=$3

if [ "$ARTIFACT" == "" ] || [ "$VERSION" == "" ] || [ "$QUALIFIER" == "" ]; then
  echo "usage: upload-download.sh <artifact> <version> <qualifier>"
  exit;
fi

DOWNLOADS="/var/www/jbehave.org/reference/downloads"
GROUP_ID="org.jbehave"
GROUP_PATH="org/jbehave"
ARTIFACT_ID="jbehave-distribution"
RELATIVE_PATH=""
# TODO replace with regex extraction
if [ "$ARTIFACT" == "jbehave-site" ] ; then
  GROUP_ID="org.jbehave.site"
  GROUP_PATH="org/jbehave/site"
  ARTIFACT_ID="jbehave-site-frontend"
  RELATIVE_PATH="site"
elif [ "$ARTIFACT" == "jbehave-web" ] ; then
  GROUP_ID="org.jbehave.web"
  GROUP_PATH="org/jbehave/web"
  ARTIFACT_ID="jbehave-web-distribution"
  RELATIVE_PATH="web"
elif [ "$ARTIFACT" == "jbehave-eclipse" ] ; then
  GROUP_ID="org.jbehave.eclipse"
  GROUP_PATH="org/jbehave/eclipse"
  ARTIFACT_ID="org.jbehave.eclipse.repository"
  RELATIVE_PATH="eclipse"
fi

if [ "$RELATIVE_PATH" != "" ] ; then
  DOWNLOADS="$DOWNLOADS/$RELATIVE_PATH"
fi

NEXUS="https://s01.oss.sonatype.org/content/repositories/releases"

for TYPE in "bin" "src"
do
INDEX="index-$TYPE-$VERSION.html"
VERSIONED="$DOWNLOADS/$TYPE/$VERSION"
URL="$NEXUS/$GROUP_PATH/$ARTIFACT_ID/$VERSION/$ARTIFACT_ID-$VERSION-$TYPE.zip"
DOWNLOAD="<html><head><meta http-equiv=\"REFRESH\" content=\"0;url=$URL\"></head></html>"
echo $DOWNLOAD > target/$INDEX
scp target/$INDEX jbehave.org:uploads
ssh jbehave.org "mkdir -p $VERSIONED; mv uploads/$INDEX $VERSIONED/index.html; cd $DOWNLOADS/$TYPE; rm $QUALIFIER; ln -s $VERSION $QUALIFIER"
done 

