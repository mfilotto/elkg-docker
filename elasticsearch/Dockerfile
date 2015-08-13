FROM elasticsearch:latest

RUN mkdir /configs
ADD conf.sh /configs/conf.sh
RUN chmod 777 /configs/conf.sh

VOLUME /usr/share/elasticsearch/data

CMD ["/configs/conf.sh"]
