FROM centos

RUN  yum update -y && yum install -y java wget curl && mkdir /data && chmod 777 -R /data 
COPY kafka_2.12-2.7.0.tgz /
RUN tar zxvf kafka_2.12-2.7.0.tgz -C /opt && mv /opt/kafka_2.12-2.7.0 /opt/kafka
COPY runkafka.sh /
COPY readiness.sh /
COPY server.properties /opt/kafka/config
RUN chmod 777 -R /opt/kafka/ && mkdir /opt/kafka/logs && chmod 777 -R /opt/kafka/logs
#RUN cp /opt/kafka/config/server.properties /tmp
CMD ["/runkafka.sh"]

