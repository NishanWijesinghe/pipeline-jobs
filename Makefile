PROJECT_NAME=jenkins-master
TAG=latest
JENKINS_READY='Jenkins is fully up and running'
container_base_dir=/usr/local/bin

build:
	docker build -t ${PROJECT_NAME}:${TAG} .

run: stop_rm
#https://www.jenkins.io/doc/book/managing/system-properties/
	docker run -p 80:8080 --name=${PROJECT_NAME} -d --env JAVA_OPTS="-Xmx9830M -Djenkins.install.runSetupWizard=false" --env JENKINS_OPTS="--handlerCountMax=300" ${PROJECT_NAME}:${TAG}
	docker ps

await:
	echo "Ctrl + C after ${JENKINS_READY} appears on screen"
	docker logs -f ${PROJECT_NAME} 2>&1 | grep ${JENKINS_READY}

build_run: build run

start:
	docker start ${PROJECT_NAME}

stop_rm:
	docker stop ${PROJECT_NAME} || true && docker rm ${PROJECT_NAME} || true

exec_root:
	docker exec -u 0 -it ${PROJECT_NAME} bash
jobs:
	docker exec -it ${PROJECT_NAME} bash -c "jenkins-bash/jobs.sh"

