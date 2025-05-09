#!/bin/bash
sudo apt remove --purge openvpn -y
sudo apt autoremove --purge -y
sudo rm -rf /etc/openvpn
sudo rm -rf /var/log/openvpn
sudo rm -rf /usr/share/doc/openvpn*
rm openvpn-install.sh
echo "uninstallation has been successfully completed!!"
