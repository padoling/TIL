# Spring Boot Test

## spring-boot-starter-test
* 스프링 부트 테스트에 일반적으로 사용되는 라이브러리
* `spring-boot-test` 모듈을 포함해 JUnit, Assertj, Hamcrest 등의 다양한 라이브러리를 포함하고 있음

### gradle로 설치하기
```groovy
dependencies {
  testImplementation('org.springframework.boot:spring-boot-starter-test') {
        exclude group: 'org.junit.vintage', module: 'junit-vintage-engine'
    }
}
```
* 기본적으로 JUnit 5를 지원하지만, JUnit 4 와 호환되는 `junit-vintage-engine`이 포함되어 있어 JUnit 5만 사용하고 싶다면 해당 모듈을 exclude해줘야 함

<br>

## @WebMvcTest
* 스프링 MVC 동작을 재현해볼 수 있는 `MockMvc`를 자동으로 설정하여 Bean으로 등록해줌
* `@Controller`, `@ControllerAdvice`, `@JsonComponent`, `@Filter` 등의 어노테이션이 붙은 클래스와 `WebMvcConfigurer`, `HandlerInterceptor`, `HandlerMethodArgumentResolver` 등을 스캔함
* Ex)
```java
@WebMvcTest(UserController.class)
public class UserControllerTest {
    
    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private UserService userService;

    @Test
    public void testGetUser() throws Exception {
        //given
        int userId = 1;

        given(this.userService.getUser(userId))
            .willReturn(new User());
        
        //then
        this.mockMvc.perform(get("/user")
            .param("userId", userId)
            .accept(MediaType.APPLICATION_JSON))
            .andExpect(status.isOk());
    }
}
```

<br>

## Reference
* [Spring Boot Features](https://docs.spring.io/spring-boot/docs/current/reference/html/spring-boot-features.html#boot-features-testing)
* [JUnit5 User Guide](https://junit.org/junit5/docs/current/user-guide/#writing-tests-annotations)
* <https://meetup.toast.com/posts/124>