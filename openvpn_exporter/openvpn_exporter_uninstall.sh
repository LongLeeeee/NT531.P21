#!/bin/bash
sudo systemctl stop openvpn-server@server
sudo systemctl disable openvpn-server@server
sudo rm -f /usr/local/bin/openvpn_exporter
sudo rm -f /usr/bin/openvpn_exporter
sudo rm -f /etc/systemd/system/openvpn_exporter.service
sudo systemctl daemon-reload
sudo systemctl reset-failed
sudo rm -rf /etc/openvpn_exporter
sudo rm -rf /var/lib/openvpn_exporter
sudo rm -rf go
rm go1.24.1.linux-amd64.tar.gz
rm v0*
rm -rf openvpn_exporter-
echo "You deleted successfully openvpn exporter!"
