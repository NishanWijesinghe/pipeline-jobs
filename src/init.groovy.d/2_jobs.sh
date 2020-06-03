#!/bin/bash

base_dir=/usr/local/bin

source ${base_dir}/jenkins-job-builder/api-info
echo "#####token=${token}"
sed -i -e "s/password=/password=${token}/g" ${base_dir}/jenkins_jobs.ini
echo "####Testing job generation#######"
jenkins-jobs --conf jenkins_jobs.ini test ${base_dir}/github-pipeline/config/github-pipeline.yml
echo "####Running job generation#######"
jenkins-jobs --conf jenkins_jobs.ini update ${base_dir}/github-pipeline/config/github-pipeline.yml