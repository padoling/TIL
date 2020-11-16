# 재귀 쿼리

## 재귀 쿼리란?
* 자기 자신을 참조하는 쿼리
* `CTE`를 재귀적으로 사용하여 계속해서 하위 집합을 반환
> `CTE(Common Table Expression, 공통 테이블 식)` : 임시로 이름이 지정된 결과 집합. 저장되지 않고 쿼리 지속 시간 동안만 존재함
* 계층 구조를 SELECT할 때 유용함

---

## 재귀 쿼리의 구조
아래와 같은 테이블이 존재한다고 할 때,

|id|name|parent_id|
|---|---|---|
|1|고양이|0|
|2|코숏|1|
|3|삼색이|2|
|4|치즈|2|
|5|샴|1|

주어진 id의 하위 계층까지 SELECT하는 구문은 다음과 같다.

```sql
WITH CTE AS (
    SELECT id, name, parent_id
    FROM CAT
    WHERE id = 2
    UNION ALL
    SELECT a.id, a.name, a.parent_id
    FROM CAT a
    INNER JOIN CTE b ON a.parent_id = b.id
)
SELECT id, name, parent_id
FROM CTE
```
* MySQL에서 재귀 쿼리를 사용하기 위해서는 `WITH` 뒤에 `RECURSIVE`를 붙여줘야 한다!

실행 결과는 다음과 같이 `id = 2`인 행과 더불어 그 하위 계층에 해당하는 행까지 출력된다.

|id|name|parent_id|
|---|---|---|
|2|코숏|1|
|3|삼색이|2|
|4|치즈|2|

---

## 쿼리 실행 순서
1. CTE 식을 anchor 멤버와 재귀 멤버로 구분한다
    * 위 예시에서 anchor 멤버인 부분
    ```sql
    SELECT id, name, parent_id
    FROM CAT
    WHERE id = 2
    ```

    * 재귀 멤버인 부분
    ```sql
    SELECT a.id, a.name, a.parent_id
    FROM CAT a
    INNER JOIN CTE b ON a.parent_id = b.id
    ```
2. anchor 멤버를 실행하여 첫 번째 결과 집합(T0)을 만든다
3. T1부터 재귀 멤버를 실행한다
    * 이 때 Ti는 입력, Ti+1은 출력이 된다
4. 빈 결과 집합이 반환될 때까지 **3**을 반복한다.
5. T0부터 Tn까지 UNION ALL한 최종 결과 집합을 반환한다.

---

## Reference
* <https://nive.tistory.com/149>
* <https://allmana.tistory.com/4>