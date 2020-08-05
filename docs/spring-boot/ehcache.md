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
* 따로 지저하지 않으면 해당 메소드의 파라미터를 key로 사용하여 return 값을 캐싱함

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