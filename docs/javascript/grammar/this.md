# this

## JavaScript에서의 this
* 다른 객체지향 언어들에서의 this와는 조금 다르게 작동함
* 함수 내에서의 **함수 호출 맥락(context)** 을 의미함
* 웹브라우저의 JavaScript에서 `window`는 전역객체이기 때문에 일반적으로 `this`는 `window`를 의미함
    * **전역객체** : 전역 범위(global scope)에 항상 존재하는 객체
    * 우리가 선언하는 모든 전역객체는 사실 `window` 객체에 소속된 객체임
* 그러나 함수 호출 환경에 따라 `this`가 가리키는 객체가 달라짐

### 메소드를 호출했을 때
```javascript
var o = {
    func : function() {
        if(o === this) {
            document.write("o === this");
        }
    }
}
o.func();   // 실행 결과 : o === this
```
* 어떤 메소드를 호출한 경우, `this`는 그 메소드를 호출한 객체 자신을 의미함
* 여기서는 `o` 객체 안에서 메소드 `func`를 호출했기 때문에 `this`는 `o`와 같음

### 생성자를 호출했을 때
```javascript
var funcThis = null;

function Func() {
    funcThis = this;
}

var o1 = Func();
if(funcThis === window) {
    document.write('window </br>');
}

var o2 = new Func();
if(funcThis === o2) {
    document.write('o2 </br>');
}
```
* `o1`에 담긴 객체는 메소드로써 실행된 `Func()`의 실행결과로, `Func()` 함수가 return하는 값이 없기 때문에 `undefined`임
* 따라서 `Func()`를 호출한 객체는 전역객체 `window`이므로 `funcThis === window`가 성립함
* `o2`에 담긴 객체는 **new 생성자에 의해 생성된 `Func()` 함수**이며, 위에서 정의한 메소드 `Func()`는 생성자이기 때문에 새로운 `Func()` 객체가 생성됨과 동시에 `Func()` 생성자가 실행됨
* 이 때 `Func()` 생성자를 호출한 객체는 새롭게 생성된 객체인 `o2`이므로 `funcThis === o2`가 성립함
    * 객체가 생성되고 생성자가 실행된 후에 `o2`라는 변수에 할당되므로, 생성자 안에 `if(functhis === o2)`를 넣으면 false가 됨
    * 그러므로 **`this`는 생성된 객체가 어떤 변수에 담겨서 접근 가능해지기 전에 해당 객체에 접근할 수 있는 방법이라는 것!**

<br>

## apply 사용
### apply란?
* Ecma 표준에 `Function` 객체에 대한 메소드로 정의되어 있는 기능
* 첫 번째 인자로 함수 호출 컨텍스트를 받음

### apply 사용 예시
```javascript
var o = {}
function func() {
    case o:
        document.write('o');
        break;
    case window:
        document.write('window');
        break;
}

func();     // window
func.apply(o);      // o
```
* `apply()` 메소드를 사용해 함수 호출 컨텍스트를 넣어주면 해당 함수의 호출 컨텍스트가 `apply`의 인자로 받은 객체가 되어 `this` 또한 인자로 받은 객체와 동일해짐
* 따라서 하나의 함수를 어떤 객체에 소속되게 할지 유연하게 결정할 수 있음

<br>

## Reference
* <https://hyunseob.github.io/2016/03/10/javascript-this/>
* <https://developer.mozilla.org/ko/docs/Web/JavaScript/Reference/Operators/this>
* [생활코딩 JavaScript 강의](https://www.youtube.com/watch?v=4ACSJlzJjJs)