# 조건문

## If, If-else
* 일반적인 if 조건문과 같음
```js
const isLoggedIn = false;
if (isLoggedIn) {
  return "Welcome back!";
}
return "Please sign up.";
```

<br>

## Inline If with && Operator
* `&&` 논리 연산자를 사용하여 조건문을 간략하게 작성할 수 있음
* JavaScript에서 `true && expression`은 항상 true를 반환하고 `false && expression`은 항상 false를 반환함
```js
return unreadMessages.length > 0 &&
  `You have ${unreadMessages.length} unread messages.`;
```

<br>

## 삼항 연산자
* `condition ? true ? false`와 같이 삼항연산자를 사용하여 간단한 조건문 표현할 수 있음
```js
const isLoggedIn = false;
return `The user is ${isLoggedIn ? '' : 'not'} logged in.`;
```

<br>

## Reference
* <https://www.w3schools.com>