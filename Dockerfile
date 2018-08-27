FROM                ec2-deploy:base

# Copy project files
COPY                . /srv/project
WORKDIR             /srv/project

# Virtualemv path
RUN                 export VENV_PATH=$(pipenv --venv); echo $VENV_PATH
ENV                 VENV_PATH $VENV_PATH
# 아래 home부분에서 virtualenv경로를 지정하기 위해서
# VENV_PATH에 pipenv --venv 실행결과 할당한후
# 다시 도커파일에서 쓰기 위해서 궂이 ENV로 설정하려고 불러왔다.

CMD                 pipenv run uwsgi \
                        --http :8000 \
                        --chdir /srv/project/app \
#                        --home $($VENV_PATH) \ #home에서는$VENV_PATH로가져옴
                        --module config.wsgi

# 이렇게 하면 도커파일에서 VENV_PATH로 지정한 것들 동적으로 home에다 넣을 수 있다.