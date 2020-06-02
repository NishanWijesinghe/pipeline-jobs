FROM jenkins/jenkins:lts


#Ref: https://github.com/jenkinsci/docker/blob/master/README.md
#jenkins/jenkins:lts defaults to /var/jenkins_home
# set home directory for jenkins
ENV JENKINS_HOME /var/jenkins_home

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

#Runs scripts in lexicographical order on container launch
COPY src/ /usr/share/jenkins/ref/init.groovy.d

USER jenkins

# set home directory for jenkins
ENV JENKINS_HOME /var/jenkins_home

COPY plugins-minimal.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

RUN mkdir -p /var/jenkins_home/.aws && chown jenkins /var/jenkins_home/.aws

# auto job builder @ /usr/local/bin/jenkins-jobs
WORKDIR /usr/local/bin/
COPY jenkins-jobs/ .

