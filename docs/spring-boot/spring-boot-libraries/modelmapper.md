# ModelMapper

## ModelMapper란?
* Object to Object mapper
* 두 개의 비슷한 model 간 데이터를 mapping시키고 싶을 때 사용하면 좋은 라이브러리
* Entity와 dto를 mapping하는 데 사용하면 좋은 듯

<br>

## 설치

```groovy
implementation 'org.modelmapper:modelmapper:2.3.0'
```

<br>

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

<br>

## Reference
* <http://modelmapper.org/getting-started/>
* <https://www.baeldung.com/entity-to-and-from-dto-for-a-java-spring-application>