Commands
====================

```
mvn process-sources -P format
mvn test -Dmaven.test.skip=false
mvn verify -P oss

mvn clean deploy -P oss -DautoReleaseAfterClose=true

mvn versions:set -DgenerateBackupPoms=false -DnewVersion=1.0.0-SNAPSHOT
```
