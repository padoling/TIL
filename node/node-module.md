# Node.js module
## module이란?
* 독립된 기능을 갖는 것(함수, 파일)들의 모임
* **외장 모듈** : 개인 개발자들이 만든 모듈로, npm을 사용해서 설치해야 함
* **내장 모듈** : node.js 안에 기본적으로 제공되는 모듈

<br>

## 모듈 생성하기
* `exports`라는 전역 객체를 사용하여 모듈을 외부에 공개하고 다른 모듈들이 사용할 수 있도록 할 수 있음
### exports에 직접 프로퍼티 설정
```js
exports.add = function(a, b) {
  return a + b;
}

exports.multiply = function(a, b) {
  return a * b;
}
```
* `exports` 객체에 직접적으로 `add`와 `multiply`라는 함수를 프로퍼티로 설정

### module.exports에 객체 할당
```js
var calc = {};

calc.add = function(a, b) {
  return a + b;
}

calc.multiply = function(a, b) {
  return a * b;
}

module.exports = calc;
```
* 먼저 함수들을 담은 객체를 만든 후에 `module.exports`에 그 객체를 할당

### 다음과 같이 `exports` 객체에 직접 객체를 할당해서는 안됨!
```js
var calc = {};
//...
exports = calc;
```
* Node.js는 모듈을 처리할 때 `exports`를 일종의 속성으로 인식
* 위와 같이 작성하면 `exports`는 더 이상 모듈 시스템에서 처리할 수 있는 전역변수가 아닌 다른 변수로 인식됨

> 공식 문서에서는 될 수 있으면 `module.exports`를 쓸 것을 권장함. `exports`는 단순히 `module.exports`를 참조할 뿐인 객체.

<br>

## 모듈 불러오기
* `require()` 함수를 호출하여 모듈 불러오기 가능
* `require()` 함수는 `module.exports` 객체를 리턴함
* 인자로 넣는 파일 경로에서 **확장자는 생략 가능**
```js
var calc = require("./calc");

console.log(calc.add(3, 5));
```

<br>

## Reference
* <https://victorydntmd.tistory.com/16>
* <https://poiemaweb.com/nodejs-module>
* <https://medium.com/@chullino/require-exports-module-exports-%EA%B3%B5%EC%8B%9D%EB%AC%B8%EC%84%9C%EB%A1%9C-%EC%9D%B4%ED%95%B4%ED%95%98%EA%B8%B0-1d024ec5aca3>