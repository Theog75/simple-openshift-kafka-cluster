#!/bin/bash

/opt/kafka/bin/kafka-topics.sh --create --topic readiness-$HOSTNAME --zookeeper zk-0.zk:2181,zk-1.zk:2181,zk-2.zk:2181 --partitions 1 --replication-factor 2

/opt/kafka/bin/kafka-topics.sh --zookeeper zk-0.zk:2181,zk-1.zk:2181,zk-2.zk:2181  --alter --topic readiness-$HOSTNAME --config retention.ms=1000
echo $HOSTNAME|/opt/kafka/bin/kafka-console-producer.sh --topic readiness-$HOSTNAME --broker-list $HOSTNAME.kafka:9092

STAT=$(/opt/kafka/bin/kafka-console-consumer.sh --topic readiness-$HOSTNAME --from-beginning --zookeeper zk-0.zk:2181,zk-1.zk:2181,zk-2.zk:2181 -timeout-ms 2000 )

/opt/kafka/bin/kafka-topics.sh --delete --topic readiness-$HOSTNAME  --zookeeper zk-0.zk:2181,zk-1.zk:2181,zk-2.zk:2181 


if [[ "$STAT" =~ "$HOSTNAME:" ]]; then
    echo "All is well";
    exit 0
else 
    echo "readiness failed";
    exit 1
fi