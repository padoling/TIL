#!/usr/bin/env bash

# hello world 출력
echo "hello world"	# 자동 개행
printf "hello world\n"	# 자동 개행 안됨
printf "%s %s\n" hello world

# 함수
string_test() {
	echo "string test"
}

function string_test2() {
	echo "string test 2"
	echo "인자값: ${@}"
}

# 함수 실행
string_test
string_test2
# 함수에 인자값 전달하기(2개의 인자)
string_test2 "hello" "world"

# 변수 선언
variable="abc"
num=123

# 변수 사용
echo "${variable}"
echo "${num}"

