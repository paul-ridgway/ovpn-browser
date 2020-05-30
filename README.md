# OpenVPN Browser

## Running

A helper script `run.sh` is the easiest way to stat it, eg: `./run.sh ~/path/to/my-config.ovpn`

Arguments can be passed, eg the initial page:  `./run.sh ~/path/to/my-config.ovpn 'https://whatsmyip.org'`

To run a number of docker flags must be set as well as the X permissions:

```
# Allow X access
xhost +local:docker >> /dev/null

# Run docker
docker run --device=/dev/net/tun --cap-add=net_admin --env="DISPLAY=$DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" --volume="/tmp/.X11-unix:/tmp/.X11-unix" --volume="/my/vpn/config.ovpn:/config.ovpn"
```

Note: The vpn config is passed as a volume

## Behaviour

It will quit if either the VPN process exits or the browser is closed.