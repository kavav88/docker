FROM debian:latest
MAINTAINER Anton Karelin <kav_av@mail.ru>
ADD ftp.ru.debian.org.list /etc/apt/sources.list.d/

RUN apt-get update && apt-get -y upgrade && apt-get -y install \
    nginx \
    procps && \
    apt-get autoclean

RUN rm -frv /var/www/* && ls /var/www/ && mkdir -p /var/www/homework3.com/img

COPY index.html /var/www/homework3.com/
COPY img.jpg /var/www/homework3.com/img/
RUN chmod u=rwx,g=rx,o=rx -R /var/www/homework3.com

RUN addgroup karelin && adduser --disabled-password --gecos '' anton && usermod -a -G karelin anton && chown -R anton /var/www/homework3.com

RUN sed -i 's/\/var\/www\/html/\/var\/www\/homework3.com/g' /etc/nginx/sites-enabled/default
RUN sed -i 's/www-data/anton/g' /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]
