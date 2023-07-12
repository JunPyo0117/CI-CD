## DaemonSets

> 모든 노드에 파드의 사본을 실행. Replica Sets 유사.   
> 신규 노드가 추가되면 자동으로 파드가 복제되며, 노드가 삭제되면 파드도 삭제된다.
      
#### 대표적인 용도
> 모든 노드에서 클러스터 스토리지 데몬 실행   
> 모든 노드에서 로그 수집 데몬 실행   
> 모든 노드에서 노드 모니터링 데몬 실행   
   
   
```bash
kubectl get daemonsets
kubectl describe daemonsets monitoring-daemon

kubectl get daemonsets --all-namespaces
kubectl get daemonsets -A
kubectl describe daemonsets kube-proxy -n kube-system

# yaml 양식은 deployment 와 동일하며 kind 등 특정 속성만 바꿔주면 됨
kubectl create deployment elasticsearch --image=registry.k8s.io/fluentd-elasticsearch:1.20 -n kube-system --dry-run -o yaml > fluentd.yaml
kubectl create -f fluentd.yaml
```
   
ex) fluentd.yaml
```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  creationTimestamp: null
  labels:
    app: elasticsearch
  name: elasticsearch
  namespace: kube-system
spec:
  selector:
    matchLabels:
      app: elasticsearch
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: elasticsearch
    spec:
      containers:
      - image: registry.k8s.io/fluentd-elasticsearch:1.20
        name: fluentd-elasticsearch
        resources: {}
```
   
## Static Pods
kubelet 각각 노드를 관리할 수 있음   
단일 노드의 경우, 쿠버네티스클러스터서버와 api서버가 없으므로 pod 정의 파일은 쿠블레 설정파일에서 읽음(서버의 디렉터리)   
+ pod 정의 directory 경로   
+ /var/lib/kubelet/config.yaml
   
=> 이렇게 생성된 pod를 static pods 라고 함   
정적 포드는 쿠버네티스제어(controller)에 제한 받지 않음   
서비스 충돌 방지 용도로 사용   
생성된 포드 NAME 끝에 -nodename 추가   
   
ex)
```bash
kubectl run static-busybox --image=busybox --dry-run=client -o yaml --command -- sleep 1000 > static-busybox.yaml
cp static-busybox.yaml /etc/kubernetes/manifests/
kubectl get pods --watch
```

   
## Multiple Schedulers
+ kube-Scheduler를 활용하지 않고 개별 스케줄러를 생성하여 리소스 배포 시 사용 가능
+ 또한 1개가 아닌 여러개의 스케줄러를 동시에 사용 가능
   
적용확인
```bash
kubectl get events -o wide
```

## Scheduler Profiles 
 
