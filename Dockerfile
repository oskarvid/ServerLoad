FROM r-base

MAINTAINER Oskar Vidarsson <oskarvidarsson@gmail.com>

RUN apt update && \
apt install -y anacron procps 

ADD anacrontab /etc/
RUN chmod 0644 /etc/anacrontab

ADD serverload.sh /usr/local/bin/
ADD systemLoad.R /usr/local/bin/

ENTRYPOINT [ "anacron", "-d" ]