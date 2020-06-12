# JSX
## JSX란?
* JavaScript를 확장한 문법으로, **React 엘리먼트**를 생성하기 위해 사용됨
* React는 마크업과 로직을 **컴포넌트**라고 부르는 느슨하게 연결된 유닛에 모두 포함하여 **관심사를 분리함**
    * 관심사 분리(Separation of concerns) : 프로그램의 단위를 각 관심사(concern)에 따라 분리하는 것
* JSX를 사용하면 컴포넌트에 UI 관련 마크업을 직관적이고 쉽게 포함할 수 있음

## JSX 문법
### JSX에 표현식 포함하기
* 중괄호(`{}`) 안에 모든 JavaScript 표현식을 넣을 수 있음
    ```jsx
    const name = 'Josh Perez';
    const element = <h1>Hello, {name}</h1>;
    ```
* 포함될 수 있는 표현식의 예시
    * `2 + 2` : 수식
    * `user.firstName` : 변수
    * `formatName(user)` : 함수
    * `return <h1>Hello, {formatName(user)}!</h1>;` : 또다른 JSX
### 속성(attribute) 정의
* 따옴표(`""`)를 사용하여 속성으로 문자열을 정의할 수 있음
    ```jsx
    const element = <div tabIndex="0"></div>;
    ```
* 중괄호를 사용하여 JavaScript 표현식 삽입 가능
    ```jsx
    const element = <img src={user.avatarUrl}></img>;
    ```
> JSX에서 클래스나 속성 등의 이름을 지을 때는 HTML 어트리뷰트 이름 대신 camelCase 명명 규칙을 사용함
### 자식 정의
* HTML과 같이 자식 포함 가능
```jsx
const element = (
    <div>
        <hi>Hello!</h1>
        <h2>Good to see you here.</h2>
    </div>
)
```
### 태그
* 태그가 비어있다면 `/>`를 이용해 닫아주어야 함
```jsx
const element =  <img src={user.avatarUrl} />;
```

## JSX 특징
### 주입 공격(Injection Attack) 방지
* **ReactDOM**이 JSX를 렌더링하기 전에 모든 값을 **이스케이프(escape)** 시켜 문자열로 변환함
    * 이스케이프(escape) : 특정 문자를 HTML로 변환하는 행위
* 애플리케이션에 명시적으로 작성된 것 이외에는 어떤 것도 주입될 수 없음
* XSS(cross-site-scripting) 방지
### React element 생성
JSX는 **Babel**에 의해 다음과 같이 컴파일 됨
```jsx
const element = (
    <h1 className="greeting">
        Hello, world!
    </h1>
);
```
```js
const element = React.createElement(
    'h1',
    {className: 'greeting'},
    'Hello, world!'
);
```
* `React.createElement()`가 `React element`라고 불리는 일종의 object를 생성함
* React는 이 object를 읽고 DOM을 구성하는 데 사용함

## Reference
* <https://ko.reactjs.org/docs/introducing-jsx.html>