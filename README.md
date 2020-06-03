# Jenkins configuration-as-code

Project workflow is (1) launch Jenkins container, (2) await Jenkins launch, (3) generate all Jenkins pipelines. 

Key workflow from [Makefile](Makefile):

```
make build_run
make await
make jobs
```

## Nishan's best practice

Dev/Sec/Git-Ops engineers do not touch GUIs. Achieve 100% IaaC & configuration-as-code.

## Detailed design

- Jenkins running in a Docker container. 
- Jenkins admin user created in groovy. 
- Jenkins API token created in groovy.
- Auto generate Jenkins pipelines via jenkins-job-builder



