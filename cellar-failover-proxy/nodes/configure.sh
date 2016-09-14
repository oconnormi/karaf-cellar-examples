#!/bin/bash

client="/opt/karaf/bin/client"

echo "Installing Webconsole"

$client 'cluster:feature-install webconsole'
