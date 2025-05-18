#!/bin/bash

#Cập nhật góigói
sudo apt update

#Cài đặt các gói cần thiết
if ! dpkg -s software-properties-common >/dev/null/ 2>&1; then
  sudo apt install -y software-properties-common
  echo "Package software-properties-common installed"
else 
  echo "Package software-properties-common is available"
fi


if ! dpkg -s curl >/dev/null/ 2>&1; then
  sudo apt install -y curl
  echo "Package curl installed"
else 
  echo "Package curl is available"
fi

#Thêm khóa GPG của Grafana
if [ ! -d /etc/apt/keyrings ]; then
  sudo mkdir -p /etc/apt/keyrings
    echo "Folder keyrings created"
else 
  echo "Folder keyrings is available"
fi

curl -fsSL https://packages.grafana.com/gpg.key | sudo tee /etc/apt/keyrings/grafana.asc > /dev/null


# Thêm repository của Grafana OSS
echo "deb [signed-by=/etc/apt/keyrings/grafana.asc] https://packages.grafana.com/oss/deb stable main" | sudo tee /etc/apt/sources.list.d/grafana.list
sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"

#Cập nhật lại gói
sudo apt update

#Cài đặt Grafana
if ! dpkg -s grafana >/dev/null 2>&1; then
  sudo apt install -y grafana
    echo "Grafana installed"
else 
  echo "Gafana is available"
fi

#Khởi động dịch vụ Grafana
sudo systemctl enable grafana-server
sudo systemctl start grafana-server

# Kiểm tra trạng thái dịch vụ
if systemctl is-active --quiet grafana-server; then
  echo "✅ Grafana started successfully."
else
  echo "❌ Grafana failed to start." >&2
  exit 1
fi
