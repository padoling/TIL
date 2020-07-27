# Exception

## getLocalizedMessage()
Exception의 종류를 지정된 locale에 따라 다르게 나타내주는 메소드
### Example
* 코드
```java
try {
    ...
} catch(Exception e) {
    logger.error("Error occured : type {}", e.getLocalizedMessage());
}
```
* 실행 결과
```
> Error occured : type NullPointerException
```

