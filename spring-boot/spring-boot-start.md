# Spring Boot Getting Started
## Spring Boot란?
* 제품 수준의 Spring 기반 애플리케이션을 쉽게 만들 수 있도록 지원하는 도구
* Tomcat, Jetty, Undertow와 같은 **WAS가 내장되어 있어** 따로 설치할 필요가 없음
* `starter` dependencies를 사용하여 **최소한의 설정만 직접 하도록** 함
* Spring과 써드파티 라이브러리들을 설정 가능할 때 **자동으로 설정함**
> Spring Boot가 파일을 직접 수정하거나 추가하는 것은 아님. 애플리케이션이 작동하면 동적으로 bean과 설정들을 연결하고 **application context**에 적용함

<br>

## `@SpringBootApplication`
```java
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class Application {
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}
```
* Spring Boot에서 보통 위의 코드를 프로젝트의 가장 상위에 작성함
* 아래 세 가지를 포함하는 편리한 어노테이션
### `@Configuration`
* 클래스를 application context를 위한 bean을 정의하는 소스로 태그함
* 즉, 해당 클래스를 설정과 관련된 bean을 정의할 때 사용하도록 만듦
### `@EnableAutoConfiguration`
* Spring Boot가 다양한 설정들에 따라 bean을 추가하기 시작하도록 함
* classpath 설정, 다른 bean들, property 설정들을 참고함
* Ex) 만약 `spring-webmvc`가 classpath에 존재한다면, `DispatcherServlet`을 셋팅하는 등 웹 애플리케이션과 관련된 설정들을 자동으로 해줌
### `@ComponentScan`
* Spring Boot가 현재 패키지 하위에서 다른 components, configurations, service와 같은 컴포넌트들을 찾도록 함

<br>

## 애플리케이션 실행
### gradle
* 다음 명령어로 실행
```bash
./gradlew bootRun
```
### maven
* 다음 명령어로 실행
```bash
./mvnw spring-boot:run
```

<br>

## Reference
* <https://spring.io/projects/spring-boot#overview>