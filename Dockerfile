FROM                ec2-deploy:base

ENV                 PROJECT_DIR         /srv/project

# Copy project files
COPY                .   ${PROJECT_DIR}
WORKDIR             ${PROJECT_DIR}

# Virtualemv path
RUN                 export VENV_PATH=$(pipenv --venv); echo $VENV_PATH
ENV                 VENV_PATH $VENV_PATH

CMD                 pipenv run uwsgi --ini ${PROJECT_DIR}/ .config/uwsgi_http.ini