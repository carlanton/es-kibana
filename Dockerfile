FROM ubuntu:14.04

RUN apt-get update -q

RUN apt-get install -yq wget

RUN wget -qO - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -

RUN echo "deb http://packages.elasticsearch.org/elasticsearch/1.3/debian stable main" >> /etc/apt/sources.list

RUN apt-get update -q

RUN apt-get install -yq elasticsearch nginx default-jre-headless

RUN cd /tmp && \
    wget -nv https://download.elasticsearch.org/kibana/kibana/kibana-3.1.0.tar.gz && \
    tar zxf kibana-3.1.0.tar.gz && \
    rm -f kibana-3.1.0.tar.gz && \
    mv /tmp/kibana-3.1.0 /usr/share/kibana3

ADD kibana.conf /etc/nginx/sites-enabled/default
ADD config.js /usr/share/kibana3/config.js

CMD service elasticsearch start & nginx -c /etc/nginx/nginx.conf -g 'daemon off;'

EXPOSE 80 9200

