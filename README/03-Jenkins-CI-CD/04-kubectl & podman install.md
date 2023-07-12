## 3-4 명령어 설치(kubectl / podman)
### 3-4-1 kubectl 설치
apt 패키지 색인을 업데이트하고 쿠버네티스 apt 리포지터리를 사용하는 데 필요한 패키지들을 설치한다.
``` bash
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl
```
Debian 9(stretch) 또는 그 이전 버전을 사용하는 경우 apt-transport-https도 설치해야 한다.
``` bash
sudo apt-get install -y apt-transport-https
```
구글 클라우드 공개 사이닝 키를 다운로드한다.
``` bash
sudo curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
```
쿠버네티스 apt 리포지터리를 추가한다.
``` bash
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
```
새 리포지터리의 apt 패키지 색인을 업데이트하고 kubectl을 설치한다.
``` bash
sudo apt-get update
sudo apt-get install -y kubectl
```
### 3-4-2 podman 설치
#### 아래의 URL 참고 
https://www.lesstif.com/container/podman-98926748.html
- Ubuntu 20.10 이상부터는 podman 명령어를 apt-get으로 설치가 가능하다.
- PaaS-TA는 Ubuntu 20.04 OS를 사용하여, 아래의 스크립트로 kubic 저장소를 등록하고 podman 을 설치 진행
  ``` bash
  . /etc/os-release
  echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /" | sudo tee etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
  curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/Release.key | sudo apt-key add -
  sudo apt-get update
  sudo apt-get -y upgrade
  sudo apt-get -y install podman
  ```

