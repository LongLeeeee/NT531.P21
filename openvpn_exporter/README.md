### OpenVPN Exporter
<strong>OpenVPN Exporter</strong> dành cho <strong>Prometheus</strong> là một dự án mã nguồn mở trên GitHub (hiện đang được lưu trữ) dự án Kumina’s openvpn-exporter.

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

</ol>