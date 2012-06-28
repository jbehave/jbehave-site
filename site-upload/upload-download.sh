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
PATH=""
# TODO replace with regex extraction
if [ "$ARTIFACT" == "jbehave-site" ] ; then
  GROUP_ID="org.jbehave.site"
  GROUP_PATH="org/jbehave/site"
  ARTIFACT_ID="jbehave-site-frontend"
  PATH="site"
elif [ "$ARTIFACT" == "jbehave-web" ] ; then
  GROUP_ID="org.jbehave.web"
  GROUP_PATH="org/jbehave/web"
  ARTIFACT_ID="jbehave-web-distribution"
  PATH="web"
fi

if [ "$PATH" != "" ] ; then
  DOWNLOADS="$DOWNLOADS/$PATH"
fi

NEXUS="https://nexus.codehaus.org/content/repositories/releases"

for TYPE in "bin" "src"
do
INDEX="index-$TYPE-$VERSION.html"
VERSIONED="$DOWNLOADS/$TYPE/$VERSION"
URL="$NEXUS/$GROUP_PATH/$ARTIFACT_ID/$VERSION/$ARTIFACT_ID-$VERSION-$TYPE.zip"
DOWNLOAD="<html><head><meta http-equiv=\"REFRESH\" content=\"0;url=$URL\"></head></html>"
echo $DOWNLOAD > target/$INDEX
/usr/bin/scp target/$INDEX jbehave.org:uploads
/usr/bin/ssh jbehave.org "mkdir -p $VERSIONED; mv uploads/$INDEX $VERSIONED/index.html; cd $DOWNLOADS/$TYPE; rm $QUALIFIER; ln -s $VERSION $QUALIFIER"
done 

