#!/usr/bin/env bash

IDENTITY_FILE="~/.ssh/fc-8th.pem"
USER="ubuntu"
HOST="ec2-13-209-76-106.ap-northeast-2.compute.amazonaws.com"
PROJECT_DIR="$HOME/Desktop/projects/deploy_home_practice/ec2-deploy"
SERVER_DIR='/home/ubuntu/project'


# ssh로 서버에 접속하는 명령어
CMD_CONNECT="ssh -i ${IDENTITY_FILE} ${USER}@${HOST}"

# 서버의 파일을 지움.
${CMD_CONNECT} rm -rf ${SERVER_DIR}
echo "-Delete server files"


# 서버에 프로젝트 파일을 다시 업로드.
scp -q -i ${IDENTITY_FILE} -r ${PROJECT_DIR} ${USER}@${HOST}:${SERVER_DIR}
echo "-Upload files"
#(q는 진행상황 미터 표시 x , -i는??? -r 는 하위 디렉토리 모두 복사 )

# 서버 접속 후 SERVER_DIR로 이동, pipenv --venv로 가상환경의 경로 가져오기
VENV_PATH=$(${CMD_CONNECT} "cd ${SERVER_DIR} && pipenv --venv")

# 가상환경의 경로에 /bin/python을 붙여 서버에서 사용하는 python의 경로 만들기
PYTHON_PATH="${VENV_PATH}/bin/python"
echo "=GET Python path ($PYTHON_PATH)"

# Dockerbuild 및  Docker run 함
DOCKER_BUILD_BASE_CMD="sudo docker build -t ec2-deploy:base -f Dockerfile.base ."
DOCKER_BUILD_DEV_CMD="sudo docker build -t ec2-deploy:dev -f Dockerfile.dev ."
DOCKER_RUN_DEV_CMD="sudo docker run --name ec2-deploy --rm -id -p 8080:80 ec2-deploy:dev"

${CMD_CONNECT} "cd ${SERVER_DIR} && ${DOCKER_BUILD_BASE_CMD}"
${CMD_CONNECT} "cd ${SERVER_DIR} && ${DOCKER_BUILD_DEV_CMD}"

# 기존의 실행중인 docker종료 시킴.
DOCKER_KILL_CMD="sudo docker kill ec2-deploy"
${CMD_CONNECT} "cd ${SERVER_DIR} && ${DOCKER_KILL_CMD}"

# DOcker run
${CMD_CONNECT} "cd ${SERVER_DIR} && ${DOCKER_RUN_DEV_CMD}"

#기존의 돌고있는 nginx 종료 시킴.
KILL_NGINX="sudo fuser -k 80/tcp"
KILL_NGINX2="sudo pkill -ef -9 nginx"
${CMD_CONNECT} "cd ${SERVER_DIR} && ${KILL_NGINX} && ${KILL_NGINX2}"

#ec2 안에서 nginx (리버스 프록시 역할하는) 실행시킨다.
RUN_NGINX="sudo nginx"
${CMD_CONNECT} "cd ${SERVER_DIR} && ${RUN_NGINX}"
echo "nginx runnung"

