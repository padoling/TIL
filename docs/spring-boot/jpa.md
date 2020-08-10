# JPA

## JPA란?
* Java Persistence API의 약자로, 자바의 ORM 기술에 대한 표준 명세
* 자바 객체를 DB 테이블로 매핑하는 형태이기 때문에 사용자는 SQL을 직접 쓰지 않아도 됨
* 내부적으로 SQL과 JDBC와 같은 기술을 사용하도록 되어 있음

![jpa](https://media.vlpt.us/images/adam2/post/cde32cd8-b9c0-49c4-bf99-b58c0b0c2e18/Untitled%203.png)

* 기본적으로 인터페이스이기 때문에 실제로는 JPA의 구현체나 모듈을 사용하게 됨(Hibernate, Spring Data JPA 등)

<br>

## Spring Data JPA란?
* JPA를 사용하기 편하게 만들어놓은 모듈
* JPA를 한 단계 더 추상화시킨 `Repository`를 사용하여 `EntityManager`를 따로 사용하지 않아도 JPA를 이용할 수 있음

<br>

## Entity
* JPA에서 DB 테이블과 매핑할 클래스에 반드시 `@Entity` 어노테이션을 붙여줘야 함
* `NoArgsConstructor`를 필수로 가져야 함
* 각 field는 DB 테이블의 column과 매칭됨
* Ex)
```java
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import javax.persistence.*;
import java.time.LocalDateTime;
@Getter
@NoArgsConstructor
@Entity
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String email;

    private String password;

    private String userName;

    @Enumerated(EnumType.STRING)
    private UserType userType;

    private LocalDateTime createDate;

    @Builder
    public User(String email, String password, String userName, UserType userType, LocalDateTime createDate) {
        this.email = email;
        this.password = password;
        this.userName = userName;
        this.userType = userType;
        this.createDate = createDate;
    }
}
```

### Column들에 붙이는 어노테이션 종류
* #### `@id`
  primary key를 의미함
* #### `@GeneratedValue`
  primary key의 자동 생성 전략을 명시할 수 있음
* #### `@Enumerated`
  `enum` 타입의 field를 사용할 때 이 어노테이션을 붙여줘야 `enum` 타입으로 persist됨

<br>

## Reference
* <https://suhwan.dev/2019/02/24/jpa-vs-hibernate-vs-spring-data-jpa/>
* <https://velog.io/@adam2/JPA%EB%8A%94-%EB%8F%84%EB%8D%B0%EC%B2%B4-%EB%AD%98%EA%B9%8C-orm-%EC%98%81%EC%86%8D%EC%84%B1-hibernate-spring-data-jpa>