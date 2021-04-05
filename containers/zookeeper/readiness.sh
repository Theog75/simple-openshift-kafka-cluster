#!/bin/bash

STAT=$(/opt/zookeeper/bin/zkServer.sh status 2>&1|grep Mode)

if [[ "$STAT" =~ "Mode:" ]]; then
    echo "All is well";
    exit 0
else 
    echo "readiness failed";
    exit 1
fi