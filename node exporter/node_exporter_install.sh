#!/bin/bash
sudo apt-get update
sudo apt install prometheus-node-exporter -y
sudo systemctl enable --now prometheus-node-exporter
