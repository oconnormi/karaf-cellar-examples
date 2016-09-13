#!/bin/bash

client="/opt/karaf/bin/client"

echo "Adding load balancer to the cluster"

$client 'cluster:feature-install default cellar-http-balancer'

echo "Installing Webconsole"

$client 'feature:install webconsole'
