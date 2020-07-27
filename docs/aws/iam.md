# IAM

## IAM이란?
* **Identity and Access Management**의 약자
* AWS 리소스에 대한 접근 방식과 권한을 관리해주는 서비스

<br>

## IAM 사용자(Users)
* 기본적으로 AWS console에 로그인한 계정(root)은 모든 권한을 가지고 있음
* 외부 서비스에서 접속하거나 다른 사람이 해당 계정을 사용할 경우, root 계정만 사용하는 것은 위험할 수 있음
* 이런 경우, IAM 사용자를 만들어 일부 권한만 부여
* 생성할 경우 AWS에 **접근 가능한 key를 받게 됨**

<br>

## IAM 정책(Policies)
* AWS 리소스에서 **수행할 수 있는 작업을 정의하는 규칙**
* AWS에서 사전에 정의된 정책들도 있고, 직접 정책을 작성할 수도 있음
* 사용자에게 직접 부여할 수도 있고, 정책들을 지정해놓은 그룹에 사용자를 추가할 수도 있음

<br>

## IAM 역할(Roles)
* 정책이 부여된 자격(Identity) 그 자체
* 접근 key를 갖지 않고, 해당 역할을 필요로 하는 사용자 뿐만 아니라 AWS 서비스에도 부여될 수 있음

<br>

## Reference
<https://serverless-stack.com/chapters/ko/what-is-iam.html>