### Cài đặt kube-state-metric bằng Helm

#### Yêu cầu: Kubernetes và Helm
[Kubernetes](https://kubernetes.io/) là nền tảng điều phối container tự động triển khai, mở rộng và quản lí các ứng dụng được đóng gói. [Helm](https://helm.sh/) là một trình quản lí packet cho Kubernetes giúp đơn giản hóa việc quản lí các ứng dụng Kubernetes.

### Quick Start

```sh
https://github.com/LongLeeeee/NT531.P21/blob/main/pod_mornitor/kube_state_metric_install.sh
chmod +x kube_state_metric_install.sh
```

### Triển khai kube-state-metric
Thêm repository Prometheus Community và Helm để cài đặt các Helm Chart.

```sh
helm repo add kube-state-metrics https://kubernetes.github.io/kube-state-metrics
helm repo update
```
Cài đặt kube-state-metric trên kubernetes bằng Helm

```sh
helm install my-kube-state-metrics kube-state-metrics/kube-state-metrics 
```

Kiểm tra sau khi cài đặt.

```sh
kubectl get svc my-kube-state-metrics -o wide
```

```sh
NAME                    TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE   SELECTOR
my-kube-state-metrics   NodePort   10.43.220.165   <none>        8080:31388/TCP   9d    app.kubernetes.io/instance=my-kube-state-metrics,app.kubernetes.io/name=kube-state-metrics
```
Nếu TYPE của kube-state-metrics là ClusterIP thì cần đổi kiểu NodePort hoặc Load Balancer để Prometheus có thể truy cập đến được.

```sh
kubectl patch svc my-kube-state-metrics --type='json' -p='[{"op":"replace","path":"/spec/type","value":"NodePort"}]'
```
