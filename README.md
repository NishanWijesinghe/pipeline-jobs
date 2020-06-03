# Jenkins configuration-as-code

Project workflow is (1) launch Jenkins container, (2) await Jenkins launch, (3) generate all Jenkins projects and pipelines. 

```
make build_run
make await
make jobs
```

[Makefile](Makefile)

## Detailed design

- Jenkins running in a Docker container. 
- Jenkins admin user created in groovy. 
- Jenkins API token created in groovy.
- Auto generate Jenkins pipelines & projects via jenkins-job-builder

