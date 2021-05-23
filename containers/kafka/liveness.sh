#!/bin/bash

/opt/kafka/bin/kafka-topics.sh --create --topic readiness-$HOSTNAME --bootstrap-server kafka-2.kafka:9092,kafka-0.kafka:9092,kafka-1.kafka:9092 --partitions 1 --replication-factor 2

# /opt/kafka/bin/kafka-topics.sh --bootstrap-server kafka-2.kafka:9092,kafka-0.kafka:9092,kafka-1.kafka:9092  --alter --topic readiness-$HOSTNAME --config retention.ms=1000
echo $HOSTNAME|/opt/kafka/bin/kafka-console-producer.sh --topic readiness-$HOSTNAME --bootstrap-server kafka-2.kafka:9092,kafka-0.kafka:9092,kafka-1.kafka:9092

STAT=$(/opt/kafka/bin/kafka-console-consumer.sh --topic readiness-$HOSTNAME --from-beginning --bootstrap-server kafka-2.kafka:9092,kafka-0.kafka:9092,kafka-1.kafka:9092 --timeout-ms 10000 )

/opt/kafka/bin/kafka-topics.sh --delete --topic readiness-$HOSTNAME  --bootstrap-server kafka-2.kafka:9092,kafka-0.kafka:9092,kafka-1.kafka:9092 


if [[ "$STAT" =~ "$HOSTNAME:" ]]; then
    echo "All is well";
    exit 0
else 
    echo "readiness failed";
    exit 1
fi