### Cài đặt Prometheus

Để cài được <strong>Prometheus</strong> ta cần khá nhiều lệnh vậy nên nhóm đã tập họp các câu lệnh vào một file shell để chỉ cần thực thi một lần sẽ chạy tất cả các câu lệnh mà không tốn nhiều thời gian. Tải file <strong>prometheus_install.sh</strong>, sau đó cấp quyền thực thi và chạy file.

```sh
wget https://github.com/LongLeeeee/NT531.P21/blob/main/prometheus/prometheus_install.sh
chmod +x prometheus_install.sh
./prometheus_install.sh
```

### Cấu hình để Prometheus thu thập metrics

<ol>
<li> <strong>Phần golal</strong>

Phần này liên quan đến các giá trị như thời gian thu thập dữ liệu từ các endpoint (scrape_interval), thời gian đánh giá các rule (evaluation_interval),... Phần này không quá quan trọng nên nhóm để toàn bộ theo mặc định của file khi tải về.

</li>
<li> <strong>Phần alerting </strong>

Đây là phần chịu trách nhiệm kết nối <storng>Prometheus</strong> với <strong>Alertmanager</strong>.

```sh
- targets:
   - localhost:9093
```

Giá trị của phần targets là các địa chỉ IP và port nơi các Alertmanager được cài đặt. Có thể có nhiều Alertmanager.

</li>
<li><strong>Phần rule_files</strong>

Đây là các file được chỉ định chứa các quy tắc cảnh báo sẽ được <strong>Prometheus</strong> tham chiếu tới để đánh giá.

```sh
rule_files:
  - rules/fisrt_rules.yml
  - rules/second_rules.yml
  - rules/third_rules.yml
```

Như ví dụ trên thì folder rules sẽ nằm cùng cấp với với file prometheus.yml. Bên trong folder chứ 3 file chứa các quy tắc.

</li>
<li><strong>Phần scrape_configs:</strong>

Phần này dùng để khai báo các target mà <strong>Prometheus</strong> sẽ thu thập dữ liệu. Tại đây sẽ chứa danh sách các job <strong>Prometheus</strong> sẽ thu thập metric. Chúng ta có thể tạo các job theo các vai trò ví dụ như thu thập số liệu về cpu, ram,..., giám sát web server, giám sát các kết nối VPN,.....

```sh
  - job_name: "openvpn-exporter"
    static_configs:
      - targets:
        - "10.0.3.154:9176"
```

Đây là ví dụ về cấu trúc của một job gồm tên và các target để thu thập metric.

</li>
</ol>

### Cấu hình Alertmanager

Vì <strong>Prometheus</strong> đã cài đặt nên ta không cần cài đặt thêm <strong>Alertmanager</strong> vì nó đã nằm bên trong <strong>Prometheus</strong>. Để nhận được các cảnh báo bất thường từ <strong>Alertmanager</strong>, nhóm đã tạo một chatbot trên telegram để tự động thông báo và gửi tin nhắn thông báo.

Trong file <strong>alertmanager.yml</strong> các thông số liên quan đến thời gian nhóm đều để mặc định chỉ thay đổi các thành phần liên quan đến bên thứ để nhận thông báo.

Tại phần route, receiver sẽ là telegram.

```sh
route:
  receiver: 'telegram'
```

Tại phần cấu hình chi tiết về receiver sẽ bao gồm các thông tin:

- name: tên ứng dụng sủ dụng
- telegram_configs: chứa các thông tin bao gồm token của chatbot, url telegram, id của phòng chat, cấu trúc của tin nhắn thông báo. Cấu trúc của tin nhắn nhóm chọn template. Template tin nhắn là file <strong>telegram.tmpl</strong>

```sh
receivers:
- name: 'telegram'
  telegram_configs:
  - bot_token: 'token'
    api_url: https://api.telegram.org
    chat_id: id
    message: '{{ template "telegram.yucca.message" . }}'

templates:
  - "/etc/alertmanager/templates/telegram.tmpl"
```
