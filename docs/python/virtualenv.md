# Virtual Environment

## Python에서 가상환경 만들기
* Python에서는 그냥 라이브러리들을 설치하게 되면 Global하게 설치되기 때문에, 서로 다른 버전의 라이브러리를 사용해야 하는 프로젝트 간 충돌이 생길 수 있음
* 따라서 각 프로젝트마다 독립적인 가상의 환경을 만들고 거기에 각 환경에 맞는 라이브러리를 설치해야 함

<br>

## virtualenv 사용
### 설치
```shell
python3 -m pip install --user -U virtualenv
```

### 가상환경 만들기
```shell
# 가상환경을 만들고 싶은 폴더 내부에서 아래 명령 실행
python3 -m virtualenv venv

# 가상환경 활성화
source venv/bin/activate

# 현재 가상환경 비활성화
deactivate
```

<br>

## Reference
* Aurelien Geron. (2019). Hands-On Machine Learning with Scikit-Learn, Keras, and TensorFlow.