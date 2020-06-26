# 빌더 패턴(Builder Pattern)

## 빌터 패턴이란?
빌더 패턴은 객체를 생성할 때 사용할 수 있는 디자인 패턴이다. 빌더 패턴을 사용하면 객체 생성 시 더 객체지향적이고 가독성 좋은 코드를 쓸 수 있다.

다음과 같은 필드를 가지는 자바 클래스가 있다고 하자.
```java
public class Cat {
    private final String name;
    private final String sex;
    private final int age;
    private final double weight;
}
```
일반적으로 위의 객체를 생성할 때 다음과 같이 할 것이다.
```java
// 생성자의 인자로 값 넣기
Cat cat1 = new Cat("mung", "female", 4, 5);

// Setter 메소드 이용하기
Cat cat2 = new Cat();
cat2.setName("meow");
cat2.setSex("male");
cat2.setAge(2);
cat2.setWeight(4.5);
```
* 첫 번째 방법(**생성자 사용**)은 한 줄에 간단하게 쓸 수 있지만, 각 값들이 어떤 속성에 해당하는 것인지 알기 어렵다. 4가 의미하는 것이 고양이의 나이인지 몸무게인지 헷갈릴 수 있는 것이다. 지금은 인자의 수가 적어서 별로 헷갈리지는 않지만, 만약 인자가 10개 정도 된다고 생각하면 어떤 값이 어떤 속성을 의미하는지 한 눈에 들어오지 않는다.
* 두 번째 방법(**setter 사용**)은 값이 어떤 속성에 들어가는지는 바로 매치된다. set 뒤에 대문자로 시작하는 이름이 필드의 이름과 같기 때문이다. 그러나 처음 객체를 생성한 것으로 생성이 끝나지 않고 setter 메소드를 계속해서 써야 생성이 끝나기 때문에, `객체 일관성(consistency)`이 일시적으로 깨질 수 있다.

이러한 단점을 보완하기 위해 만든 것이 빌더 패턴이다. 빌더 패턴을 이용하여 객체를 생성할 시의 코드는 다음과 같다.
```java
Cat cat = new Cat
            .Builder()
            .name("lion")
            .sex("female")
            .weight(6.5)
            .age(7)
            .build();
```
`Builder()`라는 클래스가 Cat 객체의 생성을 도와준다. 그리고 `.`으로 체인하여 값을 설정할 수 있는 편리함을 갖추고 있다.

이 때 setter 메소드를 쓸 때처럼 모든 속성들을 직접 확인하고 순서에 상관 없이 값을 넣을 수 있으면서 객체를 생성할 때 같이 한번에 이루어지기 때문에 객체 일관성이 깨지지 않는다. 객체지향적이면서 가독성 좋은 코드가 된 것이다.

마지막에 있는 `build()` 메소드가 객체를 생성해서 반환한다.

<br>

## Lombok의 @Builder 어노테이션
빌더를 직접 구현하면 좋겠지만 귀찮으니까.... **Lombok** 라이브러리에 있는 `@Builder` 어노테이션을 이용하면 좋다.

다음과 같이 클래스 위에 붙이면 자동으로 빌더 패턴 클래스를 생성한다.
```java
import lombok.Builder;

@Builder
public class Cat {
    private final String name;
    private final String sex;
    private final int age;
    private final double weight;
}
```
클래스 말고 **생성자 위에** 붙일 수도 있는데, 이렇게 하면 생성자에 포함된 필드만 빌더에 포함된다.
```java
@Builder
public Cat(String name, int age) {
    this.name = name;
    this.age = age;
}
```