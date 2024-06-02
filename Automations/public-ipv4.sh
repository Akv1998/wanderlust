#!/bin/bash

# Use curl to fetch the public IPv4 address from the metadata service
ipv4_address=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)

echo $ipv4_address
