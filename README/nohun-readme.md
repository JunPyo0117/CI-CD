<details>
<summary> # 작성 완료 </summary>
  
[완료] 3-3 젠킨스 깃허브 연동(webhook/ credentials)  
[완료] 3-4 명령어 설치(kubectl / podman)

</details>

---

# 3. Jenkins를 사용한 파이프라인 구축


  
## 3-3 젠킨스 깃허브 연동(webhook/ credentials)   
<details>
<summary> 접기 / 펼치기 </summary>

- #### Jenkins와 github를 연동하여 github에서 push 될 때, 자동으로 Jenkins에서 빌드가 실행되는 환경을 만드는 작업이다.
###  3-3-1 github 토큰 발급
- github -> settings -> developer settings -> Personal access tokens
- 토큰 생성  
  ![image](https://github.com/mnh4140/paasta/assets/71053769/7102909f-16a0-446f-b21a-7fe9170b5143)
- 생성한 토큰 확인
  ![image](https://github.com/mnh4140/paasta/assets/71053769/59eceb1f-796f-4bba-864d-7138a03cd72b)  

### 3-3-2 webhook 설정
- github 레퍼지토리 설정 -> Webhooks 메뉴에서 젠킨스 연동 설정 진행
  ![image](https://github.com/mnh4140/paasta/assets/71053769/69db9041-3e45-4adc-abbb-c43a4c6e84d1)
- 설정 완료 후 초록색 체크 확인
  ![image](https://github.com/mnh4140/paasta/assets/71053769/e5fce2ff-7d8f-4f4e-ba8a-39add9c23aa6)  
  
### 3-3-3 Jenkins Credentials 생성
- Jenkins 관리 > Credentials > System > Global credentials (unrestricted) > Add Credentials 클릭
  ![image](https://github.com/mnh4140/paasta/assets/71053769/5fee4aa3-8bec-4e7c-85ac-d2aca65dc82d)
- 아래 그림과 같이 설정 값 입력
  ![image](https://github.com/mnh4140/paasta/assets/71053769/11fa9f84-61b7-45c5-a9f7-70bd6c38ca4d)  

### 3-3-4 Jenkins Item 생성
- 아이템 생성 클릭 > Pipeline 선택 후 ok 클릭
  ![image](https://github.com/mnh4140/paasta/assets/71053769/e7178590-a97b-4ce5-9b0e-bc29c6dbec71)
- Configure > Build Triggers 에서 "GitHub hook trigger for GITScm polling" 선택
  ![image](https://github.com/mnh4140/paasta/assets/71053769/1f78102c-b9cd-47f3-8b71-5d8995a30ed3)
- Configure > Pipeline 하위 항목 설정
  ![image](https://github.com/mnh4140/paasta/assets/71053769/bbf1a54e-2467-4ace-aa49-ecd0f1b94daf)  

### 3-3-5 자동 빌드 확인
- 최초 설정 이후 수동 빌드 실행
  ![image](https://github.com/mnh4140/paasta/assets/71053769/c57396f8-1ee5-4739-bc20-857f674bc65c)
- 이후 연동한 github repogitory에서 push 발생 시, 자동으로 Jenkins에서 빌드가 실행 됨
  - GitHub Hook Log 메뉴에서 github push 이벤트 발생 유무 확인 가능
    ![image](https://github.com/mnh4140/paasta/assets/71053769/040761c1-a7b3-4b5c-ac3a-8f9caa6d4d6b)
    ![image](https://github.com/mnh4140/paasta/assets/71053769/4937a91d-2f2b-4d38-b0af-377fe81be88d)
</details>


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

