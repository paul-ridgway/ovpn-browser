#!/bin/bash

function myip {
	echo $(dig TXT +short o-o.myaddr.l.google.com @ns1.google.com | awk -F'"' '{ print $2}')
}

IP=$(myip)
echo "Normal IP: $IP"

echo "Starting OpenVPN..."
openvpn config.ovpn & p1=$!

echo "Waiting for IP change..."
NEWIP=$(myip)
while [ "$IP" = "$NEWIP" ]; do
	sleep 1
	echo "> Wait, still $NEWIP..."
	NEWIP=$(myip)
done
echo "IP Changed, now $NEWIP"

google-chrome --no-sandbox --disable-gpu $@ & p2=$!
wait -n
[ "$?" -gt 1 ] || (echo "VPN or Chrome exited, quitting!"; kill "$p1" "$p2")
wait

