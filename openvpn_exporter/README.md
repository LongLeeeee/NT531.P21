### OpenVPN Exporter
<strong>OpenVPN Exporter</strong> dành cho <strong>Prometheus</strong> là một dự án mã nguồn mở trên GitHub (hiện đang được lưu trữ) dự án Kumina’s openvpn-exporter.

*Lưu ý: Đã cài đặt OpenVPN thành công thì mới tiếp tục cài OpenVPN ExporterExporter
### Quick start
```sh
git clone https://github.com/LongLeeeee/NT531.P21/blob/main/openvpn_exporter/openvpn_exporter_install.sh
chmod +x openvpn_exporter_install.sh
./openvpn_exporter_install.sh
```
Khi thực thi đến file main.go, hãy thay thế <strong>openvpnStatusPaths</strong> bằng dòng bên dưới.
```sh
  openvpnStatusPaths = flag.String("openvpn.status_paths", "/var/log/openvpn/openvpn-status.log", "Paths at which OpenVPN places its status files.")
```
Kế đến khi đến file server.conf hãy thêm vào câu bên dưới.
```sh
status /var/log/openvpn/openvpn-status.log
log /var/log/openvpn/openvpn.log
```

### Triển khai
<ol>
  <li>
  <strong> Cài đặt Go </strong>

  OpenVPN Exporter được viết dựa trên Go. Vì vậy bạn cần cài đặt Go để có thể chạy được OpenVPN Expoter.
  Phiên bản Go mới nhất:

  ```sh 
    curl -s https://go.dev/VERSION?m=text
  ```
  Cập nhật giá trị của VER với phiên bản hiện tại của Go. Giả sử version là 1.24.1
  ```sh
  expose VER=1.24.1
  wget https://golang.org/dl/go${VER}.linux-amd64.tar.gz
  ``` 
  Tải về và giải nén nó vào trong /usr/local.
  ```shsh
  sudo tar -C /usr/local -xzf go${VER}.linux-amd64.tar.gz
  ```
  Thêm /usr/local/go/bin vào biến môi trường PATH.
  ```sh
  sudo nano /etc/environment
  ```
  Thêm hoặc cập nhật dòng PATH như bên dưới
  ```sh
  PATH="$PATH:/usr/local/go/bin"
  ```
  Nạp tệp để áp dụng các thay đổi.
  ```sh
  source /etc/environment
  ```
  "Go bây giờ nên có trong PATH của bạn.
  ```sh
  which go
  /usr/local/go/bin/go
  ```
  </li> 
  <li>Tải OpenVPN Exporter
  
    Tải phiên bản OpenVPN hiện tại từ GitHub
  ```sh
  wget https://github.com/kumina/openvpn_exporter/archive/v0.3.0.tar.gz
  ```
  </li>
  <li>Cài đặt OpenVPN Exporter
  
  Giải nén file
  ```sh
  tar xzf v0.3.0.tar.gz
  ```
  Kế tiếp build OpenVPN Exporter
  ```sh
  cd openvpn_exporter-0.3.0/
  vim main.go
  ```
  </li>
  Cập nhật đường dẫn file ghi trạng thái của OpenVPN, <strong> openvpnStatusPaths</strong>.
  
  ```sh
  func main() {
        var (
                listenAddress      = flag.String("web.listen-address", ":9176", "Address to listen on for web interface and telemetry.")
                metricsPath        = flag.String("web.telemetry-path", "/metrics", "Path under which to expose metrics.")
                // openvpnStatusPaths = flag.String("openvpn.status_paths", "examples/client.status,examples/server2.status,examples/server3.status", "Paths at which OpenVPN places its status files.")
                openvpnStatusPaths = flag.String("openvpn.status_paths", "/var/log/openvpn/openvpn-status.log", "Paths at which OpenVPN places its status files.")
                ...
  ```
  Lưu lại và tiến hành chạy OenVPN Exporter

  ```shsh
  sudo chown -R $USER:$USER /usr/local/bin/
  go build -o /usr/local/bin/openvpn_exporter main.go
  ```

  Kiểm tra xem OpenVPN Exporter có thể chạy được chưa.

  ```sh
  openvpn_exporter --help
  ```

  ```sh
  -ignore.individuals
    	If ignoring metrics for individuals
  -openvpn.status_paths string
    	Paths at which OpenVPN places its status files. (default "/var/log/openvpn/openvpn-status.log")
  -web.listen-address string
    	Address to listen on for web interface and telemetry. (default ":9176")
  -web.telemetry-path string
    	Path under which to expose metrics. (default "/metrics")
  ```
  <li><strong>Chạy OpenVPN dưới dạng Service</strong></li>
  Tạo một systemd server dành cho OpenVPN Exporter.

  ```sh
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
```
  Lưu lại và load cấu hình
  
  ```sh
  sudo systemctl daemon-reload
  ```
  Thêm đường dẫn file log.

  ```sh
  cd /etc/openvpn/server
  sudo nano server.conf
  ```
  Sau đó chèn câu lệnh bên dưới vào.
  ```sh
  status /var/log/openvpn/openvpn-status.log
  log /var/log/openvpn/openvpn.log
  ```
  Cấp quyền cho dịch vụ có thể truy cập đến các file của OpenVPN
  
  ```sh
  sudo chmod -R 755 /var/log/openvpn/
  ```
  Khởi chạy OpenVPN Exporter 
  ```sh
  sudo systemctl restart openvpn-server@server
  ```
  Kết quả:

  ```sh
  ● openvpn_exporter.service - Prometheus OpenVPN Node Exporter
     Loaded: loaded (/etc/systemd/system/openvpn_exporter.service; enabled; preset: enabled)
     Active: active (running) since Wed 2023-10-04 15:43:42 EDT; 6s ago
   Main PID: 9415 (openvpn_exporte)
      Tasks: 4 (limit: 2304)
     Memory: 4.9M
        CPU: 7ms
     CGroup: /system.slice/openvpn_exporter.service
             └─9415 /usr/local/bin/openvpn_exporter

Oct 04 15:43:42 debian openvpn_exporter[9415]: 2023/10/04 15:43:42 Listen address: :9176
Oct 04 15:43:42 debian openvpn_exporter[9415]: 2023/10/04 15:43:42 Metrics path: /metrics
Oct 04 15:43:42 debian openvpn_exporter[9415]: 2023/10/04 15:43:42 openvpn.status_path: /var/log/openvpn/openvpn-status.log
Oct 04 15:43:42 debian openvpn_exporter[9415]: 2023/10/04 15:43:42 Ignore Individuals: false
Oct 04 15:43:42 debian systemd[1]: Started openvpn_exporter.service - Prometheus OpenVPN Node Exporter.
```
OpenVPN Exporter đã khỏi chạy thành công. Cổng mặc định của service là 9176. Thử lệnh sau để kiểm tra xem có lấy được metric không.

```sh
curl http://localhost:9176/metrics
```

```sh
...
# HELP openvpn_up Whether scraping OpenVPN's metrics was successful.
# TYPE openvpn_up gauge
openvpn_up{status_path="/var/log/openvpn/openvpn-status.log"} 1
# HELP process_cpu_seconds_total Total user and system CPU time spent in seconds.
# TYPE process_cpu_seconds_total counter
process_cpu_seconds_total 0.36
# HELP process_max_fds Maximum number of open file descriptors.
# TYPE process_max_fds gauge
process_max_fds 524288
# HELP process_open_fds Number of open file descriptors.
# TYPE process_open_fds gauge
process_open_fds 10
# HELP process_resident_memory_bytes Resident memory size in bytes.
# TYPE process_resident_memory_bytes gauge
process_resident_memory_bytes 1.245184e+07
# HELP process_start_time_seconds Start time of the process since unix epoch in seconds.
# TYPE process_start_time_seconds gauge
process_start_time_seconds 1.7421305415e+09
...
```
</ol>

### Unstall OpenVPN Exporter
```sh
wget https://github.com/LongLeeeee/NT531.P21/blob/main/openvpn_exporter/openvpn_exporter_uninstall.sh
chmod +x openvpn_export_uninstall.sh
```