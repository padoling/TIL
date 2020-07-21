# cors
## cors란?
* **Cross-Origin Resource Sharing**의 약자로, 서로 다른 출처(origin)에서 리소스를 공유하기 위한 정책

<br>

## 작동 방식
* 클라이언트가 서버에 요청을 보낼 때 헤더의 `Origin`이라는 필드에 자신의 origin을 담아서 보냄
* 서버는 접근을 허용할 origin을 미리 정해두고 요청이 들어오면 어떤 origin을 허용하는지 응답 헤더의 `Access-Control-Allow-Origin` 값에 넣어서 보내줌
* 기본적으로 origin의 비교는 브라우저에서 이루어지기 때문에, cors에 위반되는 요청을 보냈을 때 서버는 정상적으로 응답을 하지만 브라우저 측에서 받은 응답을 파기해버림

<br>

## Request 방식
### Preflight Request
* 본 요청을 보내기에 앞서, `OPTIONS` 메소드를 사용하여 예비 요청을 주고받으며 브라우저 스스로가 해당 요청이 안전한 것인지 확인하는 방식
1. 브라우저가 `OPTIONS`를 이용해 예비 요청을 보낸다. 이 예비 요청에는 자신의 `Origin`에 대한 정보와 이후 보낼 본 요청에 대한 정보들이 담겨 있다.
2. 서버는 예비 요청에 대한 응답으로  `Access-Control-Allow-Origin`이라는 헤더값을 보낸다. 이 헤더는 서버가 허용하는 출처의 목록을 담고 있다. 이 응답은 무조건 2XX status로 전달되어야 한다.
> 만일 여기서 브라우저의 출처가 서버가 허용하는 출처 목록에 없다면, 200 status가 왔어도 브라우저는 cors 에러를 내며 응답을 파기한다.
3. 위의 예비 요청과 응답이 정상적으로 끝나면 브라우저는 비로소 본 요청을 보내고, 서버 또한 본 응답을 보낸다.

### Simple Request
* 예비 요청과 응답이 없는 단순한 요청 방식
* 브라우저는 바로 본 요청을 보내고, 서버는 그 본 요청에 대한 응답으로 헤더에 `Access-Control-Allow-Origin`과 같은 값을 보내줌
* 그러나 다음 조건을 만족하는 경우에만 예비 요청을 생략하고 바로 simple request를 보낼 수 있음

  1. 요청 메소드는 `GET`, `HEAD`, `POST` 중 하나여야 함
  2. 헤더에는 `Accept`, `Accept-Language`, `Content-Language`, `Content-Type`, `DPR`, `DownLink`, `Save-Data`, `Viewport-Width`, `Width`만 사용할 수 있음
  3. `Content-Type`에는 `application/x-www-form-urlencoded`, `multipart/form-data`, `text/plain`만 사용할 수 있음

### Credentialed Request
* 보안을 더 강화하고 싶을 때 인증된 요청을 사용하는 방식
* 브라우저에서 `credentials` 옵션을 이용해 헤더에 인증과 관련된 정보를 담을 수 있음
* 브라우저에서 인증 정보를 넣어서 요청을 보낼 경우, cors 정책 위반 여부를 검사하기 위해 다음 두 가지를 더 검사함

  1. `Access-Control-Allow-Origin`에 `*`을 사용할 수 없음
  2. 응답 헤더에 반드시 `Allow-Control-Allow-Credentials: true`가 존재해야 함

<br>

## Spring Boot에서 cors 설정하기
### `WebMvcConfigurer` 이용한 설정
* `WebMvcConfigurer`를 구현한 클래스에서 `addCorsMappings` 메소드를 구현하면 됨
* `CorsRegistry`를 파라미터로 받아서 다양한 값들을 설정해줄 수 있음
```java
@Configuration
public class AppConfig implements WebMvcConfigurer {

    @Value("#{'${spring.api.cors-allow-url}'.split(',')}")
    private String[] corsAllowUrls;

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")
                .allowedOrigins(corsAllowUrls)
                .allowCredentials(true)
                .allowedMethods("*");
    }

}
```
* `addMapping` : cors를 적용할 URL 패턴 정의
* `allwedOrigins` : 허용할 출처(origin) 목록 설정
* `allowCredentials` : Credentialed Request 허용 여부
* `allwedMethods` : 허용할 메소드
* `maxAge` : preflight request를 캐싱할 시간

### Annotation 이용한 설정
* Controller 클래스나 메소드 단에서 annotation 적용
```java
@RequestMapping("/user")
@CrossOrigin(origins="*", allowedHeaders="*")
public class UserController {
    //...
}
```

<br>

## Reference
* <https://evan-moon.github.io/2020/05/21/about-cors/>
* <https://www.popit.kr/cors-preflight-%EC%9D%B8%EC%A6%9D-%EC%B2%98%EB%A6%AC-%EA%B4%80%EB%A0%A8-%EC%82%BD%EC%A7%88/>
* <https://dev-pengun.tistory.com/entry/Spring-Boot-CORS-%EC%84%A4%EC%A0%95%ED%95%98%EA%B8%B0>