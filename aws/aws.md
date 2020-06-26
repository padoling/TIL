# AWS Service

## AWS란?
* 아마존 웹 서비스(Amazon Web Service)의 줄임말로, 클라우드 컴퓨팅으로 다양한 서비스를 제공함
    * **클라우드 컴퓨팅** : 어딘가에 있는 클라우드 서버에 **인터넷**을 통해 데이터를 전송하여 그 클라우드 서버에서 일을 처리하도록 하는 시스템

<br>

## AWS 클라우드의 장점
* **Scalability** : 필요에 따라 확장, 축소 가능
* **Agile** : 새로운 리소스를 사용하는 것이 쉬움, 전 세계에 aws 서버가 있으므로 다양한 유저에 빠르게 대응할 수 있음
* **Elasticity** : 리소스를 새로 만들거나 중단하는 것이 매우 쉬움(Elastic Load Balancing 등을 사용하여 쉬운 조절 가능)
* **Reliability** : 안정성. 여러 위치에 서버가 있기 때문에 더 안정적인 운영 가능. Region과 가용 영역이 존재함

<br>

## 지역과 가용구역
### 지역(Region)
* aws 리소스들이 위치해 있는 지역 단위
* 네트워크는 어쩔 수 없이 거리의 영향을 받으므로 거리와 경유지의 수를 최소화하는 것이 중요함
* 리소스를 생성할 때 개발하는 곳의 위치, 주요 접속자의 위치를 고려하여 지역을 결정
    * <cloudping.info> : 각 아마존 인프라의 위치에 따른 latency를 측정하여 보여줌
### 가용구역(avaliability zone, az)
* 백업 등의 역할을 위해 지역 내에 만들어 둔 여러 개의 서버 건물...?이라고 볼 수 있을 듯
* 가용구역 간에는 전용선으로 연결되어 있기 때문에 네트워크가 매우 빠르게 연결됨(지역과 지역 사이는 그냥 인터넷으로 연결되어 있음)

<br>

## AWS 관리 인터페이스
### AWS Management Console
* url로 접속 가능한 콘솔
* 웹과 앱 모두 사용 가능
### CLI
* shell에서 사용, 스크립트 생성 가능
### SDK(Software Development Kit)
* 기존 언어에서 aws sdk를 코드에 통합하여 사용할 수 있음

<br>

## Reference
* [생활코딩 AWS 강의](https://www.youtube.com/watch?v=7ThkvfCKKQs&list=PLuHgQVnccGMC5AYnBg8ffg5utOLwEj4fZ)

* [AWS training 강의 - AWS Cloud Practitioner Essentials](https://www.aws.training/Details/Curriculum?id=32442)