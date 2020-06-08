# Node.js

## Node.js란?
* Chrome V8 JavaScript 엔진으로 빌드된 **JavaScript 런타임**
    * 런타임 : 프로그래밍 언어가 구동되는 환경
* 서버를 선언할 수 있어 백엔드로 쓸 수 있음

## Node 시작하기
### 설치
1. npm 설치
    * `brew install npm`
    * **npm** : Node Packaged Manager, Node로 만들어진 패키지를 관리하는 툴
2. node 설치
    * `brew install node` ← npm을 설치하면 같이 설치되어 있는 듯
3. `app.js`를 만들어서 서버를 선언하고 실행
### Getting started
> [Node.js 시작 가이드](https://nodejs.org/ko/docs/guides/getting-started-guide/)
1. `app.js` 파일을 만들어 아래 코드를 입력
    ```jsx
    const http = require('http');

    const hostname = '127.0.0.1';
    const port = 3000;

    const server = http.createServer((req, res) => {
        res.statusCode = 200;
        res.setHeader('Content-Type', 'text/plain');
        res.end('Hello World');
    });

    server.listen(port, hostname, () => {
        console.log('Server runinng at http://${hostname}:${port}/');
    });
    ```
2. `node app.js`로 서버 실행
    * 다음 문구가 콘솔에 나타남  
    `Server running at http://${hostname}:${port}/`

3. 주소창에 `[http://localhost:3000](http://localhost:3000)` 입력하면 `Hello World`를 확인할 수 있음  
    ![Hello World](/img/node_hello_world.png)