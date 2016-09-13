#!/bin/bash
start="/opt/karaf/bin/start"
stop="/opt/karaf/bin/stop"
log="/opt/karaf/data/log/karaf.log"

$start

echo "Waiting for system to start"

sleep 20

timeout 15s tail -f $log

/opt/entrypoint/configure.sh

tail -f $log
