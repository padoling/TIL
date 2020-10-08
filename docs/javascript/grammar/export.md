# export

## export란?
* JS 모듈에서 함수, 객체, 변수 등을 다른 파일에서 쓸 수 있도록 방출(?)하는 것
* `import` 구문을 이용하여 다른 모듈에서 export된 값들을 사용할 수 있음

<br>

## Named exports & Default exports
* Named exports는 이름을 가지며, 여러 개 생성 가능
```js
 // export features declared earlier
export { myFunction, myVariable };

 // export individual features
export let myVariable = Math.sqrt(2);
export function myFunction() {...};
```
* Default exports는 이름을 갖지 않으며, 모듈 당 단 하나만 생성 가능
```js
 // export features declared earlier as default
export { myFunction as default };

 // export individual features as default
export default function() {...}
export default class {...}
```

<br>

## import modules
* Named exports를 import할 때에는 해당 이름을 정확히 명시해줘야 함
```js
 // export file(my-module.js)
export { cube, foo, graph };

 // import file
import { cube, foo, graph } from './my-module.js';
```
* Default exports를 import할 때에는 어떤 이름을 써서 import해도 됨
```js
 // export file(my-module.js)
export default function cube(x);

 // import file
import k from './my-module.js';
```

<br>

## Reference
* <https://www.w3schools.com>
* <https://developer.mozilla.org/en-US/docs/web/javascript/reference/statements/export>