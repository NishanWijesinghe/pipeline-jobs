FROM jenkins/jenkins:latest

#Ref: https://github.com/jenkinsci/docker/blob/master/README.md
#jenkins/jenkins:lts defaults to /var/jenkins_home
# set home directory for jenkins
ENV JENKINS_HOME /var/jenkins_home
ENV WORK_DIR /usr/local/bin

USER root

RUN apt-get update && apt-get install -y vim
RUN apt-get update
RUN apt-get install -y python3
RUN apt-get install -y python-pip

RUN pip install awscli &&\
   pip install jenkins-job-builder &&\
   pip install python-jenkins


# Jenkins home directoy is a volume, so configuration and build history
# can be persisted and survive image upgrades
VOLUME /var/jenkins_home
# volume for RDF data dumps
VOLUME /rdf

# volume for debugging
VOLUME /tmp

USER jenkins

# set home directory for jenkins
ENV JENKINS_HOME /var/jenkins_home

COPY plugins-minimal.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

RUN mkdir -p /var/jenkins_home/.aws && chown jenkins /var/jenkins_home/.aws

COPY --chown=jenkins github-pipeline/ $WORK_DIR/github-pipeline
COPY --chown=jenkins jenkins-job-builder/ $WORK_DIR/jenkins-job-builder

#Runs scripts in lexicographical order on container launch
COPY --chown=jenkins src/init.groovy.d/ /usr/share/jenkins/ref/init.groovy.d

COPY --chown=jenkins src/bash/ $WORK_DIR/jenkins-bash

# auto job builder @ /usr/local/bin/jenkins-jobs
WORKDIR $WORK_DIR/




