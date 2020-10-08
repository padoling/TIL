# Factory Pattern

## Factory Pattern이란?
* 하나의 super class와 여러 개의 sub class가 있는 상태에서 input 값에 따라 sub class의 인스턴스를 생성해 반환하는 디자인 패턴
* `Factory`에서 상황에 맞는 인스턴스를 생성하고 반환하는 역할을 함

<br>

## 예시

### Super Class
* super class는 인터페이스, 추상 클래스 등이 될 수 있음

```java
public interface Animal {
    public int eat(String food);
}
```

### Sub Class
* `Component()` 안에 해당 클래스의 id를 지정할 수 있음

```java
@Component("catAnimal")
public class CatAnimal implements Animal {
    @Override
    public int eat(String food) {
        System.out.println(food + "라는 음식을 먹었다냥");
        return food.length();
    }
}
```

```java
@Component("dogAnimal")
public class DogAnimal implements Animal {
    @Override
    public int eat(String food) {
        System.out.println(food + "라는 음식을 먹었어요! 멍멍");
        return food.length();
    }
}
```

### Factory
* `@Qualifier` 어노테이션으로 주어진 id에 해당하는 클래스를 불러와 super class 타입으로 선언할 수 있음
* 여기서는 sub class로 미리 정의된 bean을 주입받아 사용하는 형태
* `species`라는 input으로 어떤 값이 주어지느냐에 따라 다른 인스턴스를 반환함
```java
@RequiredArgsConstructor
@Component
public class AnimalFactory {
    @Qualifier("catAnimal")
    private final Animal catAnimal;

    @Qualifier("dogAnimal")
    private final Animal dogAnimal;

    public Animal getAnimal(String species) {
        if(species.equals("cat")) {
            return catAnimal;
        } else if(species.equals("dog")) {
            return dogAnimal;
        } else {
            return null;
        }
    }
}
```

### 인스턴스 호출하기
* Factory 클래스를 주입받아 input에 따라 다른 `Animal` 인스턴스 생성
```java
@RequiredArgsConstructor
@Service
public class AnimalService {

    private final AnimalFactory animalFactory;

    public void animalEats(String species, String food) {
        Animal animal = animalFactory.getAnimal(species);
        int foodLen = animal.eat(food);
        System.out.println("음식 양 : " + foodLen);
    }
}
```

<br>

## Reference
* <https://blog.seotory.com/post/2016/08/java-factory-pattern>