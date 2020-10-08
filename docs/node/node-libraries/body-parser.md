# BodyParser
## BodyParser란?
* request body의 데이터를 파싱하여 javascript에서 사용할 수 있는 형태로 만들어주는 라이브러리

<br>

## 설치
```shell
npm install body-parser
```

<br>

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

<br>

## Reference
* <https://www.npmjs.com/package/body-parser/v/1.1.1>