# React form

## Controlled Component

### Controlled Component란?
* React에 의해 값이 제어되는 input form 엘리먼트
* 기존 HTML form은 `submit`을 하면 페이지를 새로고침하며 `value`를 명시된 링크로 보내는데, 이러한 기본 동작 대신 React의 `state`의 값이 update되도록 하는 식

### 기본 사용 방식
```jsx
class NameForm extends React.Component {
    constructor(props) {
        super(props);
        this.state = {value: ''};

        this.handleChange = this.handleChange.bind(this);
        this.handleSubmit = this.handleSubmit.bind(this);
    }

  // input 칸 값에 변화가 일어나면 state가 바로 업데이트됨
    handleChange(event) {
        this.setState({value: event.target.value});
    }

    handleSubmit(event) {
        alert('A name was submitted: ' + this.state.value);
        // 기본 submit 동작을 막음
        event.preventDefault();
    }

    render() {
        return (
            <form onSubmit={this.handleSubmit}>
                <label>
                    Name:
                    <input type="text" value={this.state.value} onChange={this.handleChange} />
                </label>
                <input type="submit" value="Submit" />
            </form>
        );
    }
}
```
* `input`의 `value` 속성 값을 `{this.state.value}`로 설정하여 항상 `state`에 있는 값이 form에 적용되도록 함
* `onChange` 이벤트 발생 시 곧바로 `state` 값이 업데이트 됨
* `onSubmit`의 기본 동작을 `preventDefault()`로 막음

### 여러 개의 input 관리하기
* `state`로 관리해야 할 input이 여러개인 경우, `name` 속성을 부여하여 `handleEvent` 메소드와 `state`에서 input들을 구분하도록 할 수 있음
```jsx
class Reservation extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            isGoing: true,
            numberOfGuests: 2
        };

        this.handleInputChange = this.handleInputChange.bind(this);
    }

    handleInputChange(event) {
        const target = event.target;
        // checkbox와 number input을 구분
        const value = target.name === 'isGoing' ? target.checked : target.value;
        // get the name of event
        const name = target.name;

        this.setState({
            [name]: value
        });
    }

    render() {
        return (
            <form>
                <label>
                    Is going:
                    <input
                        name="isGoing"
                        type="checkbox"
                        checked={this.state.isGoing}
                        onChange={this.handleInputChange} />
                </label>
                <br />
                <label>
                    Number of guests:
                    <input
                        name="numberOfGuests"
                        type="number"
                        value={this.state.numberOfGuests}
                        onChange={this.handleInputChange} />
                </label>
            </form>
        );
    }
}
```

<br>

## Controlled tags

### textarea
* 원래 `textarea`는 태그 안에 표시할 값을 적지만, React에서는 **`value` 속성에 값을 적음**
* 이 `value` 또한 `state`에 의해 관리될 수 있음
```jsx
class EssayForm extends React.Component {
    constructor(props) {
            super(props);
            this.state = {
            value: 'Please write an essay about your favorite DOM element.'
        };

        this.handleChange = this.handleChange.bind(this);
        this.handleSubmit = this.handleSubmit.bind(this);
    }

    handleChange(event) {
        this.setState({value: event.target.value});
    }

    handleSubmit(event) {
        alert('An essay was submitted: ' + this.state.value);
        event.preventDefault();
    }

    render() {
        return (
            <form onSubmit={this.handleSubmit}>
                <label>
                    Essay:
                    <textarea value={this.state.value} onChange={this.handleChange} />
                </label>
                <input type="submit" value="Submit" />
            </form>
        );
    }
}
```

### select
* 원래 `select`는 드롭다운 리스트 중 선택된 `option`에 `selected` 속성이 부여되지만, React에서는 `select` 태그의 `value` 속성에 선택된 `option`의 값을 명시해줌
```jsx
class FlavorForm extends React.Component {
    constructor(props) {
        super(props);
        // selected option
        this.state = {value: 'coconut'};

        this.handleChange = this.handleChange.bind(this);
        this.handleSubmit = this.handleSubmit.bind(this);
    }

    handleChange(event) {
        this.setState({value: event.target.value});
    }

    handleSubmit(event) {
        alert('Your favorite flavor is: ' + this.state.value);
        event.preventDefault();
    }

    render() {
        return (
            <form onSubmit={this.handleSubmit}>
                <label>
                    Pick your favorite flavor:
                    <select value={this.state.value} onChange={this.handleChange}>
                        <option value="grapefruit">Grapefruit</option>
                        <option value="lime">Lime</option>
                        <option value="coconut">Coconut</option>
                        <option value="mango">Mango</option>
                    </select>
                </label>
                <input type="submit" value="Submit" />
            </form>
        );
    }
}
```

<br>

## Reference
* <https://reactjs.org/docs/forms.html>