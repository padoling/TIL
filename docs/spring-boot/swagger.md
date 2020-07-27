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