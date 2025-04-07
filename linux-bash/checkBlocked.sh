#!/bin/bash

echo Starting check on blocked IPs...

for ip in `cat blocked.log`;
do
	if [ -n $ip ]; then
		echo "-- checking IP: $ip"
		info=$(whois $ip)

		# Get netname
		netname=$(echo "$info" | grep -m 1 -i "netname" | awk '{print $2;}')

		# Get Org Name
		orgname=$(echo "$info" | grep -m 1 -i "orgname" | awk '{print $2, $3, $4, $5;}')
		if [ -z "$orgname" ]; then
			orgname=$(echo "$info" | grep -m 1 -i "org-name" | awk '{print $2, $3, $4, $5;}')
		fi

		# Get address
		address=$(echo "$info" | grep -m 1 -i "address" | awk '{print $2, $3, $4, $5, $6;}')

		# Get country
		country=$(echo "$info" | grep -m 1 -i "country" | awk '{print $2, $3, $4;}')

		# Output and write to log
		echo "IP: $ip, NetName: $netname, OrgName: $orgname, Address: $address, Country: $country" | tee -a checked-IPs.log
		echo ""
	fi
done
