# PM2
## PM2란?
* Node의 Process Manager
* 프로세스가 예상치 못하게 종료될 경우 다시 살려주거나, 코드가 수정될 경우 자동으로 재실행하거나, 로그에 대해 처리하는 등 프로세스에 관한 많은 것들을 관리해주는 친구

<br>

## 설치
```bash
npm install pm2 -g
```
* EACESS 에러가 날 경우 sudo 앞에 붙여주면 됨

<br>

## 명령어
### 프로그램 실행
```bash
pm2 start app.js
```
* 코드가 수정될 경우 자동 재실행되도록 하려면
    ```bash
    pm2 start app.js --watch
    ```
* 특정 파일이나 디렉토리를 제외하고 재실행 옵션을 주려면
    ```bash
    pm2 start app.js --watch --ignore-watch="data/*"
    ```
### 실행 중인 프로그램 목록 보기
```bash
pm2 list
```
### 각종 정보 모니터링
```bash
pm2 monit
```
### 프로그램 종료
```bash
pm2 stop [name]
```
### 로그 보기
```bash
pm2 logs
```