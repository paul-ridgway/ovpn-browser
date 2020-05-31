#!/bin/bash
set -e
if [ $# -eq 0 ]; then
    echo "Usage: run.sh my-config.ovpn"
    exit -1
fi
CONFIG=$1
shift
xhost +local:docker >> /dev/null
docker run \
    --device=/dev/net/tun \
    --cap-add=net_admin \
    --env="DISPLAY=$DISPLAY" \
    --env="DBUS_SESSION_BUS_ADDRESS=\"disabled:\"" \
    --volume="$HOME/.Xauthority:/root/.Xauthority:rw" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix" \
    --volume="$CONFIG:/config.ovpn" \
    -it --rm \
    ovpn-browser $@