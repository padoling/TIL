# React State
## state란?
* 컴포넌트가 무언가를 기억하게 만들 수 있는 object
* `props`와 비슷하지만 전혀 다름!
    * `props`는 인자로 전달받은 뒤 값을 변경할 수 없지만, `state`는 `setState()`라는 메소드로 언제든 값을 변경할 수 있음

<br>

## state 사용법
* 생성자를 이용하여 초기화
```jsx
constructor(props) {
    super(props);
    this.state = {
        value: null,
    };
}
```
* `this.state.xxx`의 형태로 사용
```jsx
render() {
    return (
        <button value={this.state.value}>
            Button!
        </button>
    );
}
```
* `setState()`로 값 변경
    * 직접 수정하는 것은 좋지 않음
```jsx
render() {
    return (
        <button onClick={() => this.setState({value: 'X'})}>
            Button!
        </button>
    );
}
```

<br>

## Mounting
### Mounting이란?
* React에서 DOM에 리소스가 생성되거나 삭제되는 일련의 생명주기를 다루는 용어
* `DOM`에 `node`를 추가하는 것을 `mounting`이라고 함
* 반대로 `DOM`에서 `node`를 제거하는 것을 `unmounting`이라고 함
### 생명주기 관련 메소드
* `componentWillMount()` : Before-mount
* `componentDidMount()` : After-mount
* `componentWillUnmount()` : Before-unmount
* `componentDidUnmount()` : After-unmount

<br>

## Reference
* <https://ko.reactjs.org/docs/state-and-lifecycle.html>
* <https://stackoverflow.com/questions/31556450/what-is-mounting-in-react-js>