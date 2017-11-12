FROM ubuntu:16.04
MAINTAINER Lu Liu<nudtlliu@gmail.com>

RUN apt-get update && apt-get install -y \
  apt-utils \
  postgresql-client \
  uwsgi \
  uwsgi-plugin-python \
  git \
  python-pip

# Install and setup trackservice
RUN mkdir -p /trackservice
RUN git clone https://github.com/tumluliu/tracks-rest-api.git /trackservice
WORKDIR /trackservice
COPY ./trackservice-uwsgi.ini /trackservice/trackservice-uwsgi.ini
COPY ./config.json /trackservice/config.json
RUN pip install --upgrade pip && pip install psycopg2 && pip install -r requirements.txt

EXPOSE 8001

CMD ["uwsgi", "--ini", "/trackservice/trackservice-uwsgi.ini"]
