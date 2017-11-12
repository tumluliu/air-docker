FROM nginx
MAINTAINER Lu Liu<nudtlliu@gmail.com>

RUN apt-get update && apt-get install -y \
  apt-utils \
  git 

# For AIR app
RUN git clone https://github.com/tumluliu/air-web.git /var/www/html/air
COPY ./default.conf /etc/nginx/conf.d/default.conf
