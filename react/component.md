# React Component

## 컴포넌트란?
* JavaScript의 함수와 유사한 개념
* `props`라는 임의의 입력을 받은 후, **React 엘리먼트**를 반환함

## 컴포넌트 정의
### 함수 컴포넌트
```js
function Welcome(props) {
    return <h1>Hello, {props.name}</h1>
}
```
* JavaScript 함수를 React에서 컴포넌트라고 여김
* `props` : properties의 약자로, 컴포넌트를 정의할 때 받게 되는 인자
### 클래스 컴포넌트
```js
class Welcome extends React.Component {
    render() {
        return <h1>Hello, {this.props.name}</h1>;
    }
}
```
* ES6 class를 사용한 컴포넌트
* 인자를 따로 명시하지 않아도 `props`가 존재하는 듯

## 컴포넌트 렌더링
* 사용자 정의 컴포넌트로 React 엘리먼트를 나타낼 수 있음
* 즉, 사용자가 직접 생성한 함수나 클래스를 태그처럼 사용할 수 있음
* 엘리먼트 예시)
    ```jsx
    const element = <Welcome name="Sara" />;
    ```
* 사용자 정의 컴포넌트로 작성한 엘리먼트를 발견하면 JSX 속성과 자식을 해당 컴포넌트에 단일 객체로 전달하는데, 이것이 `props`임!
    * 여기서는 `{name: 'Sara}`가 `props`에 포함되는 값
### 렌더링 예시
```jsx
function Welcome(props) {
    return <h1>Hello, {props.name}</h1>;
}

const element = <Welcome name="Sara" />;
ReactDOM.render(
    element,
    document.getElementById('root')
);
```
1. `ReactDOM.render()` 호출
2. React가 `{name: 'Sara'}`를 `props`로 넘기면서 `Welcome` 컴포넌트 호출
3. `Welcome` 컴포넌트가 `<h1>Hello, Sara</h1>` 엘리먼트 반환
4. React DOM이 위 엘리먼트와 알치하도록 DOM을 효율적으로 업데이트
> 컴포넌트 이름은 항상 대문자로 시작함

## props 사용 시 주의할 점
* 컴포넌트 내에서 **props를 수정해서는 안됨!**
* React 컴포넌트는 반드시 **순수 함수**처럼 동작해야 함
* 순수 함수의 예시)
    ```js
    function sum(a, b) {
        return a + b;
    }
    ```
* 순수 함수가 아닌 함수의 예시
    ```js)
    function withdraw(account, amount) {
        account.total -= amount;
    }
    ```

## Reference
* <https://ko.reactjs.org/docs/components-and-props.html>