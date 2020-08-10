# React Event

## React Event 사용하기

### 이벤트 호출
* 컴포넌트에 이벤트를 명시할 때에는 `camelCase`로 적고, `{}` 안에 핸들러 함수를 넣어줌
```jsx
return(
    <button onClick={activateLasers}>
        Activate Lasers
    </button>
);
```

### default 동작 막기
* 이벤트의 default 동작을 막기 위해서는 `preventDefault()`를 명시해줘야 함
* `false`를 return하여 default 동작을 취소할 수 **없음**
```jsx
function ActionLink() {
    function handleClick(e) {
        e.preventDefault();
        console.log('The link was clicked.');
    }

    return (
        <a href="#" onClick={handleClick}>
        Click me
        </a>
    );
}
```

<br>

## Synthetic event
* 리액트는 이벤트 핸들러에 이벤트를 전달할 때 `SyntheticEvent` 인스턴스를 전달함
* 브라우저의 native 이벤트를 래핑한 것이기 때문에 native 이벤트의 인터페이스를 동일하게 사용할 수 있음
* 모든 브라우저에서 동일하게 작동함

### Event Pooling
* `SyntheticEvent`는 성능상의 이유로 풀링됨
  * 즉, `SyntheticEvent` 객체는 재사용되고 속성들은 이벤트 핸들러가 호출된 후에 초기화됨
* 따라서 이벤트 객체에 비동기적으로 접근할 수 없음

<br>

## this 바인딩

### this란?
* 메소드를 사용할 때, 해당 메소드를 소유한 컴포넌트를 가리킴
* class 컴포넌트를 사용할 경우, 다른 컴포넌트로 `this.xxx`를 넘겨줄 때 `this`가 바인딩되어 있지 않음
* 따라서 수동으로 바인딩해주어야 함

### 바인딩하기
* 기본적으로 다른 컴포넌트로 `this`를 전달할 때에만 binding을 하면 됨
  * `render()` 함수 내에서 그냥 사용할 때에는 상관 없음
* `constructor`에서 바인딩해주는 방법과 화살표 함수를 쓰는 방법이 있음
* `constructor`에서 바인딩
  * React 공식 문서에서 권장하는 방법
  ```jsx
  class Toggle extends React.Component {
        constructor(props) {
            super(props);
            this.state = {isToggleOn: true};

            // binding
            this.handleClick = this.handleClick.bind(this);
        }

        handleClick() {
            this.setState(state => ({
                isToggleOn: !state.isToggleOn
            }));
        }

        render() {
            return (
                <button onClick={this.handleClick}>
                {this.state.isToggleOn ? 'ON' : 'OFF'}
                </button>
            );
        }
  }
  ```
* 화살표 함수 사용
  * 화살표 함수를 사용하면 `this`는 해당 화살표 함수가 정의된 객체를 가리킴
  * 해당 컴포넌트가 렌더링될 때마다 다른 콜백이 생성된다는 문제점이 있음
  ```jsx
  class LoggingButton extends React.Component {
        handleClick() {
            console.log('this is:', this);
        }

        render() {
            // binding
            return (
                <button onClick={() => this.handleClick()}>
                Click me
                </button>
            );
        }
  }
  ```

<br>

## Reference
* <https://blog.sonim1.com/179>
* <https://ko.reactjs.org/docs/handling-events.html>
* <https://www.w3schools.com/react/react_events.asp>
* <https://blog.jaeyoon.io/2018/01/react-bind.html>