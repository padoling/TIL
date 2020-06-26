# EC2

## EC2란?
* Elastic Compute Cloud의 약자. 탄력적인 클라우드 컴퓨팅 서버 리소스. 애플리케이션의 요구에 따라 서버(인스턴스)의 양을 자동으로 늘리거나 줄일 수 있음
* 독립된 컴퓨터 한 대를 통째로 임대해 주는 성격의 서비스
* 원격으로 해당 컴퓨터를 제어할 수 있음
* **인스턴스** : EC2 서비스에서 컴퓨터 한 대를 의미한다고 볼 수 있음
* terminate를 선택하면 해당 컴퓨터가 삭제됨. 과금 발생 X
### 인스턴스 타입 선택
* **AMI**(Amazon Machine Image) : 아마존 가상 이미지. 여기선 운영체제를 선택할 수 있음. linux, ubuntu, windows 등이 있음. 
* vCPUs : virtual CPUs. 가상의 CPU 개수를 나타냄. 이 정도 CPU 개수의 성능을 지닌 컴퓨터다... 뭐 이런 의미
* Network Performance : 네트워크의 성능. 얼마나 많은 데이터를 한 번에 전송할 수 있는가
* **t2 micro** : 유일한 프리티어 타입.
* m으로 시작하는 컴퓨터는 주로 메모리가 좋은 타입, c로 시작하는 컴퓨터는 주로 cpu가 좋은 타입, gpu가 강한 타입도 있음. 이름을 보고 대충 속성을 추측할 수 있을 듯.
### 가격정책
* 프리티어 제한은 검색하면 aws 문서에 나옴(t2.micro 750시간, storage 30GB, 총 15GB 데이터 전송 등)
* Region마다, 설치된 운영체제마다 가격 정책이 다르니 잘 확인해야 함
* **온디맨드 인스턴스**(On demanded instance) : 필요할 때마다 켜고 끌 수 있는 인스턴스
* **예약 인스턴스** : 켜고 끌 때 할인권을 제공하는 인스턴스. 선결제로 특정 기간 동안의 사용권을 미리 결제하면 할인 혜택을 받을 수 있음
* **스팟 인스턴스** : 놀고 있는 컴퓨터(미사용 인스턴스)의 양에 따라 가격이 달라짐. 마치 주가처럼,,,

<br>

## EC2 인스턴스 설정
### Configure Instace Details
* Number of instances : 인스턴스의 개수. 한도를 설정할 수 있는 듯
* Request spot instances : 체크하면 스팟 인스턴스로 설정할 수 있음
* Network, Subnet, Public IP 등 : 네트워크 관련 설정
* Shutdown behavior : 운영체제에서 컴퓨터를 셧다운했을 때 어떻게 할지 결정
* Enable termination protection : 실수로 컴퓨터를 삭제하는 것을 방지하기 위함
* Monitoring : CloudWatch를 통해 더 디테일한 모니터링을 할 것인지 여부
### Add Storage
* Size(GB) : 저장장치의 용량
* Volume Type : 저장장치의 형식. SSD, Magnetic 등 설정 가능. Provisioned IOPS는 저장장치의 성능을 지정할 수 있음
* Delete on Termination : 저장장치는 인스턴스와 분리되어 있기 때문에 인스턴스를 terminate했을 때 저장장치까지 삭제할지 말지 여부를 결정할 수 있음
### Tag
* 특정 인스턴스에 Key와 Value로 된 태그를 지정할 수 있음. 인스턴스에 대한 정보를 지정하는 데에 주로 쓰이는 듯
### Security Group
* 인스턴스에 접근할 수 있는 권한을 설정하는 기능. 일종의 방화벽 같은 역할
* Type : 인스턴스에 접근하는 방식. 
    * SSH는 secure shell로, 리눅스 계열 서버에 원격으로 접속하는 방식
    * HTTP는 웹 서버로 사용하고 싶을 때 사용하면 됨.
    * RDP는 윈도우를 원격제어하는 방식
* Source : 접속 가능한 IP를 제한할 수 있음
### key pair
* 아주 복잡한 비밀번호로 인스턴스를 보호하기 위한 기능
* 인스턴스에 접속할 때 이 비밀번호를 써야 함
* 파일 형태로 저장하여 사용하면 됨. 아주 안전한 곳에 잘 저장해두어야 함,,,

<br>

## EC2 AMI
* Amazon Machine Image의 약자로, 가상머신의 상태를 이미지의 형태로 얼려서(?) 나중에 똑같이 복원할 수 있는 기능
* EC2 인스턴스에서 Image > Create Image를 선택하면 이미지를 만들 수 있음
* 어떤 형식의 저장장치에 이미지를 저장할지 결정할 수 있음
* 이미지를 생성하는 동안에는 인스턴스가 일시적으로 정지됨
* 생성한 이미지를 기반으로 얼마든지 새로운 인스턴스를 생성할 수 있음
* 복원과 같은 기능을 위해 활용할 수 있음!
* Marketplace에서 기존에 만들어져 있는 AMI를 받아서 인스턴스를 만들 수 있음

<br>

## 맥북에서 EC2 접속하기

1. pem키 복사하기
```
cp [pem키의 위치] ~/.ssh/
```
위 명령어를 통해 ec2의 pem키를 .ssh 폴더 안에 복사한다. 이렇게 하면 ssh 실행 시 pem키 파일을 자동으로 읽어 접속한다.

2. 권한 설정
```
chmod 600 ~/.ssh/[pem키 이름]
```

3. config 파일에 Host 등록
```
vi ~/.ssh/config


# config 파일 아래와 같이 수정
Host [원하는 서비스 명]
    HostName [ec2의 탄력적 IP 주소]
    User ec2-user
    IdentityFile ~/.ssh/[pem키 이름]
```

4. config 파일 실행 권한 설정
```
chmod 700 ~/.ssh/config
```

5. ssh 접속
```
ssh [config에서 등록한 서비스 명]
```
