## Labels
태그 처럼 속성 등을 입력해주는 것 레이블 Labels
Selectors 특정 Label 선택 &조건 가능

yaml 원하는 만틈 label 붙임 키-밸류 값
```bash
kubectl get pods --selector app=App1
```

## Selectors
특정 라벨의 pods 수 출력
```bash
kubectl get pods --selector app=App1 --no-headers | wc -l
```
여러 라벨 선택
```bash
kubectl get pods --selector env=prod,bu=finance,tier=frontend
```

## Taints and Tolerations

```bash
kubectl taint nodes node-name key=value:taint-effect
```
taint-effect옵션 > Noschedule | PreferNoSchedule | NoExcute
ex)
```bash
kubectl taint nodes node1 app= blue:NoSchedule
```
#### Toleration Pods 셋팅
pod-definition.yaml
```yaml
apiVersion:
kind:
metadata:
  name:
spec:
  containers:
  - name:
    image:
  tolerations:
  - key: "app"
    operator: "Equal"
    value: "blue"
    effect: "NoSchedule"
```
마스터 노드에는 자동으로 taint 설정
pod 설치하지 않음
```bash
kubectl describe node kubemaster | grep Taint
```
node01에 key는 spray, value는 mortein, effect는 NoSchedule 인 taint 적용
ex)
```bash
kubectl taint nodes node01 spray=mortein:NoSchedule
```
+ toleration 적용된 pod 만들기
```bash
kubectl run bee --imgae=nginx --dry-run=client -o yaml > bee.yaml
```
```yaml
spec:
  toleration:
  - key: spray
    value: mortein
    effect: NoSchedule
    operator: Equal
```
```bash
kubectl create -f bee.yaml
kubectl get pods --watch 
```
+ taint 삭제(마지막에 바를 넣어준다)
```bash
kubectl taint nodes controlplane node-role.kubernetes.io/control-plane:NoSchedule-
```

## Node Selector

노드 사양에 따라 Label 설정
```bash
kubectl label nodes <node-name> <label-key>=<label-value>
```
유용하지만 한계
복잡한 환경에서 어려움 -> 해결법 node affinity


## Node Affinity
```bash
kubectl create deployment red --image=nginx --replicas=2 --dry-run -o yaml >red.yaml
```
ex) red.yaml
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: red
  name: red
spec:
  replicas: 2
  selector:
    matchLabels:
      app: red
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: red
    spec:
      containers:
      - image: nginx
        name: nginx
        resources: {}
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
              - key: node-role.kubernetes.io/control-plane
                operator: Exists
status: {}
```
