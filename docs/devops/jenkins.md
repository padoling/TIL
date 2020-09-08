# Jenkins

## Jenkins란?
* 오픈소스 CI툴로, 빌드, 배포 등을 자동화할 수 있게 해줌
* Jenkins 서버를 설치해서 사용할 수 있음

<br>

## Jenkins 설치하기

### macOS에서 설치 방법
brew를 이용해 설치할 수 있음
* latest LTS version 설치
```bash
brew install jenkins-lts
```
* brew로 설치한 Jenkins 실행하기
```bash
brew services start jenkins-lts
```
설치 및 실행 후 `http://localhost:8080`에 접속해서 installation을 마칠 수 있음

### Docker에 설치 방법
#### 1. bridge network 생성
```bash
docker network create jenkins
```

#### 2. docker volume 생성
```bash
docker volume create jenkins-docker-certs
docker volume create jenkins-data
```

#### 3. Jenkins node 안에서 docker 명령을 실행하기 위해 `docker:dind` 이미지 다운로드 및 실행

    ```bash
    # 이미지 다운로드
    docker image pull docker:dind

    # 컨테이너 실행
    docker container run \
    --name jenkins-docker \
    --rm \
    --detach \
    --privileged \
    --network jenkins \
    --network-alias docker \
    --env DOCKER_TLS_CERTDIR=/certs \
    --volume jenkins-docker-certs:/certs/client \
    --volume jenkins-data:/var/jenkins_home \
    --publish 2376:2376 \
    docker:dind
    ```

* `name`: (Optional) 이미지를 실행할 docker container의 이름 설정
* `rm`: (Optional) docker container 종료 시 자동으로 삭제
* `detach`: (Optional) docker container를 백그라운드에서 실행
* `privileged`: docker 안에서 docker를 실행하기 위해 privileged 모드로 설정해야 함
* `network`: 앞서 생성한 네트워크 설정
* `network-alias`: `jenkins` 네트워크 내의 `docker` 호스트네임을 설정하여 docker 안의 docker가 가능하도록 함
* `env`: docker 서버에서 TLS 사용이 가능하도록 함
* `volume jenkins-docker-certs:/certs/client`: `/certs/client` 디렉토리를 `jenkins-docker-certs` volumne과 매핑시킴
* `publish`: (Optional) docker daemon 포트를 호스트 장치에서 볼 수 있도록 함
* `docker:dind`: 이미지 자체

#### 4. `jenkinsci/blueocean` 이미지 다운로드 및 실행

    ```bash
    # 이미지 다운로드
    docker image pull jenkinsci/blueocean

    # 컨테이너 실행
    docker container run \
    --name jenkins-blueocean \
    --rm \
    --detach \
    --network jenkins \
    --env DOCKER_HOST=tcp://docker:2376 \
    --env DOCKER_CERT_PATH=/certs/client \
    --env DOCKER_TLS_VERIFY=1 \
    --publish 8080:8080 \
    --publish 50000:50000 \
    --volume jenkins-data:/var/jenkins_home \
    --volume jenkins-docker-certs:/certs/client:ro \
    jenkinsci/blueocean
    ```

<br>

## Reference
* <https://www.jenkins.io/doc/>