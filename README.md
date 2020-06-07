# Jenkins automated

The code here implements automation for Jenkins configuration & pipelines. This is a site reliability engineering best practice.

Project workflow is (1) run Jenkins container, (2) grep/await Jenkins launch completion, (3) generate all Jenkins pipelines. 

Key workflow from [Makefile](Makefile):

```
make build_run
make await
make jobs
```

## Best practice

 "Dev/Sec/Git-Ops engineers do not touch GUIs. Achieve 100% IaaC & configuration-as-code." 
 ~ [Nishan R. Wijesinghe](https://www.linkedin.com/in/nishanwijesinghe/)

## Detailed design

- Jenkins running in a Docker container. 
- Jenkins admin user created in groovy. 
- Jenkins API token created in groovy.
- Auto generate Jenkins pipelines via jenkins-job-builder



