# 3-2 Jenkins 설치
- 설치 최소 요구사항
  - CPU : 1Core
  - MEM : 1GB
  - HDD : 1GB
- 소규모 팀 권장 사양
  - CPU : 4Core
  - MEM : 4GB
  - HDD : 50GB
   
---

- Ubuntu 서버 설치 방법
```bash
sudo apt-get install openjdk-11-jdk -y
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update
sudo apt-get install jenkins -y

sudo systemctl enable jenkins
sudo systemctl start jenkins
```

- CentOS 서버 설치 방법
```bash
# CentOS
yum list java*jdk-devel
sudo yum install -y java-11-openjdk-devel.x86_64
sudo update-alternatives --config java
java –verison

# Jenkins install
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo 
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum install jenkins -y
   
sudo systemctl enable jenkins
sudo systemctl start jenkins
```
   
- Jenkins 초기 비밀번호
```bash
cat /var/lib/jenkins/secrets/initialAdminPassword
```

- Jenkins Port는 기본적으로 `TCP 8080`이며 config 파일을 통해 변경
```bash
# CentOS 경우
sudo vim /etc/sysconfig/jenkins
  JENKINS_PORT="8080"
   
# Ubuntu 경우
sudo vim /lib/systemd/system/jenkins.service
  Environment="JENKINS_PORT=8080" # 원하는 포트 번호로 수정
   
systemctl restart jenkins
```
