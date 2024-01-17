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

### `@SpringBootConfiguration`
* `@Configuration`이 적용된 클래스가 하나 이상의 `@Bean` 메소드를 선언하면 런타임 시 요청에 따라 스프링 컨테이너에 의해 처리될 수 있음을 나타냄
* 즉, 사용자가 추가로 빈이나 설정 클래스를 등록할 수 있게 해줌

### `@EnableAutoConfiguration`
```java
// ...
@AutoConfigurationPackage
@Import(AutoConfigurationImportSelector.class)
public @interface EnableAutoConfiguration
```
* Application Context의 설정을 자동으로 수행하는 어노테이션
* 즉, Spring Application에서 자동으로 jar dependencies를 기반으로 의존성을 설정하는 것
* Ex) 만약 `spring-webmvc`가 classpath에 존재한다면, `DispatcherServlet`을 셋팅하는 등 웹 애플리케이션과 관련된 설정들을 자동으로 해줌
* `META-INF/spring.factories`에 정의되어 있는 configuration 대상 클래스들을 빈으로 등록함. 이 클래스들은 `@Configuration` 어노테이션이 없어도 자동으로 빈으로 등록됨
* 모든 클래스가 항상 빈으로 등록된다면 엄청난 리소스 낭비이므로 `AutoConfigurationImportSelector`가 `@Conditional` 어노테이션 등을 활용해서 필터링 작업을 수행함

### `@ComponentScan`
* Spring Boot가 현재 패키지 하위에서 다른 components, configurations, service와 같은 컴포넌트들을 찾도록 함
* 아래와 같은 태그 사용 가능
    - `includeFilters` : 스캔 대상에 포함할 클래스
    - `excludeFilters` : 스캔 대상에서 제외할 클래스
    - `basePackages` : 여기에 직접 경로를 설정하지 않았다면 이 어노테이션이 명시된 클래스(Application.java)가 있는 패키지가 기본 경로로 설정되며 해당 패키지와 하위 패키지들을 스캔하여 빈으로 등록함.

<br>

## 애플리케이션 실행

### gradle
* 다음 명령어로 실행
```shell
./gradlew bootRun
```

### maven
* 다음 명령어로 실행
```shell
./mvnw spring-boot:run
```

<br>

## Reference
* <https://spring.io/projects/spring-boot#overview>