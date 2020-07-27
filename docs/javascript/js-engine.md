# JavaScript Engine
## JavaScript Engine이란?
* JavaScript로 작성한 코드를 해석 및 파싱하고 실행하는 **인터프리터**
* JIT(Just-in-time) 컴파일 기법을 사용함
* 다양한 엔진들이 있으며, 대표적으로 Chrome 브라우저와 Node.js에서 사용하는 **Google V8**이 있음

<br>

## JS Engine 파이프라인
![js engine pipeline](/img/js_engine_pipeline.png)
자바스크립트 엔진들이 소스코드를 기계어로 만들기까지 공통적으로 수행하는 과정
1. JavaScript 코드 파싱 ⇨ **Abstract Syntax Tree(AST)** 로 변환
2. AST를 바탕으로 interpreter가 **bytecode** 생성
3. 코드를 더 빠르게 실행하기 위해 **optimizing compiler(최적화 컴파일러)** 로 바이트코드 보내짐 ⇨ profiling data를 기반으로 optimized machine code 생성
4. 만약 정확하지 않은 결과가 나왔다면 **deoptimize**하여 bytecode로 되돌림
* JS Engine의 종류에 따라 optimizing compiler의 개수와 처리 과정이 조금씩 다름

### interpreter
* 최적화되지 않은 bytecode를 빠르게 생성함
* 속도는 빠르지만 생성된 코드가 효율적이지 않음
> **bytecode** : 하드웨어가 아닌 가상 컴퓨터에서 돌아가는 프로그램(소프트웨어)을 위한 이진 표현법

### optimizing compiler
* 매우 최적화된 machine code를 시간을 들여서 생성함
* 효율적인 코드를 만들지만 좀 더 시간이 걸림

<br>

## JS Engine의 구성요소
### Call Stack(호출 스택)
* 실행되는 함수를 쌓는 스택
* 자바스크립트는 **단 하나의 호출 스택**을 사용함
    * 즉, 하나의 함수가 실행되면 그 함수의 실행이 끝날 때까지 다른 어떤 task도 수행될 수 없음
![js call stack](/img/js_call_stack.png)
* **스택 프레임(Stack Frame)** : 호출 스택의 각 단계를 의미
* **스택 트레이스(Stack Trace)**: 에러가 발생했을 때, 에러가 발생하기까지의 스택 단계

### Memory Heap
* 메모리 할당이 일어나는 곳
* 동적으로 생성된 객체가 할당됨

<br>

## Reference
* <https://k39335.tistory.com/9>
* <https://velog.io/@godori/JavaScript-engine-1>
* <https://joshua1988.github.io/web-development/translation/javascript/how-js-works-inside-engine/>