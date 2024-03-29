# Calendar

## Calendar.add()
```java
public abstract void add(int field, int amount)
```
* field : Calendar의 특정 field. Calendar.DAY_OF_MONTH와 같은 특정 일자가 될 수도 있고, 특정 요일이 될 수도 있음
* amount : field에 더할 값. 빼기를 하고 싶다면 마이너스 값을 넣으면 됨

void값을 반환하며 해당 메소드를 호출한 캘린더에 변환된 값이 바로 반영됨

<br>

## Calendar.setTimeZone()
```java
public void setTimeZone(TimeZone value)
```
해당 Calendar의 TimeZone을 설정하여 Calendar의 값들이 설정된 TimeZone에 맞게 표시되도록 할 수 있음

<br>

## SimpleDateFormat
* Calendar를 문자열로, 문자열을 Calendar로 변환시키는 기능을 가진 클래스

### SimpleDateFormat.parse()
* 문자열을 Calendar로 변환
```java
SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
String ymd = "20201012";
Calendar c = Calendar.getInstance();
c.setTime(simpleDateFormat.parse(ymd));
```

### SimpleDateFormat.format()
* Calendar를 문자열로 변환
```java
SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
Calendar c = Calendar.getInstance();
String time = simpleDateFormat.format(c.getTime());
```