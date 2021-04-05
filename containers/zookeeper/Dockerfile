FROM centos

RUN  yum update -y && yum install -y java wget curl && mkdir /data && chmod 777 -R /data
COPY apache-zookeeper-3.7.0-bin.tar.gz /
RUN tar zxvf apache-zookeeper-3.7.0-bin.tar.gz -C /opt && mv /opt/apache-zookeeper-3.7.0-bin /opt/zookeeper
COPY zoo.cfg /opt/zookeeper/conf
COPY readiness.sh /
COPY runzk.sh /
CMD ["/runzk.sh"]

