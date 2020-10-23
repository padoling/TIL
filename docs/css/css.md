# CSS

## display
* 해당 요소를 어떤 방식으로 보여줄지 결정

### 속성

#### `none` 
* 요소를 렌더링하지 않음

#### `block`
* 블록처럼 렌더링
* `div`, `p`, `h`, `li` 태그 등에 해당하는 렌더링
* 기본적으로 가로 영역을 모두 채우며, 줄바꿈이 된 것처럼 보임

#### `inline`
* 줄바꿈이 되지 않음
* 크기를 지정할 수 없음
* 볼드, 이탤릭, 밑줄 등 효과를 주기 위한 단위

#### `inline-block`
* 줄바꿈이 되지 않지만 크기를 지정할 수 있음

<br>

## overflow
* 어떤 요소의 내용이 너무 많아서 요소의 크기를 벗어날 경우 어떻게 처리할지 결정

### 속성

#### `visible`
* 디폴트 값
* 요소의 크기를 벗어난 내용은 그 요소의 밖에 그대로 렌더링 됨

#### `hidden`
* 요소의 크기를 벗어난 내용은 보이지 않음

#### `scroll`
* 스크롤바가 생성됨

#### `auto`
* `scroll`처럼 스크롤바가 생성되지만, 필요한 경우에만 생성됨

<br>

## Reference
* <https://ofcourse.kr/css-course/display-%EC%86%8D%EC%84%B1>
* <https://www.w3schools.com/css/css_overflow.asp>