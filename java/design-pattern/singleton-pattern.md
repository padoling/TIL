# Singleton Pattern

## Singleton Pattern이란?
* 인스턴스를 하나만 만드는 디자인 패턴
* 생성자를 여러 번 호출해도 실제로 생성되는 인스턴스는 단 하나임

<br>

## Java 예시
```java
public class Singleton {
  private static Singleton singleton = null;

  private Singleton { }

  public static Singleton getInstance() {
    if(singleton == null) {
      singleton = new Singleton();
    }

    return singleton;
  }
}
```
* 외부에서 이 객체를 생성하지 못하도록 생성자를 `private`으로 선언함
* `getInstance()`로 인스턴스를 가져올 때 생성된 객체가 존재한다면 그 객체를 반환하고, 존재하지 않는다면 새로 생성함
* 즉, 객체가 존재하지 않을 경우 딱 한번 객체를 생성하고 그 후로는 미리 생성해 둔 인스턴스를 사용함

<br>

## Reference
* <https://velog.io/@kyle/%EC%9E%90%EB%B0%94-%EC%8B%B1%EA%B8%80%ED%86%A4-%ED%8C%A8%ED%84%B4-Singleton-Pattern>
* <https://victorydntmd.tistory.com/293>