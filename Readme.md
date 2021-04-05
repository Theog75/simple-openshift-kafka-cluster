# kafak create topic

```
/opt/kafka/bin/kafka-topics.sh --create --topic quickstart-events1 --zookeeper zk-0.zk:2181 --partitions 1 --replication-factor 2
```

# Kafka describe topic

```
/opt/kafka/bin/kafka-topics.sh  --zookeeper zk-0.zk:2181,zk-1.zk:2181,zk-2.zk:2181 --describe --topic quickstart-events1
```

# Kafka produce to queue

```
/opt/kafka/bin/kafka-console-producer.sh --topic quickstart-events1 --broker-list kafka-0.kafka:9092,kafka-1.kafka:9092,kafka-2.kafka:9092
```

# Kafka consume from queue

```
/opt/kafka/bin/kafka-console-consumer.sh --topic quickstart-events1 --from-beginning --zookeeper zk-0.zk:2181,zk-1.zk:2181,zk-2.zk:2181
```