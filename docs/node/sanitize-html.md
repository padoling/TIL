# sanitize-html
## sanitize-html이란?
* node.js의 라이브러리 중 하나로, XSS와 같은 공격을 막기 위해 HTML에서 특정 태그를 허용하거나 허용하지 않는 기능을 제공해줌
* 더러운 HTML(공격이 가능한 HTML)을 소독한다는 의미에서 sanitize라는 이름 사용...

<br>

## 설치
```bash
npm install sanitize-html
```
* 특정 프로젝트에서만 사용하고 싶다면 해당 프로젝트의 루트에서 `npm install -S sanitize-html` 실행

<br>

## 사용 예제

### 기본적인 사용

* 코드
```js
var sanitizeHtml = require('sanitize-html');
var dirty = 'dirty HTML with some <script></script> tags';
var clean = sanitizeHtml(dirty);
```

* 실행 결과
```shell
console.log(clean);
> 'dirty HTML with some tags'
```

### customized version
* 다음과 같이 허용하는 태그나 속성 등을 명시할 수 있음
* `allowed`로 명시되지 않은 태그들은 전부 삭제됨
```js
clean = sanitizeHtml(dirty, {
    allowedTags: [ 'b', 'i', 'h1' ],
    allowedAttributes: {
        'a': ['href']
    },
    allowedIframeHostnames: ['www.youtube.com']
});
```

### default set에 추가하기
```js
clean = sanitizeHtml(dirty, {
    allowedTags: sanitizeHtml.defaults.allowedTags.concat(['img'])
});
```

<br>

## Reference
* <https://www.npmjs.com/package/sanitize-html>