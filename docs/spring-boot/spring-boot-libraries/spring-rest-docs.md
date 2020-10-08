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