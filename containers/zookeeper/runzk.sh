#!/bin/bash

while [ -z "$DNSRES"  ]; do
   sleep 1;
   DNSRES=`ping -c1 ${HOSTNAME}.zk|grep "0% packet loss"`;
   echo "cannot resolve hostname "${HOSTNAME}".zk";
done

ID=$(echo "$HOSTNAME" |sed -r  's/zk-([0-9])/\1/')
MYID=$(expr $ID + 1)

echo $MYID > /data/myid

echo "!!!!!! Starting ZooKeeper with ID: "$MYID
/opt/zookeeper/bin/zkServer.sh start-foreground
