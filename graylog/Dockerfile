FROM graylog2/allinone
MAINTAINER Anthony Gourraud <anthony.gourraud@lyra-network.com> 

ENV DEBIAN_FRONTEND noninteractive 

# run graylog-server with debugger 
# RUN sed -i 's/\(GRAYLOG_SERVER_JAVA_OPTS=".*\)"/\1 -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005"/' /opt/graylog/embedded/cookbooks/graylog/templates/default/sv-graylog-server-run.erb VOLUME /var/opt/graylog/data

RUN mkdir /configs
ADD conf.sh /configs/conf.sh
RUN chmod 777 /configs/conf.sh

VOLUME /var/log/graylog
VOLUME /var/opt/graylog/data
VOLUME /opt/graylog/plugin
VOLUME /opt/graylog/conf/nginx/ca

CMD ["/configs/conf.sh"]
