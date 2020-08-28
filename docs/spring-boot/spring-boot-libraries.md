# Spring Boot 라이브러리
---
# Spring Boot Ehcache

## Cache란?
* 데이터나 값을 미리 복사해 놓는 임시 장소
* 캐시의 접근 시간에 비해 원래 데이터를 접근하는 시간이 오래 걸리는 경우, 혹은 값을 다시 계산하는 시간을 절약하고 싶은 경우 사용 ([위키백과]((https://ko.wikipedia.org/wiki/%EC%BA%90%EC%8B%9C)))
* 보통 동일한 결과를 반복해서 돌려주게 되는 작업에서 사용함

### Cache Expiration
* 기본적으로 원본 데이터가 변화했는지 여부를 복사된 데이터가 알지 못하므로 복사본이 항상 최신 상태라고 장담하기 어려움
* 따라서 복사된 데이터를 주기적으로 expire 시켜주고 새 원본 상태로 업데이트 해주어야 함
* **ttl(time-to-live)** : 캐시가 생성된 후 정해진 시간이 지나면 만료되도록 함
* **tti(time-to-idle)** : 캐시에 마지막으로 접근한 후 정해진 시간이 지나면 만료되도록 함

<br>

## Spring Boot + Ehcache
* 캐시를 키-값 형태로 저장해서 데이터를 불러올 때 키를 이용해 캐시에 저장된 데이터를 불러올 수 있음

### dependency 추가
```groovy
dependencies {
    //...
    implementation 'org.springframework.boot:spring-boot-starter-web'
    implementation 'org.springframework.boot:spring-boot-starter-cache'
    implementation 'javax.cache:cache-api:1.1.1'
    implementation 'org.ehcache:ehcache:3.8.1'
}
```

### Cache Configuration

#### 1. Enable Caching
```java
@SpringBootApplication
@EnableCaching    // caching!
public class Application {
  public static void main(String[] args) {
    SpringApplication.run(Application.class, args);
  }
}
```
* `@EnableCaching` 어노테이션을 붙여 프로젝트에서 캐시 관련 기능을 사용하도록 선언할 수 있음
* `@Configuration`이 붙은 Config 클래스에 붙여도 됨

#### 2. ehcache.xml
ehcache와 관련된 각종 설정을 담는 `ehcache.xml` 파일 생성
```xml
<?xml version="1.0" encoding="UTF-8"?>
<ehcache xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:noNamespaceSchemaLocation="http://ehcache.org/ehcache.xsd"
    updateCheck="false">
    <diskStore path="java.io.tmpdir" />

    <cache alias="squareCache">
        <key-type>java.lang.Long</key-type>
        <value-type>java.math.BigDecimal</value-type>
        <expiry>
            <ttl unit="seconds">30</ttl>
        </expiry>

        <listeners>
            <listener>
                <class>com.baeldung.cachetest.config.CacheEventLogger</class>
                <event-firing-mode>ASYNCHRONOUS</event-firing-mode>
                <event-ordering-mode>UNORDERED</event-ordering-mode>
                <events-to-fire-on>CREATED</events-to-fire-on>
                <events-to-fire-on>EXPIRED</events-to-fire-on>
            </listener>
        </listeners>
 
        <resources>
            <heap unit="entries">2</heap>
            <offheap unit="MB">10</offheap>
        </resources>
    </cache>

</ehcache>
```
* `<cache alias="user">` : 캐시에 붙여주는 별칭
* `<key-type>` : 캐시의 key가 될 타입 지정. 디폴트는 `java.lang.Object`

> 캐시에 들어가게 될 값이 custom Object인 경우, 해당 Object는 `Serializable`을 implement해주어야 함!

* `<value-type>` : 캐시의 value에 들어갈 타입 지정. 디폴트는 역시 `java.lang.Object`
* `<expiry>` : 언제 expire 시킬지 지정
* `<listeners>` : 캐시 관련 이벤트 listener

`application.properties` 파일에 설정 파일 경로 지정
```properties
spring.cache.jcache.config=classpath:ehcache.xml
```

### 캐시 기능 추가

#### `@Cacheable`
```java
@Cacheable(value = "squareCache")
public BigDecimal square(Long number) {
  // ...
}
```
* xml에서 지정한 `squareCache`라는 이름의 캐시를 사용하겠다는 의미
* 따로 지정하지 않으면 해당 메소드의 파라미터를 key로 사용하여 return 값을 캐싱함

#### `@CacheEvict`
```java
@CacheEvict(value = "squareCache")
public void refresh(Long number) {
  // ...
}
```
* 주어진 key에 해당하는 캐시가 존재할 경우, 그 캐시 내용을 삭제함

### EventListener
```java
@Slf4j
public class CacheEventLogger implements CacheEventListener<Object, Object> {
    @Override
    public void onEvent(CacheEvent<?, ?> event) {
        if(log.isDebugEnabled()) {
            log.debug("Cache event {} : Key = {}, OldValue = {}, NewValue = {}", event.getType(), event.getKey(), event.getOldValue(), event.getNewValue());
        }
    }
}
```
* xml에 설정해둔 바에 따라 캐시가 CREATED 되거나 EXPIRED될 때 해당 EventListener가 작동함
* 위 코드는 캐시의 값을 로그로 찍는 코드

<br>

## Reference
* <https://jojoldu.tistory.com/57>
* <https://www.ehcache.org/documentation/>
* <https://www.baeldung.com/spring-boot-ehcache>

<br>

---
# Spring Rest Docs

## Spring Rest Docs란?
* RESTful한 서비스의 문서(documentation)를 만들어 주는 라이브러리
* 직접 작성한 문서와 스프링 테스트로 자동 생성된 스니펫(snippets)을 조합해 줌

<br>

## gradle dependency 설정
```groovy
// asciidoctor 플러그인 설치
plugins {
  id 'org.asciidoctor.convert' version '1.5.9.2'
}

// task 설정
asciidoctor {
  dependsOn test
}

task copyDocument(type: Copy) {
  // asciidoctor가 실행되면 asciidoc 폴더 하위의 파일을 static/docs 하위로 복사
  dependsOn asciidoctor
  from file("build/asciidoc/html5")
  into file("src/main/resources/static/docs")
}

build {
  dependsOn copyDocument
}

dependencies {
  // restdocs 라이브러리 설치
  testImplementation 'org.springframework.restdocs:spring-restdocs-mockmvc'
}
```

<br>

## JUnit 5 Configuration
* test 메소드를 `RestDocumentationExtension` 클래스로 extend 해줘야 함
* `document()` 내부에 입력한 String을 토대로, 테스트 성공 시 `build/generated-snippets/something` 하위에 스니펫이 생성됨
```java
@ExtendWith({RestDocumentationExtension.class, SpringExtension.class})
@SpringBootTest
public class ApiDocumentationJUnit5IntegrationTest { 
  @Test
  public void test_something() {
    mockMvc.perform(get("/api/data"))
      .andExpect(status().isOk())
      .andDo(document("something"))
  }
}
```
* 기본 생성되는 스니펫들
  * `curl-request.adoc`
  * `http-request.adoc`
  * `http-response.adoc`
  * `httpie-request.adoc`
  * `request-body.adoc`
  * `response-body.adoc`

<br>

## documentation 작성
* `/src/docs/asciidoc` 하위에 `*.adoc`으로 문서를 작성해야 asciidoc이 문서를 생성함

### 스니펫 삽입하기
* 아래와 같이 snippet의 위치를 작성하면 문서에 스니펫이 예쁘게 삽입됨
```javadoc
include::{snippets}/signup/curl-request.adoc[]
include::{snippets}/signup/http-request.adoc[]
```
* gradle에서 생성된 문서 파일을 static/docs 하위에 복사하는 task를 설정하였기 때문에 `http://localhost:8080/docs/*.html`로 접근 시 문서 확인 가능

<br>

## Reference
* <https://www.baeldung.com/spring-rest-docs>
* <https://lannstark.tistory.com/9>
* <https://jojoldu.tistory.com/294>

<br>

---
# Swagger

## Spring Boot에서 Swagger 설정하기
### gradle 설치
* 최신 버전은 3.0.0이지만 Spring Boot 2.3에서 ui가 제대로 적용되지 않음
```groovy
implementation 'io.springfox:springfox-swagger2:2.9.2'
implementation 'io.springfox:springfox-swagger-ui:2.9.2'
```

### Configuration
* `@EnableSwagger2`라는 어노테이션을 적용시킨 Configuration 클래스를 만들어 `Docket` Bean을 생성한다.
```java
@Configuration
@EnableSwagger2
public class SpringFoxConfig {                                    
    @Bean
    public Docket api() { 
        return new Docket(DocumentationType.SWAGGER_2)  
          .select()                                  
          .apis(RequestHandlerSelectors.any())              
          .paths(PathSelectors.any())                          
          .build();                                           
    }
}
```

### url로 확인하기
* `http://localhost:8080/v2/api-docs`로 접속하면 JSON 형태의 raw swagger 화면을 확인할 수 있음
* UI가 적용된 형태를 보려면 `http://localhost:8080/swagger-ui.html`로 접속하면 됨

## Reference
* <https://www.baeldung.com/swagger-2-documentation-for-spring-rest-api>

<br>

---
# ModelMapper

## ModelMapper란?
* Object to Object mapper
* 두 개의 비슷한 model 간 데이터를 mapping시키고 싶을 때 사용하면 좋은 라이브러리
* Entity와 dto를 mapping하는 데 사용하면 좋은 듯

## 설치

```groovy
implementation 'org.modelmapper:modelmapper:2.3.0'
```

## 사용 방법

* `ModelMapper`를 `Configuration` 클래스에 Bean으로 등록
```java
@Bean
public ModelMapper modelMapper() {
    return new ModelMapper();
}
```

* mapper를 사용하고자 하는 클래스에서 의존주입 받아 사용
```java
@RequiredArgsConstructor
@Service
public class PostService() {

    private final ModelMapper modelMapper;

    private PostDto convertToDto(Post post) {
        // 변환시킬 object, 변환할 type 순으로 넣어줌
        PostDto postDto = modelMapper.map(post, PostDto.class);
        return postDto;
    }
}
```

## Reference
* <http://modelmapper.org/getting-started/>
* <https://www.baeldung.com/entity-to-and-from-dto-for-a-java-spring-application>