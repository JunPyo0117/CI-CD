# 1-9 Imperative vs Declarative

## 1-9-1 Imperative
+ **명령적**
+ 원하는 상태를 만들기 위해 필요한 동작을 명령어 한 줄로 지시
+ step by step 단계별 지침서
+ Create Objects : `create`
+ Update Objects : `replace` `edit` `delete` 등
+ 단점
  + 명령어만으로 수행가능한 작업 제한
  + 작업내역 추적이 어려움
  + 현재 작업 환경의 설정사항을 직접 파악해야 함

## 1-9-2 Declarative
+ **선언적**
+ 요구사항 선언 (ex. Ansible, Puppet, Chef, Terraform)
+ yaml 파일에 오브젝트를 정의하고 `apply`로 생성
+ Create Objects : `apply`
+ Update Objects : `apply`
+ 단점
  + 간단한 작업의 경우 yaml 파일 정의가 번거로움

