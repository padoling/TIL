# ObjectMapper

## ObjectMapper란?
* Jackson 라이브러리에서 지원하는 json을 객체로, 혹은 객체를 json으로 변환할 수 있는 툴

<br>

## 설치
* `jackson` 의존성을 받아야 함
```groovy
dependencies {
    implementation 'com.fasterxml.jackson.datatype:jackson-datatype-jsr310:2.11.1'
}
```

<br>

## ObjectMapper 설정
* 필요할 때 의존주입해주기 위해서 다음과 같이 Bean으로 등록
```java
@Configuration
public class AppConfig {
    @Bean
    public ObjectMapper objectMapper() {
        ObjectMapper objectMapper = new ObjectMapper();
        // mapper 관련 설정들...
        return objectMapper;
    }
}
```

* 메인 클래스에 선언해도 등록됨
```java
@SpringBootApplication
public class Application {
    public void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

    @Bean
    public ObjectMapper objectMapper() {
        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper;
    }
}
```

<br>

## json <-> object 변환하기
* json의 형태와 object의 형태가 일치해야만 오류 없이 변환됨

### Json to Object
* ObjectMapper의 `readValue()` 메소드 사용
```java
Car car = objectMapper.readValue(json, Car.class);
```

* List 등의 형태로 변환시키는 경우 `TypeReference` 사용
```java
List<Car> carList = objectMapper.readValue(jsonCarArray, new TypeReference<List<Car>>(){});
Map<String, Object> map = objectMapper.readValue(json, new TypeReference<Map<String, Object>>(){});
```

### Object to Json
```java
Car car = new Car("yellow", "renault");
objectMapper.writeValue(new File("target/car.json"), car);
```


## Reference
* <https://www.baeldung.com/jackson-object-mapper-tutorial>