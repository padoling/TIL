# JDBC
## JDBC란?
* **Java Database Connectivity**
* DB에 접근할 수 있도록 Java에서 제공하는 API
* 데이터베이스 접속, SQL 문장의 실행, 데이터의 핸들링 등을 위한 기능을 제공
* 데이터베이스 또는 기타 써드파티에서는 JDBC 인터페이스를 구현한 **드라이버(driver)** 를 제공
![jdbc](/img/jdbc.png)

<br>

## 영속성(Persistence)
* 데이터를 생성한 프로그램의 실행이 종료되더라도 사라지지 않는 데이터의 특성
* 데이터베이스, 파일 시스템 등에 저장되어 프로그램 종료 시에도 사라지지 않는 데이터를 **영속성을 갖는다**고 말함
### Persistence Layer
* 프로그램 아키텍처에서, 데이터에 영속성을 부여해주는 계층
* JDBC를 이용하여 직접 구현할 수 있지만, 주로 Persistence framework를 이용하여 개발함

<br>

## Persistence Framework
* 데이터의 저장, 조회, 변경, 삭제를 다루는 클래스 및 설정 파일들의 집합
* JDBC 프로그래밍의 복잡함이나 번거로움 없이 간단한 작업만으로 데이터베이스와 연동되는 시스템을 빠르고 안정적으로 개발할 수 있음
    ### SQL mapper
    * SQL 문장으로 직접 데이터베이스 데이터를 다루는 형태의 Persistence Framework
    * Java의 필드를 SQL에 매핑시키는 것이 목적
    * **Mybatis**, **JdbcTempletes** 등이 포함됨
    ### ORM(Object-Relational mapper)
    * 데이터베이스 객체를 자바 객체로 매핑함으로써 SQL을 자동으로 생성해주는 형태의 Persistence Framework
    * 자바 객체를 통해 간접적으로 데이터베이스 데이터를 다룸
    * **JPA**, **Hibernate** 등이 포함됨

<br>

## Reference
* <https://gmlwjd9405.github.io/2018/12/25/difference-jdbc-jpa-mybatis.html>
* <https://hzoou.tistory.com/64>
* <https://ko.wikipedia.org/wiki/퍼시스턴스_프레임워크>