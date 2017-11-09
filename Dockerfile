FROM kartoza/postgis
MAINTAINER Lu Liu<nudtlliu@gmail.com>

RUN apt-get update && apt-get install -y \
  uwsgi \
  uwsgi-plugin-python \
  git \
  nginx
ADD nginx/default.conf /etc/nginx/sites-available

RUN mkdir -p /var/log/mmrp && \
  mkdir -p /var/log/air && \
  mkdir /air
WORKDIR /air

# For trackservice
RUN git clone https://github.com/tumluliu/tracks-rest-api.git
ADD trackservice/trackservice-uwsgi.ini /air/tracks-rest-api/trackservice-uwsgi.ini
ADD trackservice/config.json /air/tracks-rest-api/config.json
RUN uwsgi --ini /air/tracks-rest-api/trackservice-uwsgi.ini

# For Google Maps wrapper service
RUN git clone https://github.com/tumluliu/gmaps-wrapper.git
ADD gmaps-wrapper/gmapswrapper-uwsgi.ini /air/gmaps-wrapper/gmapswrapper-uwsgi.ini
RUN uwsgi --ini /air/gmaps-wrapper/gmapswrapper-uwsgi.ini

RUN git clone https://github.com/tumluliu/air-web.git /var/www/html/air
RUN service nginx restart

EXPOSE 80

CMD ["bash"]
