FROM kartoza/postgis
MAINTAINER Lu Liu<nudtlliu@gmail.com>

RUN apt-get update && apt-get install -y \
  uwsgi \
  uwsgi-plugin-python \
  git \
  gunzip

RUN mkdir -p /var/log/mmrp && \
  mkdir /air
WORKDIR /air

# For trackservice
RUN git clone https://github.com/tumluliu/tracks-rest-api.git
ADD trackservice/trackservice-uwsgi.ini /air/tracks-rest-api/trackservice-uwsgi.ini
ADD trackservice/config.json /air/tracks-rest-api/config.json

EXPOSE 8001

CMD ["uwsgi", "--ini", "/air/tracks-rest-api/trackservice-uwsgi.ini"]
