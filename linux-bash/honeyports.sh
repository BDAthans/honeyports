#!/bin/bash

port=22

echo "Honeyports started..."
echo "listening on port: $port"

while [ 1 ]
do
	IP=""
	IP=$(nc -nvlp $port 2>&1 | grep "connect to" | awk '{print $6;}' | tr -d '[]')
	if [ -n $IP ]; then
		iptables -A INPUT -p tcp -s $IP -j DROP
    		echo -- $IP has been blocked.
    		echo $IP >> blocked.log
	fi
done
