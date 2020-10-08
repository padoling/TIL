# callback 함수

## callback 함수란?
* 비동기적으로 실행되는 메소드에서, 해당 메소드의 실행이 끝난 후에 호출되는 함수
* 보통 메소드의 인자로 콜백 함수를 넣어준다
  ```js
  // 세 번째 인자로 들어간 함수가 콜백함수
  fs.readFile('sample.txt', 'utf-8', function(err, result) {
    console.log(result);
  });
  ```
  * 위 예시의 경우, **파일을 읽는 동작이 완료된 후**에 `result`를 콘솔에 찍는 함수가 실행됨

<br>

## Reference
* <https://www.w3schools.com>