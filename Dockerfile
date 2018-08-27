FROM            ec2-deploy:base

ENV             PROJECT_DIR     /srv/project


#Ngnix
RUN             apt -y install nginx

# Copy projects files
COPY            .   ${PROJECT_DIR}
WORKDIR         ${PROJECT_DIR}

# Virtalenv path
RUN             export VENV_PATH=$(pipenv --venv); echo $VENV_PATH;
#ENV             VENV_PATH $VENV_PATH


## Run uWSGI (CMD)
#CMD             pipenv run uwsgi --ini ${PROJECT_DIR}/.config/uwsgi_http.ini

# RUN Ngnix
CMD             nginx -g 'daemon off;'
# nginx 원래 빽에서도는데 프론트로 돌게 설정함.