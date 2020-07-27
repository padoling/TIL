# React Router
## React Router란?
* React의 네비게이션 라이브러리
* 웹 페이지에서 **Router**란 사용자가 접속하는 URI에 따라 다른 페이지를 나타내는 것을 의미함
* React로 **SPA(Single Page App)** 를 만들 때 특정 이벤트에 따라 화면을 다르게 표시하는 것은 가능하지만, URI에 따라 페이지가 변경되게 하는 것은 어려움
* **React Router**를 사용하면 SPA로 화면을 그리면서도 URI에 따른 라우티잉 가능함

<br>

## 설치
```bash
npm i react-router-dom
```

<br>

## 사용하기
### Link 컴포넌트
* 이동할 경로를 지정하는 컴포넌트
* `to` prop을 통해 경로를 지정
* HTML의 `<a>` 태그와 비슷해서 컴포넌트 내부에 있는 요소가 클릭 가능한 요소로 렌더링되며, 클릭하면 지정된 경로로 이동함
```jsx
<Link to="/about">About</Link>
```
### Route 컴포넌트
* 지정한 경로가 현재 주소창의 경로와 매칭될 경우 보여줄 컴포넌트를 지정
* `path` prop을 통해 경로를 지정하고 `component` prop을 통해 컴포넌트를 지정
```jsx
<Route path="/about" component={About} />
```
### Router 컴포넌트
* `<Link>`와 `<Route>` 컴포넌트가 함께 유기적으로 사용되도록 묶어주는 기능
* `react-router-dom` 패키지에서는 Router 컴포넌트로 일반적으로 `BrouseRouter`를 사용함
```jsx
<Router>
  ...
  <Link to="/about">About</Link>
  ...
  <Route path="/about" component={About} />
  ...
</Router>  
```
### Switch 컴포넌트
* 하위에 있는 `<Route>` 컴포넌트 중에 제일 처음 매치되는 컴포넌트만 렌더링하고, 나머지는 매치되더라도 무시함
* 따라서 `<Route>`를 배치하는 순서가 중요함
```jsx
<Switch>
  <Route path="/" component={Home} />
  <Route path="/about" component={About} />
  <Route component={NotFound} />
</Switch>
```

<br>

## 전체 예시
```jsx
import React from "react";
import {BrowserRouter as Router, Switch, Route, Link} from "react-router-dom";

export default function App() {
  return (
    <Router>
      <div>
        <nav>
          <ul>
            <li>
              <Link to="/">Home</Link>
            </li>
            <li>
              <Link to="/about">About</Link>
            </li>
            <li>
              <Link to="/users">Users</Link>
            </li>
          </ul>
        </nav>

        <Switch>
          <Route path="/about">
            <About />
          </Route>
          <Route path="/users">
            <Users />
          </Route>
          <Route path="/">
            <Home />
          </Route>
        </Switch>
      </div>
    </Router>
  );
}
```

<br>

## Reference
* <https://www.daleseo.com/react-router-basic/>
* <https://reacttraining.com/react-router/web/guides/quick-start>