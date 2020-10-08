# express
## express란?
* Node.js용 웹 애플리케이션 프레임워크

<br>

## 설치
```shell
npm install express
```

<br>

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

<br>

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