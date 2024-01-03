# 프로세스

## 정의
- A program in execution, 즉 **실행 중인** 프로그램
- 운영체제의 작업의 단위임
- 프로세스는 작업을 수행하기 위해 리소스들이 필요함(CPU 시간, 메모리, 파일, I/O 장치 등)
- 프로그램이 저장공간에서 **메모리에 올라온 상태**

OS가 해야 할 가장 기본적인 일 : 프로세스 관리

## 메모리에 올라온 프로세스 레이아웃
- 텍스트 영역
    - 실행 가능한 코드
- 데이터 영역
    - 전역변수들
- 힙 영역
    - 프로그램 실행 중 동적으로 할당되는 메모리 영역
- 스택 영역
    - 함수 호출 시 쌓이는 영역
    - 함수 파라미터, 리턴 주소, 지역 변수들

## 프로세스 생명주기
- **New** : 프로세스가 생성된 상태. 즉, 막 메인 메모리에 올라온 상태
- **Running** : cpu를 점유해서 명령어들이 실행되는 상태
- **Waiting** : 프로세스가 어떤 이벤트가 발생하길 기다리는 상태
    - 대표적으로 I/O 처리가 완료되기를 기다리는 상태.
- **Ready** : Ready Queue에서 cpu를 점유할 준비가 된 채 기다리는 상태. 초기화된 상태.
- **Terminated** : 최종적으로 프로세스가 종료된 상태. 메모리와 자원이 회수됨.

- Running 상태에서 CPU 할당 시간이 다 되어 Interrupt를 받으면 Ready 상태로 들어간다.
- Running 상태에서 I/O나 어떤 이벤트가 있으면 Waiting 상태로 들어가고, I/O가 실행되는 동안 기다린다. I/O Completion이 되면 Ready queue로 다시 들어간다.
- **Dispatch** : Ready 상태에서 스케줄러에 의해 CPU를 할당받아 Running 상태로 가는 것. “스케줄러가 프로세스를 디스패치 했다” 라고 표현.

## PCB(Process Control Block)
or TCB(Task Control Block)
- 프로세스가 가져야 할 모든 정보를 다 저장한 블록
- 운영체제는 PCB를 가지고 프로세스를 핸들링함
- OS 커널 상의 자료구조. 메모리에 올라와 있는 프로세스를 관리함

### PCB에 들어가는 정보
- 프로세스 상태(Ready, Running, …)
- 프로그램 카운터(Program Counter, PC) : 현재 실행해야 할 Instruction이 메모리의 어느 위치에 있는지 나타내는 카운터
- CPU Registers : IR, DR
    - 프로그램 카운터, IR, DR과 같은 레지스터들을 **문맥(context)**이라고 본다.
- CPU 스케줄링 정보
- 메모리 관리 정보
- 계정 정보 : 어떤 유저가 만든 프로세스인지
- I/O 상태 정보 : 어떤 자원을 오픈해서 락을 걸었는지

## Thread
- 프로세스는 **a single thread of execution**을 수행하는 프로그램
- 이는 프로세스가 한 번에 하나의 태스크만 실행한다는 것을 의미한다.
- 현대의 OS는 프로세스의 개념을 확장함
    - 프로세스가 여러 개의 스레드를 가져 한 번에 여러 개의 작업을 수행할 수 있음
- 스레드는 경량 프로세스이다.

---

# 프로세스 스케줄링
- **Multiprogramming** : CPU 사용량을 극대화하기 위해 수행
- **Time sharing** : 프로세스 간 CPU 코어를 아주 자주 스위치해서 사용자에게 각 프로그램이 동시에 돌고 있는 것처럼 보이게 하기 위해 수행

## 스케줄링 큐
- 프로세스들은 대기 큐(ready queue)에 들어가서 CPU의 코어를 기다린다.
- Running 상태에서 빠져나오면 다시 대기 큐의 맨 끝으로 들어감
- I/O 상태에 들어가면 Waiting queue에 들어가고, I/O가 끝나면 다시 Ready queue로 들어감
    - Waiting queue의 경우 각 장치별로 큐가 존재하므로 여러 개가 있음
- Linked List로 구현할 수 있다

### Ready queue에 들어가는 경우
- CPU를 획득했다가 끝났을 때
- I/O가 끝났을 때
- Time slice가 끝났을 때
- CPU가 child를 포크했을 때(new 상태에서 ready 상태로)
- Interrupt가 발생했을 때

## Context Switch(문맥 교환)
- context란 프로세스가 실행되고 있는 상태로, PCB에 표현되어 있음
- Interrupt가 일어났을 때, 현재의 문맥 상태(가장 중요한 정보는 PC)를 저장해두고 CPU를 다시 획득했을 때 저장했던 context를 restore한다.
- CPU 코어를 다른 프로세스에게 넘겨주는 일
    - 현재 프로세스의 context를 저장하고
    - 새로운 프로세스의 context를 restore한다.

### Context switching 과정
1. 실행 중인 P0가 Time expired 되거나 I/O가 발생하는 등의 이벤트로 OS가 Interrupt를 발생시킨다.
2. P0의 상태를 저장한다.
3. P1의 상태를 restore한다. ← 제어권이 P1으로 넘어감
4. P1에 Interrupt가 발생되면 다시 P1의 상태를 저장한다.
5. 2번에서 저장했던 P0의 상태를 restore한다.

---

# 프로세스의 운영
## 프로세스 생성
- 프로세스를 만드는 프로세스 : a **parent** process
- 새로 생성된 프로세스 : a **child** process
- 프로세스가 프로세스를 생성하며 트리 구조로 프로세스들이 생성된다.

## 부모-자식 프로세스 실행
실행 방법 2가지
1. parent가 children과 동시에 실행된다.
2. parent가 children이 종료될 때까지 기다렸다가 종료되면 실행을 재개한다.

주소 할당 방법 2가지
1. child가 parent 프로세스를 복제한다.
2. child가 새로운 프로그램을 로드한다.

### 예제 코드
```c
int main() {
	pid_t pid;
	pid = fork();
	if (pid < 0) { 		// error
		fprintf(stderr, "Fork Failed");
		return 1;
	} else if (pid == 0) { 		// child process
		execlp("/bin/ls", "ls", NULL);
	} else { 		// parent process
		wait(NULL);
		printf("Child Complete");
	}
	return 0;
}
```

- `fork()` 명령어로 새로운 프로세스를 생성하고 pid를 return받음
- `pid == 0`인 경우, 즉 **자식** 프로세스인 경우 /bin/ls의 ls 명령어 실행
- `pid > 0`인 경우, 즉 **부모** 프로세스인 경우 `wait(NULL)`을 호출하고 printf 호출

위 코드를 실행하면 ls가 실행되고 printf문이 실행된다.

```bash
# 결과
a.out
main.c
Child Complete
```

- 코드 해석 참고
    - `pid < 0` 인 경우 에러
    - `execlp()` : PATH에 등록된 디렉토리를 참고하여 다른 프로그램을 실행하고 종료한다.
    인자로 파일 이름과 인수 리스트를 받는다.
    정확히는 실행 가능한 파일의 실행코드를 현재 프로세스에 적재하여 기존의 실행코드와 교체하고 새로운 기능으로 실행한다. 즉, 현재 실행되는 프로그램의 기능은 없어지고 파일의 프로그램을 메모리에 로드하여 처음부터 실행한다.
    - `wait()` : child 프로세스의 실행이 끝날 때까지 기다린다.
    

## 프로세스 종료

- 마지막 문장 실행(주로 return)
- exit() system call : OS에게 정보를 해제해달라고 요청

OS는 모든 리소스를 해제하고 회수한다.

### 좀비와 고아 프로세스

- 좀비 프로세스 : child 프로세스가 종료됐으나 parent 프로세스가 wait()을 호출하지 않은 상태
- 고아 프로세스 : parent 프로세스가 wait()을 호출하지 않고 종료된 상태

daemon, background process 등을 만들 때 활용한다.

## fork() in UNIX-like O/S

- `fork()` 명령어로 새로운 프로세스가 생성된다
- 자식 프로세스는 부모 프로세스의 주소공간의 복사본으로 구성된다.
- 두 프로세스 모두 `fork()` 시스템 콜 이후의 명령어부터 실행한다.
- 현재 프로세스가 자식 프로세스인 경우 fork()의 리턴 코드가 0이고, 부모 프로세스인 경우 os가 부여한 자식 프로세스의 실제 pid가 리턴된다.

### 예제 코드

```c
#include <stdio.h>
#include <unistd.h>

int main(void) {
	pid_t pid;
	pid = fork();
	printf("Hello, Process! %d\n", pid);
}
```

- `fork()` 문을 만나면 현재의 프로세스를 그대로 복제해서 자식 프로세스를 만든다.
- printf문을 실행하고 현재 프로세스가 종료되면, ready queue에 들어있던 자식 프로세스가 실행된다.
- 따라서 `Hello, Process!`라는 문장이 **2번** 찍히게 된다.
- pid는 순서대로 0이 아닌  숫자, 0이 찍히게 된다.

```bash
# 결과
Hello, Process! 28
Hello, Process! 0
```

만약 아래와 같이 `wait()`을 걸어주면 순서가 바뀌게 된다.

```c
// ...
if (pid > 0)
	wait(NULL);
printf("Hello, Process! %d\n", pid);
```

```bash
# 결과
Hello, Process! 0
Hello, Process! 27
```

### fork()가 호출된 후 일어나는 일

- 부모 프로세스는 실행을 계속한다.
- 혹은 자식 프로세스가 실행되는 동안 아무것도 할 것이 없다면, `wait()`을 호출해서 자식이 종료될 때까지 **자기 자신을 ready queue(에서 wait queue로)로 옮겨둘 수 있다.**
    - 자식이 종료되고 interrupt를 걸어주기를 기다림

## Reference
- 인프런 - 운영체제 공룡책 강의