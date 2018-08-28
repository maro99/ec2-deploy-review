FROM            ec2-deploy:base

ENV             PROJECT_DIR     /srv/project


#Nginx, superviosr install
RUN             apt -y install nginx supervisor

# Copy projects files
COPY            .   ${PROJECT_DIR}
WORKDIR         ${PROJECT_DIR}

# Virtalenv path
RUN             export VENV_PATH=$(pipenv --venv); echo $VENV_PATH;

# Nginx config
RUN             cp -f ${PROJECT_DIR}/.config/nginx.conf \
                        /etc/nginx/nginx.conf && \

                # available에  nginx_app.conf 파일 복사
                cp -f ${PROJECT_DIR}/.config/nginx_app.conf \
                       /etc/nginx/sites-available/ && \

                # 이미 sites-enabled에 있던 모든 내용 삭제
                rm -f  /etc/nginx/sites-enabled/* && \

                # available에 있는 nginx_app.conf를 enabled로 링크.
                ln -sf  /etc/nginx/sites-available/nginx_app.conf \
                        /etc/nginx/sites-enabled

# Supervisor
RUN             cp -f ${PROJECT_DIR}/.config/supervisor_app.conf \
                        /etc/supervisor/conf.d

# RUN supervisor
CMD             supervisord -n

## Run uWSGI (CMD)
#CMD             pipenv run uwsgi --ini ${PROJECT_DIR}/.config/uwsgi_http.ini

# RUN Ngnix
#CMD             nginx -g 'daemon off;'
