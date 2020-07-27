# React list and key
## 배열을 리스트로 만들기
* JavaScript의 `map()` 메소드를 사용하여 JavaScript 배열을 `<li>`로 만들 수 있음
```jsx
const numbers = [1,2,3,4,5];
const listItems = numbers.map((number) =>
  <li>{number}</li>
);
ReactDOM.render(
  <ul>{listItems}</ul>,
  document.getElementById('root')
);
```

<br>

## key 부여하기
* React에서는 리스트에 반드시 key 값을 부여해야 함
* 위 코드와 같이 작성하면 key를 넣어야 한다는 경고가 표시됨
* `<li>` 태그 안에 `key`라는 속성을 사용해서 key를 부여할 수 있음
```jsx
const numbers = [1,2,3,4,5];
const listItems = numbers.map((number) =>
  <li key={number.toString()}>
    {number}
  </li>
);
```
### key란?
* 리스트에서 각 항목을 식별할 수 있게 해 주는 고유한 **문자열 값**
* key 값은 **unique해야 함**. 즉, 항목마다 다른 값을 사용해야 함
* 일반적으로 해당 데이터의 **ID**를 key 값으로 사용함
### key를 사용해야 하는 곳
* key는 배열이 있는 context에서 사용되어야 함
* `<li>` 태그를 사용하는 곳과 배열의 각 요소를 리스트로 만드는 곳을 구분해서 key를 적절한 곳에 사용해야 함
```jsx
function ListItem(props) {
  // 맞습니다! 여기에는 key를 지정할 필요가 없습니다.
  return <li>{props.value}</li>;
}

function NumberList(props) {
  const numbers = props.numbers;
  const listItems = numbers.map((number) =>
    // 맞습니다! 배열 안에 key를 지정해야 합니다.
    <ListItem key={number.toString()} value={number} />
  );
  return (
    <ul>
      {listItems}
    </ul>
  );
}

const numbers = [1, 2, 3, 4, 5];
ReactDOM.render(
  <NumberList numbers={numbers} />,
  document.getElementById('root')
);
```

<br>

## Reference
* <https://beomy.tistory.com/29>
* <https://ko.reactjs.org/docs/lists-and-keys.html>