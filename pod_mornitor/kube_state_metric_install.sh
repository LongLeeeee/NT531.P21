#!bin/bash
sudo helm repo add kube-state-metrics https://kubernetes.github.io/kube-state-metrics
sudo helm repo update
sudo helm install my-kube-state-metrics kube-state-metrics/kube-state-metrics 
sudo kubectl get pods -l app.kubernetes.io/name=kube-state-metrics
sudo kubectl patch svc my-kube-state-metrics --type='json' -p='[{"op":"replace","path":"/spec/type","value":"NodePort"}]'
