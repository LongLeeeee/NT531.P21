#!/bin/bash
sudo apt update
sudo apt install -y software-properties-common
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://packages.grafana.com/gpg.key | sudo tee /etc/apt/keyrings/grafana.asc > /dev/null
echo "deb [signed-by=/etc/apt/keyrings/grafana.asc] https://packages.grafana.com/oss/deb stable main" | sudo tee /etc/apt/sources.list.d/grafana.list
sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"
sudo apt update
sudo apt install -y grafana
sudo systemctl enable grafana-server
sudo systemctl start grafana-server
sudo systemctl status grafana-server

