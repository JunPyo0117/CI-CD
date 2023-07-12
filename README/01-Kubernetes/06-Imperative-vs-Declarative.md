## Imperative
+ **명령적**
+ 원하는 상태를 만들기 위해 필요한 동작을 명령어 한 줄로 지시
+ step by step 단계별 지침서
+ Create Objects : `create`
+ Update Objects : `replace` `edit` `delete` 등
+ 단점
  + 명령어만으로 수행가능한 작업 제한
  + 작업내역 추적이 어려움
  + 현재 작업 환경의 설정사항을 직접 파악해야 함

## Declarative
+ **선언적**
+ 요구사항 선언 (ex. Ansible, Puppet, Chef, Terraform)
+ yaml 파일에 오브젝트를 정의하고 `apply`로 생성
+ Create Objects : `apply`
+ Update Objects : `apply`
+ 단점
  + 간단한 작업의 경우 yaml 파일 정의가 번거로움


## Tips!
### 1. POD
#### 1.1 Create an NGINX Pod
```bash
kubectl run nginx --image=nginx
```
#### 1.2 Generate POD Manifest YAML file (-o yaml). Don't create it(--dry-run)
```bash
kubectl run nginx --image=nginx --dry-run=client -o yaml
```


### 2. Deployment
#### 2.1 Create a deployment
```bash
kubectl create deployment --image=nginx nginx
```
#### 2.2 Generate Deployment YAML file (-o yaml). Don't create it(--dry-run)
```bash
kubectl create deployment --image=nginx nginx --dry-run=client -o yaml
```
#### 2.3 Generate Deployment with 4 Replicas
```bash
kubectl create deployment nginx --image=nginx --replicas=4
```
#### 2.4 You can also scale a deployment using the kubectl scale command.
```bash
kubectl scale deployment nginx --replicas=4
```
#### 2.5 Another way to do this is to save the YAML definition to a file and modify
```bash
kubectl create deployment nginx --image=nginx --dry-run=client -o yaml > nginx-deployment.yaml
```


### 3. Service
#### 3.1 Create a Service named redis-service of type ClusterIP to expose pod redis on port 6379
```bash
kubectl expose pod redis --port=6379 --name redis-service --dry-run=client -o yaml
```
or
```bash
kubectl create service clusterip redis --tcp=6379:6379 --dry-run=client -o yaml
```
#### 3.2 Create a Service named nginx of type NodePort to expose pod nginx's port 80 on port 30080 on the nodes:
```bash
kubectl expose pod nginx --type=NodePort --port=80 --name=nginx-service --dry-run=client -o yaml
```
