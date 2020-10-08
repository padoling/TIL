# Mongoose
## Mongoose란?
* MongoDB 기반의 node.js용 ODM(Object Data Mapping) 라이브러리
* javascript 객체와 mongoDB의 data를 매핑해주는 인터페이스 등의 기능이 들어있음

<br>

## 설치
```shell
npm install mongoose
```

<br>

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

<br>

## Reference
* <https://mongoosejs.com/docs/guide.html>