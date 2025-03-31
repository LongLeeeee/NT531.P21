### Monitoring K3s - OpenWhisk Cluster with Prometheus, Grafana & Icinga

<h6> Đây là đồ án môn hệ Đánh giá hiệu năng hệ thống máy tính - NT531. Hệ thống được triển khai giúp giải quyết một số vấn đề thực tiễn quan trọng trong việc giám sát và quản lý hiệu suất của các cụm Kubernetes, và có sự tích hợp với Apache Openwhisk.

### Mornitoring Tools
<ol>
  <li><strong>Prometheus </strong></li>
  ![Prometheus Logo] (https://github.com/LongLeeeee/NT531.P21/blob/main/prometheus_logo.png)
  <strong>Prometheus</strong> là một bộ công cụ mã nguồn mở dành cho giám sát hệ thống và cảnh báo. <strong>Prometheus</strong> thu thập và lưu trữ dữ liệu dưới dạng chuỗi thời gian, tức là mỗi thông tin về số liệu (<strong>metrics</strong>) sẽ được lưu kèm theo dấu thời gian ghi nhận, cùng với các cặp khóa - giá trị (<strong> labels</strong>) tùy chọn. 
  <li><strong>Grafana</strong></li>
  <strong>Grafana</strong> là một visualizer thể hiện các metrics thu thập từ nhiều nguồn như <strong>Prometheus</strong>, <strong>InfluxDB</strong>, <strong>Elasticsearch</strong>, <strong>MySQL</strong>, <strong>PostgreSQL</strong>,...dưới dạng các biểu đồ (<strong>chart</strong>) hoặc đồ thị (<strong>grap</strong>), được tập hợp lại thành dashboard có tính tùy biến cao, giúp dễ dàng theo dõi trạng thái của các node (<strong>CPU, RAM, DISK,...</strong>), trạng thái và thông tin về các dịch vụ (<strong>Nginx, OpenVPN, K8s, K3s</strong>),...
  <li><strong>Grafana Loki</strong></li>
  <strong>Grafana Loki</strong> là một hệ thống logging được tối ưu hóa cho việc lưu trữ và truy vấn log theo các hiệu quả, tương tự như cách <strong>Prometheus</strong> xử lý <strong>metrics</strong>. Nó được phát triển bởi <strong>Grafana Labs</strong> và đặc biệt phù hợp với các hệ thống <strong>container</strong> như <strong>Kubernetes</strong>.
  <li><strong>Aler Manager</strong></li>
  <strong>Aler Manager</strong> là một thành phần chính của <strong>Prometheus</strong>, có nhiệm vụ làm cấu nối giữa <strong>Prometheus</strong> và các ứng dụng hoặc hệ thống không hỗ trợ xuất <strong>metric</strong> theo định dạng của <strong>Prometheus</strong>
</ol>