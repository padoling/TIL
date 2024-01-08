# 캐스팅(casting)
## 업캐스팅(Upcasting)
- 서브 클래스를 수퍼 클래스 타입으로 형변환하는 것
- 업캐스팅 후에는 수퍼 클래스의 멤버에만 접근 가능하다
- 다형성을 위해 사용한다.

## 다운캐스팅(Downcasting)
- 서브 클래스의 객체를 복구시키는 것, 즉 업캐스팅된 객체를 원상복귀 시키는 것
- 반드시 업캐스팅이 선행되어야 한다
    - 업캐스팅을 하지 않고 다운캐스팅을 하는 경우 컴파일 에러는 발생하지 않지만 런타임에 에러가 발생한다(`ClassCastException`)

## instanceof
- 객체의 타입을 구분하기 위해 instanceof 연산자를 사용할 수 있음
- 업캐스팅했을 때 객체 타입을 구분하는 데에 
- 참조형 타입에만 사용할 수 있다

## 참고자료
- https://madplay.github.io/post/java-upcasting-and-downcasting
- [TESTDOME 문제](https://www.testdome.com/questions/java/cache-casting/109977)