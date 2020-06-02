PROJECT_NAME=jenkins-master
TAG=latest

build:
	docker build -t ${PROJECT_NAME}:${TAG} .
run: stop_rm
#https://www.jenkins.io/doc/book/managing/system-properties/
	docker run -p :8080 --name=${PROJECT_NAME} -d --env JAVA_OPTS="-Xmx9830M -Djenkins.install.runSetupWizard=false" --env JENKINS_OPTS="--handlerCountMax=300" ${PROJECT_NAME}:${TAG}
	docker ps
build_run: build run
start:
	docker start ${PROJECT_NAME}
stop_rm:
	docker stop ${PROJECT_NAME} || true && docker rm ${PROJECT_NAME} || true
