# stream

## stream이란?
* 배열이나 Collection에서 연속된 데이터의 흐름 
* 기존의 반복문을 이용한 순회와 달리 데이터의 **병렬처리(parallel processing)** 가 가능
* 람다식을 사용하여 데이터를 처리할 수 있음
* `Stream` 클래스가 존재하며, `Collection`들은 `stream()` 메소드를 통해 Collection 내부 요소를 순회할 수 있도록 지원함

<br>

## stream 가공하기
### .filter()
`filter`는 스트림 안의 데이터를 주어진 조건과 비교하여 걸러내는 메소드이다. 다음 예시와 같이 주로 stream에서 람다식을 filter의 조건으로 사용한다.
```java
List<String> fruits = Arrays.asList("apple", "banana", "orange");

Stream<String> stream = fruits.stream()
    .filter(fruit -> fruit.contains("a"));
```
위 예시에서 `stream`에는 다음 데이터들이 담겨있게 된다.
```java
[apple, banana]
```
즉, 조건을 만족하는 데이터만 걸러서 return하게 된다.

### .collect()
`collect`는 stream에서 처리한 데이터를 특정한 `Collector` 타입으로 모아주는 역할을 한다. 대표적으로 다음과 같이 List 형태로 데이터를 모아줄 수 있다.
```java
List<String> fruits = Arrays.asList("apple", "banana", "orange");

List<String> fruitsWithA = fruits.stream()
    .filter(fruit -> fruit.contains("a"))
    .collect(Collectors.toList());
```

<br>

## Reference
* <https://futurecreator.github.io/2018/08/26/java-8-streams/>