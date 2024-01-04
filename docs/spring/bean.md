# Spring Bean

- 스프링이 생성하는, 스프링 컨테이너에 의해 관리되는 자바 객체(POJO)
- 메소드에 `@Bean` 어노테이션을 붙이면 해당 메소드가 생성한 객체를 스프링이 관리하는 빈으로 등록함
- `@Bean` 어노테이션을 붙인 메소드의 이름은 빈을 구분할 때 사용함

```java
@Target({ElementType.METHOD, ElementType.ANNOTATION_TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface Bean {
```

- 메소드나 어노테이션에만 붙일 수 있다.
- 별도 설정이 없을 경우 스프링은 싱글톤으로 한 개의 빈만 생성함

## Spring Container

- 스프링 빈의 생명주기를 관리
- 스프링 빈들에게 추가적인 기능을 제공하는 역할
- IoC, DI - 객체의 생명주기와 의존주입을 대신 관리해줌
    - 의존 관계는 **런타임** 과정에서 만들어진다.

### Component Scan

`@Component`를 명시하여 빈을 추가하는 방법
    
```java
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@Documented
@Indexed
public @interface Component {
```

- `ElementType.TYPE` 설정으로 Class 혹은 Interface에만 붙일 수 있다.
- `@Controller`, `@Repository`, `@Service`, `@Configuration`은 @Component를 상속받고 있으므로 컴포넌트 스캔 대상이다.
    - `@Controller` : 스프링 MVC 컨트롤러로 인식된다.
    - `@Repository` : 스프링 데이터 접근 계층으로 인식하고 해당 계층에서 발생하는 예외는 모두 `DataAccessException`으로 변환한다.
    - `@Service` : 특별한 처리는 하지 않으나, 개발자들이 핵심 비즈니스 계층을 인식하는데 도움을 준다.
    - `@Configuration` : 스프링 설정 정보로 인식하고 스프링 빈이 싱글톤을 유지하도록 추가 처리를 한다. (???)

### `@Configuration`이 빈에 대해 싱글톤을 보장하는 방법

- 만약 다음과 같은 코드가 있다면 각각 다른 2개의 빈이 생성되어 싱글톤이 깨진다고 생각할 수 있음
    
    ```java
    @Configuration
    public class AppConfig {
    	@Bean
    	public MemberService memberService() {
    		return new MemberServiceImpl(memberRepository());
    	}
    
    	@Bean
    	public OrderService orderService() {
    		return new OrderServiceImpl(memberRepository(), discountPolicy());
    	}
    
    	@Bean
    	public MemberRepository memberRepository() {
    		return new MemoryMemberRepository();
    	}
    }
    ```
    
- `@Configuration`이 붙은 객체가 빈으로 등록될 때, CGLIB을 사용하여 해당 객체를 상속받은 프록시 객체를 등록한다.
- 대강 아래와 같이 구현되어 있다고 생각
    
    ```java
    public MemberRepository memberRepository() {
    	if (memoryMemberRepository가 이미 스프링 컨테이너에 등록되어 있으면?) {
    		return 스프링 컨테이너에서 찾아서 반환;
    	} else {
    		기존 로직을 호출해서 MemoryMemberRepository를 생성하고 스프링 컨테이너에 등록
    		return 반환;
    	}
    }
    ```
    
- 프록시 객체이므로 위 코드는 동적으로 만들어진다.

### Bean Lite Mode

- CGLIB을 이용하여 바이트 코드 조작을 하지 않는 방식. 즉, 빈의 싱글톤을 보장하지 않는다.
- `@Component`로 클래스를 설정하거나 수동으로 빈을 등록하면 `objectMapperLiteBean()` 메소드를 lite mode로 작동하여 Bean Lite Mode가 동작한다.

## ApplicationContext

- 스프링에서 객체를 생성하고 초기화하는 기능을 담당하는 인터페이스
- `AnnotationConfigApplicationContext` → … → `ApplicationContext` → … → `BeanFactory` 순으로 상속. BeanFactory가 최상단.
- **AnnotationConfigApplicationContext**: 자바 어노테이션을 이용한 클래스로부터 객체 설정 정보 가져옴
    - scan() 메소드 사용
- **BeanFactory** : 객체 생성과 검색에 대한 기능 정의하는 인터페이스
    - getBean 메소드 정의되어 있음
    - 싱글톤/프로토타입 빈인지 확인하는 기능도 제공
- 메시지, 프로필/환경 변수 등을 처리할 수 있는 기능 추가로 제공
- 빈의 생성, 초기화, 보관, 제거 등을 담당하므로 **컨테이너** 라고도 부름
- 다음과 같이 빈을 수동 등록할 수도 있다.
    
    ```java
    public static void main(String[] args) {
    	final ApplicationContext beanFactory = new AnnotationConfigurationApplicationContext(AppConfig.class);
    	final AppConfig bean = beanFactory.getBean("appConfig", AppConfig.class);
    }
    ```
    

## Bean Scope

### Singleton

- 컨테이너에서 한 번만 생성되며, 컨테이너가 사라질 때 제거된다.
- 생성된 인스턴스는 Spring Beans Cache에 저장되고, 해당 빈에 대한 요청과 참조가 있으면 캐시된 객체를 반환함.
- 모든 빈은 디폴트로 싱글톤이다.
- `@Scope(”singleton”)` 을 클래스에 붙이면 된다.

### Prototype

- DI가 발생할 때마다 새로운 객체가 생성되어 주입된다.
- 생성과 의존 관계 주입 및 초기화까지만 스프링 컨테이너가 진행한다.
- 빈 소멸 시 스프링 컨테이너가 관여하지 않고, **GC에 의해 제거된다.**
- `@Scope(”prototype”)` 을 클래스에 붙이면 된다.

프로토타입 객체가 싱글톤 객체를 갖는 것은 문제가 되지 않지만, 싱글톤 객체가 프로토타입 객체를 가지는 경우 문제가 될 수 있다. **싱글톤 빈 생성 시점에 이미 프로토타입 빈이 생성되어 들어오기 때문에 싱글톤 빈 내부의 프로토타입 빈을 호출하면 매번 같은 값을 가져온다.**

## 빈 생명주기

### Singleton Bean

1. 스프링 컨테이너 생성(setBeanName(), setBeanFactory(), setApplicationContext())
2. 스프링 빈 생성
3. 의존 관계 주입
4. 초기화 콜백(`@PostConstruct`)
5. 사용
6. 소멸 전 콜백(`@PreDestroy`)
7. 스프링 종료(destroy())

### Prototype Bean

1. 스프링 컨테이너 생성
2. 스프링 빈 생성
3. 의존 관계 주입
4. 초기화 콜백
5. 사용(여기까지 동일)
6. **GC에 의해 수거**

## 싱글톤 빈은 Thread-safe한가?

```java
public class Singleton {
	private static Singleton instance = new Singleton();
	
	private Singleton() {}
	
	public static Singleton getInstance() {
		return instance;
	}
}
```

- 결론부터 말하자면, NO.
- 어플리케이션이 종료될 때까지 메모리에 상주한다.
- 상태를 갖게 된다면 멀티 스레드 환경에서 동기화 문제가 발생할 수 있다.