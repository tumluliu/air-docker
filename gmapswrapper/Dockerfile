FROM ubuntu:16.04
MAINTAINER Lu Liu<nudtlliu@gmail.com>

RUN apt-get update && apt-get install -y \
  apt-utils \
  uwsgi \
  uwsgi-plugin-python \
  git \
  python-pip

# Install and setup Google Maps wrapper
RUN mkdir -p /gmapswrapper
RUN git clone https://github.com/tumluliu/gmaps-wrapper.git /gmapswrapper
WORKDIR /gmapswrapper
COPY ./gmapswrapper-uwsgi.ini /gmapswrapper/gmapswrapper-uwsgi.ini
RUN pip install --upgrade pip && pip install -r requirements.txt

EXPOSE 8002

CMD ["uwsgi", "--ini", "/gmapswrapper/gmapswrapper-uwsgi.ini"]
