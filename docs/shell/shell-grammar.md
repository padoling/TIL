# Shell grammar

## 기본 문법

### 기본 출력
* `echo` : 자동 개행이 되는 출력 명령어
```shell
echo "hello world"
```
* `printf` : 자동 개행이 되지 않는 출력 명령어
```shell
printf "hello world"
printf "%s %s" hello world  # 인자값을 넣을 수 있음
```

### 함수
* `function`을 써도 되고 생략해도 됨
* 함수 호출 코드가 함수 코드보다 뒤에 있어야 함
```shell
function test() {
    echo "test"
}
test2() {
    echo "test2"
    echo "인자값: ${@}" # @는 모든 인자를 의미
}
# 함수 호출
test
test2
test2 "hello" "world"   # 함수에 인자값 넘겨주기
```

### 변수 선언
* 타입을 따로 지정하지 않고 변수를 선언함
* `=`을 쓸 때는 공백 없이 붙여써야 함
* 지역변수는 `local`로 선언
* 환경변수는 `export`로 선언하며, 자식 스크립트에서 사용할 수 있음
```shell
var="abc"
num=123
function test() {
    local local_var="local" # 지역 변수
    echo ${local_var}
}
export hello_world="hello world"    # 환경 변수
```
* `$`를 이용하여 변수 사용
```shell
echo "${var}"
echo "${num}"
```

### 배열
* `()` 안에 원소를 띄어쓰기로 나열하여 선언
* 배열의 특정 인덱스를 명시하거나 `+=`로 배열에 원소 추가
* `unset` : 배열의 특정 요소나 배열 전체 삭제
```shell
array=("hello" "world" "test")
echo "${array[0]}"  # "hello"
echo "${array[@]}"  # 모든 원소
array+=("string")   # 원소 추가
array[4]="variable"
unset array[4]  # 4번째 인덱스 삭제
unset array     # 배열 전체 삭제
```

### 조건문
* `if[]; then ~ elif[]; then ~ else ~ fi`와 같은 구조
```shell
num=5
if ["${num}" -eq 2]; then
    echo "num = 2"
elif ["${num}" -eq 3]; then
    echo "num = 3"
else
    echo "num = 5"
fi
```

### 반복문
* `while`문과 `for`문이 있음
```shell
cnt=0
# while문
while [${num} < 5]; do
    echo "{cnt}"
    cnt=$(( %{cnt}+1 ))
done
array=(1 2 3 4 5)
# for문
for i in ${array[@]}; do
    echo "${array[i]}"
done
```

<br>

## Reference
* <https://blog.gaerae.com/2015/01/bash-hello-world.html>
* <https://twpower.github.io/131-simple-shell-script-syntax>