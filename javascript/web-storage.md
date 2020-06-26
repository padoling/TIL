# web storage
## web storage란?
* 클라이언트에 데이터를 저장할 수 있도록 지원하는 HTML5의 기능
* `localStorage`와 `sessionStorage`의 두 가지 종류가 있음
### 쿠키와의 차이점
* 쿠키의 데이터는 서버에 요청 시 함께 전달하기 위한 것이지만, 웹 스토리지 객체는 서버로 전달되지 않음
* 쿠키와 달리 서버가 HTTP 헤더를 통해 웹 스토리지 객체를 조작할 수 없음

<br>

## localStorage와 sessionStorage의 차이점
### localStorage
* 데이터 만료 기간이 없음
* 브라우저 탭을 닫거나 os를 재시작해도 데이터가 지워지지 않음
### sessionStorage
* 브라우저 탭이 유지되는 동안만 데이터가 유지됨
* 탭을 새로고침할 때 데이터는 유지되나, 탭을 닫았다 열었을 경우 데이터는 사라짐

<br>

## web storage 메소드
* `setItem(key, value)` : 키 - 값 쌍을 보관
> 주의 : 웹 스토리지에는 오직 string 값만 저장할 수 있음!
* `getItem(key)` : 키에 해당하는 값을 가져옴
* `removeItem(key)` : 키와 해당 값을 삭제
* `clear()` : 스토리지의 모든 값 삭제
* `key(index)` : 인덱스에 해당하는 키를 가져옴
* `length` : 저장된 데이터의 개수를 가져옴

<br>

## Reference
* <https://ko.javascript.info/localstorage>
* <https://untitledtblog.tistory.com/47>