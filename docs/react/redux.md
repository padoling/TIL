# Redux

## Redux란?
* **A Predictable State Container for JS Apps**
* JavaScript 애플리케이션의 복잡성을 줄여주기 위한 도구
* 복잡성을 줄여 애플리케이션의 상태를 **예측 가능하게** 만들어 줌

<br>

## Redux를 사용하는 이유

### 종속성 제거
* `state`를 `store`라는 공간에 한데 모아 저장하기 때문에 각 모듈 간 `props`를 통해 이어지던 종속성이 획기적으로 줄어들게 됨
* 원하는 컴포넌트 어디에서든 `store`를 불러와서 상태를 바로 사용할 수 있음

### 시간 여행
* 각 `state`를 수정할 때 원본은 그대로 두고 원본을 복제한 복제본을 수정하기 때문에 각 상태 변화가 독립된 상태를 유지할 수 있음
* **Redux DevTools**라는 chrome extension을 사용하면 `state`의 변화 상태에 따라 시간여행을 할 수 있음
    * chrome extension 설치 후, 아래 코드를 `createStore`의 두 번째 인자로 삽입해야 함
    ```js
    window.__REDUX_DEVTOOLS_EXTENSION__ && window.__REDUX_DEVTOOLS_EXTENSION__()
    ```

<br>

## Redux의 작동 원리
![Redux Architecture](../img/redux_architecture.jpeg)

### store
* `state`를 저장하는 공간
* `Redux.createStore()`를 통해 생성할 수 있으며, `reducer`를 인자로 전달받음
```js
var store = Redux.createStore(reducer);
```

### state
* 실제 값들이 저장됨
* 외부에서 직접 접근하는 것은 불가능하며, `store.getState()`를 통해 값을 가져올 수 있음
```js
var state = store.getState();
```

### reducer
* 현재 `state`와 `action`을 인자로 받은 뒤 새로운 `state`를 반환함
* 즉, 현재 `state`를 바탕으로 `action`을 참고하여 새로운 `state`를 만들어냄
```js
function reducer(state, action) {
    switch(action.type) {
        case "CHANGE_COLOR":
        return {
            ...state,
            color: action.color
        }
        default:
        return {
            color: "yellow"
        }
    }
}
```

### action
* `state`의 상태를 어떻게 변화시킬지 방법을 정의함
* `action` 객체는 항상 `type`이라는 key를 포함해야 함
```js
// dispatch() 내부의 객체가 action
store.dispatch({type: 'CHANGE_COLOR', color: 'blue'})
```

### Redux 관련 메소드
* `store.dispatch(action)` : store에 애플리케이션의 상태를 수정해달라는 요청을 보내서 reducer를 호출
* `store.subscribe(render)` : state의 상태가 바뀔 때마다 인자로 들어간 render가 자동으로 호출되어 화면을 다시 렌더링하도록 함

<br>

## container로 redux에 대한 종속성 제거
* redux를 사용하면 react component 간의 종속성은 사라지지만, **redux store의 state에 대한 종속성을 갖게 됨**
* 만약 component를 다른 앱에서 재사용하고 싶다면 이러한 redux에 대한 종속성을 없애야 함
* `container` 역할을 하는 component를 만들어서 종속성을 제거할 수 있음

### Presentational component
* redux와 연관이 1도 없는 순수 react component
* 기존의 react component가 하듯이 화면을 그리는 작업만 함
* redux를 사용하지 않는 다른 앱에서 재사용 가능

### Container component
* Presentational component를 감싸서 해당 component가 redux를 사용할 수 있도록 함
* `store.getState()`나 `store.dispatch()`와 같이 redux와 관련된 로직을 분리해서 Container component에 넣음

<br>

## React-Redux
* React에서 Redux를 편리하게 사용할 수 있도록 만들어진 라이브러리

### Provider
* Redux의 `store`를 어디서든 사용할 수 있게 해 주는 컴포넌트
* 최상위 컴포넌트를 감싸도록 작성하면 앱 전체에서 `store`에 접근할 수 있음
* `props`로 반드시 `store`를 넘겨줘야 함
```jsx
<Provider store={store}>
    <App />
</Provider>
```

### connect
* Container component의 역할을 쉽게 할 수 있도록 redux와 관련된 `props`를 component에 넘겨주는 메소드
* `state`와 `dispatch`와 관련된 객체를 처리하는 두 개의 함수를 인자로 받아 component에 `props`로 전달해주는 함수를 반환함
```jsx
// Redux store의 state를 React component의 props로 전달
function mapStateToProps(state) {
    return {
        color: state.color
    };
}
// Redux의 dispatch 메소드를 처리하는 함수를 React component의 props로 전달
function mapDispatchToProps(dispatch) {
    return {
        onClick: color => {
            dispatch({type: "CHANGE_COLOR", color: color});
        }
    };
}
export default connect(mapStateToProps, mapDispatchToProps)(SomeComponent);
```

<br>

## Reference
* <https://redux.js.org/>
* [생활코딩 Redux 강의](https://www.notion.so/Redux-2c7c4a7c8d1a43c9ad7922fa3db37325#de87de30cc0443e0a2b131725b331d85)
* [생활코딩 React-Redux 강의](https://www.youtube.com/watch?v=fkNdsUVBksw&list=PLuHgQVnccGMDuVdsGtH1_452MtRxALb_7)