#!/bin/bash
curl -s https://go.dev/VERSION?m=text | head -n 1 > VER
VER=$(cat VER)
wget https://golang.org/dl/${VER}.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf ${VER}.linux-amd64.tar.gz

if ! grep -q '/usr/local/go/bin' /etc/environment; then
    echo 'PATH="$PATH:/usr/local/go/bin"' | sudo tee -a /etc/environment > /dev/null
    echo "Đã thêm đường dẫn vào /etc/environment"
else
    echo "Đường dẫn đã tồn tại, không cần thêm"
fi

source /etc/environment
wget https://github.com/kumina/openvpn_exporter/archive/v0.3.0.tar.gz
tar xzf v0.3.0.tar.gz 
cd openvpn_exporter-0.3.0/
nano main.go

echo "You has updatea main.go file. Countinue excuting...."

sudo chown -R $USER:$USER /usr/local/bin/
go build -o /usr/local/bin/openvpn_exporter main.go
openvpn_exporter --help

sudo tee /etc/systemd/system/openvpn_exporter.service > /dev/null <<EOF
[Unit]
Description=Prometheus OpenVPN Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
Type=simple
ExecStart=/usr/local/bin/openvpn_exporter
Restart=always
User=nobody
Group=nogroup

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo nano /etc/openvpn/server/server.conf

echo "You has updatea server.conf file. Countinue excuting...."

sudo chmod -R 755 /var/log/openvpn/
sudo systemctl restart openvpn-server@server
curl http://localhost:9176/metrics
