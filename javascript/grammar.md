# JavaScript Grammar
## JS Array
### array.slice()
* 배열에서 선택된 부분을 새로운 배열로 만들어 반환함
* **Ex**
    ```js
    var fruits = ["Banana", "Orange", "Lemon", "Apple", "Mango"];
    var citrus = fruits.slice(1, 3);
    ```
    **Result**
    ```html
    Orange, Lemon
    ```

### array.concat()
* 여러 개의 배열을 join하기 위해 사용
* 기존 배열을 변경하지 않고 join의 결과로 **새로운 배열을 만들어 반환함**
* **Ex**
    ```js
    var hege = ["Cecilie", "Lone"];
    var stale = ["Emil", "Tobias", "Linus"];
    var children = hege.concat(stale);
    ```
    **Result**
    ```html
    Cecilie, Lone, Emil, Tobias, Linus
    ```

### array.map()
* 배열의 모든 요소에 대해 차례대로 주어진 함수를 실행시킴
* 기존 배열을 변경하지 않고 **새로운 배열을 만들어 반환함**
* **Ex**
    ```js
    const numbers = [1, 2, 3];
    const doubled = numbers.map(x => x * 2);
    ```
    **Result**
    ```html
    2, 4, 6
    ```
#### callback 함수의 인자
* map()의 인자로 사용하는 callback 함수에는 세 가지 파라미터가 들어갈 수 있음
    1. `currentValue` : 배열의 각 요소
    2. `index`(optional) : 배열의 각 요소의 인덱스
    3. `array`(optional) : 배열 자체
* 파라미터를 하나만 사용할 경우, 즉 `currentValue`만 사용할 경우에는 `()`를 생략할 수 있음
* [JavaScript map() docs](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/map)
* **Ex**
    ```js
    let numbers = [1, 2, 3, 4];
    let filteredNumbers = numbers.map((num, index) => {
      if (index < 3) {
          return num
      }
    });
    ```
* **Result**
    ```html
    1, 2
    ```

## Conditional Statements
### If, If-else
* 일반적인 if 조건문과 같음
```js
const isLoggedIn = false;
if (isLoggedIn) {
  return "Welcome back!";
}
return "Please sign up.";
```
### Inline If with && Operator
* `&&` 논리 연산자를 사용하여 조건문을 간략하게 작성할 수 있음
* JavaScript에서 `true && expression`은 항상 true를 반환하고 `false && expression`은 항상 false를 반환함
```js
return unreadMessages.length > 0 &&
  `You have ${unreadMessages.length} unread messages.`;
```
### 삼항 연산자
* `condition ? true ? false`와 같이 삼항연산자를 사용하여 간단한 조건문 표현할 수 있음
```js
const isLoggedIn = false;
return `The user is ${isLoggedIn ? '' : 'not'} logged in.`;
```

## export
### export란?
* JS 모듈에서 함수, 객체, 변수 등을 다른 파일에서 쓸 수 있도록 방출(?)하는 것
* `import` 구문을 이용하여 다른 모듈에서 export된 값들을 사용할 수 있음
### Named exports & Default exports
* Named exports는 이름을 가지며, 여러 개 생성 가능
```js
// export features declared earlier
export { myFunction, myVariable };

// export individual features
export let myVariable = Math.sqrt(2);
export function myFunction() {...};
```
* Default exports는 이름을 갖지 않으며, 모듈 당 단 하나만 생성 가능
```js
// export features declared earlier as default
export { myFunction as default };

// export individual features as default
export default function() {...}
export default class {...}
```
### import modules
* Named exports를 import할 때에는 해당 이름을 정확히 명시해줘야 함
```js
// export file(my-module.js)
export { cube, foo, graph };

// import file
import { cube, foo, graph } from './my-module.js';
```
* Default exports를 import할 때에는 어떤 이름을 써서 import해도 됨
```js
// export file(my-module.js)
export default function cube(x);

// import file
import k from './my-module.js';
```

## Reference
* <https://www.w3schools.com>
* <https://ko.reactjs.org/tutorial/tutorial.html#showing-the-past-moves>
* <https://developer.mozilla.org/en-US/docs/web/javascript/reference/statements/export>