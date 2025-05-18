#!/bin/bash

# Kiểm tra và tải xuống Prometheus nếu thư mục không tồn tại
if [ ! -d prometheus-3.2.1.linux-amd64 ]; then
    echo "Directory prometheus-3.2.1.linux-amd64 does not exist, installing..."
    wget https://github.com/prometheus/prometheus/releases/download/v3.2.1/prometheus-3.2.1.linux-amd64.tar.gz
    tar -zxf prometheus-3.2.1.linux-amd64.tar.gz
    sudo useradd --system --no-create-home --shell /usr/sbin/nologin prometheus
    rm prometheus-3.2.1.linux-amd64.tar.gz
    cd prometheus-3.2.1.linux-amd64/
else
    echo "Directory prometheus-3.2.1.linux-amd64 is available"
fi

# Kiểm tra và tạo các thư mục cấu hình và dữ liệu của Prometheus
for dir in /etc/prometheus /var/lib/prometheus; do
    if [ ! -d "$dir" ]; then
        echo "Directory $dir does not exist, creating..."
        sudo mkdir -p "$dir"
    else
        echo "Directory $dir is available"
    fi
    sudo chown -R prometheus:prometheus "$dir"
done

# Di chuyển tệp Prometheus và promtool vào thư mục bin
for bin_file in prometheus promtool; do
    if [ ! -f /usr/local/bin/$bin_file ]; then
        echo "Moving $bin_file to /usr/local/bin/"
        sudo mv "$bin_file" /usr/local/bin/
    else
        echo "$bin_file is already available in /usr/local/bin/"
    fi
    sudo chown prometheus:prometheus /usr/local/bin/$bin_file
done

# Di chuyển tệp cấu hình Prometheus nếu không tồn tại
if [ ! -f /etc/prometheus/prometheus.yml ]; then
    echo "File /etc/prometheus/prometheus.yml does not exist, moving..."
    sudo mv prometheus.yml /etc/prometheus/
    sudo chown prometheus:prometheus /etc/prometheus/prometheus.yml
else
    echo "File /etc/prometheus/prometheus.yml is available"
fi

# Kiểm tra và tạo dịch vụ systemd cho Prometheus nếu không tồn tại
if [ ! -f /etc/systemd/system/prometheus.service ]; then
    echo "Creating Prometheus systemd service..."
    sudo tee /etc/systemd/system/prometheus.service > /dev/null <<EOF
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus --config.file=/etc/prometheus/prometheus.yml --storage.tsdb.path=/var/lib/prometheus --web.listen-address=:9090 --storage.tsdb.retention.time=15d

[Install]
WantedBy=multi-user.target
EOF

else
    echo "Prometheus systemd service already exists."
fi

# Reload daemon và enable Prometheus service
sudo systemctl daemon-reload
sudo systemctl enable prometheus
sudo systemctl start prometheus

# Kiểm tra xem Prometheus có chạy không
if systemctl is-active --quiet prometheus; then
    echo "✅ Prometheus started successfully."
    curl http://localhost:9090/api/v1/targets
else
    echo "❌ Prometheus failed to start." >&2
    exit 1
fi
