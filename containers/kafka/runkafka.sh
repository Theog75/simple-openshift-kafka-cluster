#!/bin/bash


sleep 20
mkdir -p /data/kafka-logs/broker0

ID=$(echo "$HOSTNAME" |sed -r  's/kafka-([0-9])/\1/')
#MYID=$(expr $ID + 1)

sed  -i "s/broker.id=0/broker.id=$ID/" /opt/kafka/config/server.properties 
cat /opt/kafka/config/server.properties
#echo $MYID > /data/myid

echo "!!!!!! Starting Kafka with BrokerID: "$ID
#/opt/zookeeper/bin/zkServer.sh start-foreground
/opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties
#/opt/kafka/bin/kafka-server-start.sh /tmp/server.properties
