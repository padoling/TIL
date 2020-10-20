# Hook

## Hook이란?
* React 16.8에 새로 추가된 기능으로, 함수 컴포넌트에서도 state를 비롯한 다른 기능들을 사용할 수 있게 해줌
* state와 생명주기 기능을 연동(hook into)할 수 있게 해주는 함수
* Class를 사용함으로써 생기는 복잡한 로직들을 해결하기 위해(?) 도입한 듯

<br>

## State Hook
* 버튼을 클릭하면 `count` 값이 증가하는 예시)

```jsx
import React, { useState } from 'react';

function Example() {
  // "count"라는 새 상태 변수를 선언합니다
  const [count, setCount] = useState(0);

  return (
    <div>
      <p>You clicked {count} times</p>
      <button onClick={() => setCount(count + 1)}>
        Click me
      </button>
    </div>
  );
}
```
* 함수 컴포넌트는 `this`를 가질 수 없기 때문에 `this.state`를 할당하거나 읽을 수 없음
* 대신 `useState` hook을 호출하여 사용 가능
* `useState`로 만든 state는 클래스 컴포넌트의 `this.state`와 똑같이 함수가 끝나도 사라지지 않음
* state를 사용하려면 `this.state.count`가 아니라 직접 해당 변수(여기서는 count)를 사용하면 됨

### useState
* 현재 state 값과 그 state 값을 업데이트하는 함수 쌍을 리턴함 - 여기서는 `count`가 state고, `setCount`가 state를 업데이트하는 함수
* 인자로 초기 state값을 받음 - 여기서는 0
* 하나의 컴포넌트 내에서 여러 개의 State Hook을 사용할 수 있음

### 배열 구조 분해(array destructuring)
* JavaScript 문법 중 하나로, 배열의 각 원소를 변수처럼 여겨 여러 개의 값을 각각 할당해 주는 방법

<br>

## Effect Hook
* document 타이틀의 count값을 업데이트하는 예시)

```jsx
import React, { useState, useEffect } from 'react';

function Example() {
  const [count, setCount] = useState(0);

  // componentDidMount, componentDidUpdate와 같은 방식으로
  useEffect(() => {
    // 브라우저 API를 이용하여 문서 타이틀을 업데이트합니다.
    document.title = `You clicked ${count} times`;
  });

  return (
    <div>
      <p>You clicked {count} times</p>
      <button onClick={() => setCount(count + 1)}>
        Click me
      </button>
    </div>
  );
}
```

### useEffect
* 컴포넌트가 렌더링 이후에 수행할 일을 정의함
* `useEffect`를 통해 넘긴 함수를 React에서 **DOM 업데이트 후에** 수행함
* 이를 통해 `componentDidMount()`, `componentDidUpdate()` 등의 생명주기 관련 함수를 각각 사용해주지 않아도 렌더링 이후에 언제나 같은 상태를 보장할 수 있음
* 한 컴포넌트에 여러 개의 `useEffect` 사용 가능
* **매번 렌더링이 될 때마다 실행됨**

### clean-up을 위한 useEffect의 return
```jsx
import React, { useState, useEffect } from 'react';

function FriendStatus(props) {
  const [isOnline, setIsOnline] = useState(null);

  useEffect(() => {
    function handleStatusChange(status) {
      setIsOnline(status.isOnline);
    }
    ChatAPI.subscribeToFriendStatus(props.friend.id, handleStatusChange);
    // effect 이후에 어떻게 정리(clean-up)할 것인지 표시합니다.
    return function cleanup() {
      ChatAPI.unsubscribeFromFriendStatus(props.friend.id, handleStatusChange);
    };
  });

  if (isOnline === null) {
    return 'Loading...';
  }
  return isOnline ? 'Online' : 'Offline';
}
```
* `useEffect`는 effect를 정리하기 위한 함수를 반환할 수 있음
* 마치 `componentWillUnmount()`와 같은 역할을 함

<br>

## Hook 사용 규칙
1. 반복문, 조건문, 중첩된 함수에서는 사용하면 안됨. 오로지 Top Level에서만 사용해야 함.
2. 일반 JavaScript 함수에서는 사용하며 안됨. React 함수 컴포넌트에서만 사용 가능.
* [위 규칙들을 강제로 지키게 하는 라이브러리](https://www.npmjs.com/package/eslint-plugin-react-hooks)

<br>

## Reference
* <https://ko.reactjs.org/docs/hooks-overview.html>