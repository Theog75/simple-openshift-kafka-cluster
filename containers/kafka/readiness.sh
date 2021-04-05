#!/bin/bash

/opt/kafka/bin/kafka-topics.sh --create --topic readiness-$HOSTNAME --zookeeper zk-0.zk:2181,zk-1.zk:2181,zk-2.zk:2181 --partitions 1 --replication-factor 2

/opt/kafka/bin/kafka-console-producer.sh --topic readiness-$HOSTNAME --broker-list kafka-0.kafka:9092,kafka-1.kafka:9092,kafka-2.kafka:9092 < echo $HOSTNAME

STAT=$(/opt/kafka/bin/kafka-console-consumer.sh --topic readiness-$HOSTNAME --from-beginning --zookeeper zk-0.zk:2181,zk-1.zk:2181,zk-2.zk:2181
)

STAT=$(/opt/zookeeper/bin/zkServer.sh status 2>&1|grep Mode)

if [[ "$STAT" =~ "Mode:" ]]; then
    echo "All is well";
    exit 0
else 
    echo "readiness failed";
    exit 1
fi