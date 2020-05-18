## Calendar

### java.util.Calendar.add()
```
public abstract void add(int field, int amount)
```
* field : Calendar의 특정 field. Calendar.DAY_OF_MONTH와 같은 특정 일자가 될 수도 있고, 특정 요일이 될 수도 있음
* amount : field에 더할 값. 빼기를 하고 싶다면 마이너스 값을 넣으면 됨

void값을 반환하며 해당 메소드를 호출한 캘린더에 변환된 값이 바로 반영됨