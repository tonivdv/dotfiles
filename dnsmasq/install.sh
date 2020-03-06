#!/bin/bash
cd "$(dirname "$0")"
sudo ln -sfn $(pwd)/dnsmasq.conf $(brew --prefix)/etc/dnsmasq.conf

sudo brew services restart dnsmasq

if [ ! -d /etc/resolver ]; then
  sudo mkdir /etc/resolver
fi

sudo bash -c 'echo "nameserver 127.0.0.1" > /etc/resolver/lan'
