# React Component

## 컴포넌트란?
* JavaScript의 함수와 유사한 개념
* `props`라는 임의의 입력을 받은 후, **React 엘리먼트**를 반환함

<br>

## 컴포넌트 정의
### 함수 컴포넌트
```js
function Welcome(props) {
    return <h1>Hello, {props.name}</h1>
}
```
* JavaScript 함수처럼 쓰면 됨
* `props`를 인자로 받아 컴포넌트로서의 역할을 할 수 있음
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
* `React.Component`를 상속받아 사용
* 인자를 따로 명시하지 않아도 `props`가 존재하는 듯
* 클래스 컴포넌트 내부에는 `render()` 메소드가 반드시 존재해야 함
    * `render()` 내부에서 React 엘리먼트 반환

<br>

## 컴포넌트 렌더링
### 사용자 정의 컴포넌트로 React 엘리먼트 만들기
* 사용자 정의 컴포넌트로 React 엘리먼트를 나타낼 수 있음
* 즉, 사용자가 직접 생성한 함수나 클래스를 태그처럼 사용할 수 있음
* 엘리먼트 예시)
    ```jsx
    const element = <Welcome name="Sara" />;
    ```
* 사용자 정의 컴포넌트로 작성한 엘리먼트를 발견하면 JSX 속성과 자식을 해당 컴포넌트에 객체로 전달하는데, 이것이 `props`임!
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
1. `ReactDOM.render()` 호출, `element`를 인자로 넘김
2. React가 `{name: 'Sara'}`를 `props`로 넘기면서 `Welcome` 컴포넌트 호출
3. `Welcome` 컴포넌트가 `<h1>Hello, Sara</h1>` 엘리먼트 반환
4. React DOM이 위 엘리먼트와 알치하도록 DOM을 효율적으로 업데이트
    * ❕컴포넌트 이름은 항상 대문자로 시작함❕

<br>

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
    ```js
    function withdraw(account, amount) {
        account.total -= amount;
    }
    ```
### 불변성(Immutability)
* 객체가 변하지 않는 특징
* 원래 객체의 데이터를 직접 변경하지 않고, 복사한 객체의 값을 변경하여 원래 객체와 교체함으로써 불변성을 유지할 수 있음
* 인자로 넘어오는 객체가 불변성을 유지하도록 하는 함수를 **순수 함수**라고 함
### 불변성이 중요한 이유
* history 유지에 용이
    * 특정 행동을 취소하고 다시 실행하거나, 이전 동작으로 돌아가는 기능을 간단하게 만들 수 있음
* 변화 감지
    * 객체의 변화를 감지하기 쉬움
    * 참조하고 있는 객체가 이전의 객체와 다른 객체라면 변화가 일어난 것
* React에서 렌더링 시기 결정
    * 순수 객체(pure components)를 만들기 용이함
    * 변화를 감지하기 쉽기 때문에 다시 렌더링할 시점을 결정하기 쉬움

<br>

## Reference
* <https://ko.reactjs.org/docs/components-and-props.html>