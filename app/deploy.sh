#!/usr/bin/env bash

IDENTITY_FILE="~/.ssh/fc-8th.pem"
USER="ubuntu"
HOST="ec2-13-125-224-95.ap-northeast-2.compute.amazonaws.com"
PROJECT_DIR="$HOME/Desktop/projects/deploy_home_practice/ec2-deploy"
SERVER_DIR='/home/ubuntu/project'



# 서버의 파일을 지움.
ssh -i ${IDENTITY_FILE} ${USER}@${HOST} rm -rf ${SERVER_DIR}

# 서버에 프로젝트 파일을 다시 업로드.
scp -i ${IDENTITY_FILE} -r ${PROJECT_DIR} ${USER}@${HOST}:${SERVER_DIR}