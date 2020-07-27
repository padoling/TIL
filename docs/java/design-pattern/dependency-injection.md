# Dependency Injection(DI)
## Dependency(의존성)
A 객체가 B 객체를 참조하고 있는 경우, A 객체는 B 객체에 **의존성을 갖는다**고 한다.
```java
public class Butler {
  private Cat cat;

  public Butler() {
    this.cat = new Cat();
  }
}

public class Cat {
  public Cat() {
    // ...
  }
}
```
* `Butler` 객체는 생성자에서 `new Cat()`을 통해 `Cat` 객체를 참조하고 있으므로 `Cat` 객체에 의존한다.
* `Butler` 객체가 `Cat` 객체의 생성을 제어하고 있기 때문에 두 객체는 **긴밀한 결합(tight coupling)** 을 갖는다. 즉, `Cat` 객체를 변경하면 `Butler` 객체도 변경된다.

<br>

## Injection(주입)
어떤 객체를 참조하고자 할 때, **객체 외부에서 객체를 생성하여** 넣어주는 것을 주입이라고 한다.
```java
public class Butler {
  private Cat cat;

  public Butler(Cat cat) {
    this.cat = cat;
  }
}

Cat cat = new Cat();
Butler butler = new Butler(cat);
```

<br>

## Dependency Injection(의존성 주입)
객체가 아니라 Framework에 의해 의존성이 주입되는 디자인 패턴
### IoC(Inversion of Control)
* 제어의 역전. 객체의 생성을 포함한 라이프사이클 관리를 프레임워크가 대신 하는 것을 의미
### IoC 컨테이너
* 스프링에는 **IoC 컨테이너**가 객체를 관리하며 의존 주입을 함
* 개발자가 xml이나 어노테이션을 통해 설정을 하기만 하면 객체의 의존 주입에 대한 제어는 컨테이너가 하게 됨
* 설정에 명시된대로 먼저 Bean 객체를 생성하고 의존성 주입을 실행
> Bean이란 스프링 컨테이너에 의해 만들어진 자바 객체를 의미함. 스프링 부트의 경우 `@Component`, `@Service`, `@Controller`, `@Repository`, `@Bean`, `@Configuration` 등의 어노테이션이 붙은 객체를 컨테이너에 Bean으로 등록하고 `@Autowired`를 통해 주입받아 사용한다.

<br>

## 의존성을 주입하는 방법
### 1. 필드 주입(Field Injection)
필드에 `@Autowired` 어노테이션을 붙여서 의존성을 주입하는 방법
```java
@Component
public class Butler {
  
  @Autowired
  private Cat cat;
}
```

### 2. 세터 주입(Setter Injection)
`Setter`를 통해 의존성을 주입하는 방법
```java
@Component
public class Butler {
  
  private Cat cat;

  @Autowired
  public void setCat(Cat cat) {
    this.cat = cat;
  }
}
```

### 3. 생성자 주입(Constructor Injection)
생성자를 통해 의존성을 주입받는 방법
```java
@Component
public class Butler {
  
  private final Cat cat;

  public Butler(Cat cat) {
    this.cat = cat;
  }
}
```
* 필드에 `final`을 붙일 수 있음
* 단일 생성자의 경우 추가적인 어노테이션을 붙일 필요가 없음

<br>

## 생성자 주입을 권장하는 이유
### 순환 참조 방지
* A 객체가 B 객체를 참조하고, 동시에 B 객체는 A 객체를 참조하는 상황을 **순환 참조**라고 함
* 필드 주입과 세터 주입은 주입 받으려는 빈을 먼저 생성한 후에 `@Autowired`가 붙은 주입하려는 빈을 생성하는 반면, **생성자 주입은 빈 생성 시점에 생성자의 인자에 사용되는 빈을 먼저 생성하고 나서 주입 받는 빈을 생성함**
* 따라서 생성자 주입에서는 순환 참조가 발생했을 때 주입될 빈이 존재하지 않아 에러가 발생하지만, 필드 주입과 세터 주입은 순환 참조가 일어나고 있다는 것을 인지하지 못함

### 불변성
* 생성자 주입은 필드를 `final`로 선언할 수 있기 때문에 객체가 런타임에 변경될 가능성이 사라짐

<br>

## Reference
* <https://gmlwjd9405.github.io/2018/11/09/dependency-injection.html>
* <https://medium.com/@jang.wangsu/di-dependency-injection-%EC%9D%B4%EB%9E%80-1b12fdefec4f>
* <https://cbw1030.tistory.com/54>
* <https://madplay.github.io/post/why-constructor-injection-is-better-than-field-injection>