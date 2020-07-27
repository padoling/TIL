# Zsh

## Zsh란?
* Z shell의 줄임말로, bash shell에 이런저런 기능이 더해진 신기한 쉘
* 맥 Catalina OS부터는 zsh이 기본 쉘이 되었음

<br>

## Oh My Zsh
* Zsh의 플러그인
* 다음 명령어로 설치할 수 있음
```shell
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

<br>

## Zsh 기능
### 경로 자동완성
* Ex) /usr/local/bin을 쓸 경우 /u/lo/b 라고 쓴 후 tab을 누르면 자동으로 완성시켜줌
### syntax highlighting
* 사용 가능한 명령어는 초록색으로, 사용할 수 없는 명령어는 빨간색(분홍색)으로 표시됨
* 설치 및 적용 방법
```shell
brew install zsh-syntax-highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
```
### git alias
* git 명령어들을 alias로 매칭해놓아 간단하게 쓸 수 있음
* Ex)
    * git status : gst
    * git add : ga
    * git add all : gaa
### 디렉토리 이동 alias
* 몇몇 디렉토리를 이동하는 명령어를 쓸 때 cd를 이용하지 않아도 됨
* Ex)
    * cd .. : ..
    * home으로 이동 : ~
    * cd ../.. : ...
    * 직전 디렉토리로 이동 : -

### 💻 [Oh My Zsh Cheatsheet Link](https://github.com/ohmyzsh/ohmyzsh/wiki/Cheatsheet)

<br>

## Reference
* <https://awesometic.tistory.com/115>
* <https://medium.com/harrythegreat/oh-my-zsh-iterm2로-터미널을-더-강력하게-a105f2c01bec>