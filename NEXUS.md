# Local Nexus 

Release and snapshot deployment require a local instance. 

This will allow to work around https://issues.jenkins-ci.org/browse/JENKINS-13637

## Steps to configure 

1.  Download Nexus OSS from https://www.sonatype.com/download-oss-sonatype
2.  Start up using default port 8081
3.  Configure proxy to https://repo.jenkins-ci.org/public
4.  Add proxy to public group

