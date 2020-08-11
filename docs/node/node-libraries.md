# node 라이브러리
---
# PM2
## PM2란?
* Node의 Process Manager
* 프로세스가 예상치 못하게 종료될 경우 다시 살려주거나, 코드가 수정될 경우 자동으로 재실행하거나, 로그에 대해 처리하는 등 프로세스에 관한 많은 것들을 관리해주는 친구

## 설치
```shell
npm install pm2 -g
```
* EACESS 에러가 날 경우 sudo 앞에 붙여주면 됨

## 명령어

### 프로그램 실행
```shell
pm2 start app.js
```
* 코드가 수정될 경우 자동 재실행되도록 하려면
```shell
pm2 start app.js --watch
```
* 특정 파일이나 디렉토리를 제외하고 재실행 옵션을 주려면
```shell
pm2 start app.js --watch --ignore-watch="data/*"
```

### 실행 중인 프로그램 목록 보기
```shell
pm2 list
```

### 각종 정보 모니터링
```shell
pm2 monit
```

### 프로그램 종료
```shell
pm2 stop [name]
```

### 로그 보기
```shell
pm2 logs
```

<br>

---

# sanitize-html
## sanitize-html이란?
* node.js의 라이브러리 중 하나로, XSS와 같은 공격을 막기 위해 HTML에서 특정 태그를 허용하거나 허용하지 않는 기능을 제공해줌
* 더러운 HTML(공격이 가능한 HTML)을 소독한다는 의미에서 sanitize라는 이름 사용...

## 설치
```shell
npm install sanitize-html
```
* 특정 프로젝트에서만 사용하고 싶다면 해당 프로젝트의 루트에서 `npm install -S sanitize-html` 실행

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

## Reference
* <https://www.npmjs.com/package/sanitize-html>

<br>

---
# express
## express란?
* Node.js용 웹 애플리케이션 프레임워크

## 설치
```shell
npm install express
```

## 기본 express 앱 만들기
* ### [Hello world 예제](https://expressjs.com/ko/starter/hello-world.html)

```js
const express = require('express')
const app = express()   // express app 생성
const port = 3000

// get 요청 받기
app.get('/', (req, res) => {
  res.send('Hello World!')
})
// 주어진 포트 번호를 listen하고 성공 시 콜백함수 리턴
app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
})
```

## 실행
* express app이 위치한 파일을 `node` 명령어로 실행하면 됨
```shell
node app.js
```
* `package.json`의 `scripts`에 입력해서 실행할 수도 있음
```json
"scripts": {
    "start": "node app.js"
}
```
```shell
npm run start
```

<br>

---
# Mongoose
## Mongoose란?
* MongoDB 기반의 node.js용 ODM(Object Data Mapping) 라이브러리
* javascript 객체와 mongoDB의 data를 매핑해주는 인터페이스 등의 기능이 들어있음

## 설치
```shell
npm install mongoose
```

## Model과 Schema

### Mongoose Schema
* MongoDB 컬렉션의 구조를 정의함. 각 스키마는 각 컬렉션과 매핑됨
* 본래 MongoDB는 비관계형 데이터베이스로 데이터에 제약이 없지만, 편의성을 위해 스키마를 만들어 그 구조에 맞게 데이터를 넣음
* 예시)

```js
var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var blogSchema = new Schema({
    title:  String, // String is shorthand for {type: String}
    author: String,
    body:   String,
    comments: [{ body: String, date: Date }],
    date: { type: Date, default: Date.now },
    hidden: Boolean,
    meta: {
        votes: Number,
        favs:  Number
    }
});
```

### Mongoose Model
* 스키마를 감싸는 역할을 함
* 스키마를 DB에 CRUD할 수 있는 인터페이스를 제공함
* 예시)

```js
var Tank = mongoose.model('Tank', yourSchema);

var small = new Tank({ size: 'small' });
small.save(function (err) {
  if (err) return handleError(err);
  // saved!
});
```

## Reference
* <https://mongoosejs.com/docs/guide.html>

<br>

---
# BodyParser
## BodyParser란?
* request body의 데이터를 파싱하여 javascript에서 사용할 수 있는 형태로 만들어주는 라이브러리

## 설치
```shell
npm install body-parser
```

## 사용 예시
```js
var express = require('express')
var bodyParser = require('body-parser')

var app = express()

// parse application/json and application/x-www-form-urlencoded
app.use(bodyParser())
// parse application/vnd.api+json as json
app.use(bodyParser.json({ type: 'application/vnd.api+json' }))
```
* express app에서 특정 bodyParser를 사용하도록 설정할 수 있음

## Reference
* <https://www.npmjs.com/package/body-parser/v/1.1.1>

<br>

---
# NodeMon
## NodeMon이란?
* 소스가 변경되는 것을 감지해서 자동으로 서버를 재시작해주는 라이브러리

## 설치
```shell
npm install --save-dev nodemon
```
* `--save-dev` 모드로 설치하면 dev 모드에서만 해당 dependency를 포함하도록 할 수 있음

## 실행
```shell
nodemon index.js
```