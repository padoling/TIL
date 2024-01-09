# Interprocess Communication(IPC)

- 프로세스들이 concurrent하게 실행되는 경우, 각각 독립적으로 실행되거나 상호작용하면서 실행됨
- 독립적으로 실행되는 경우
    - 데이터 공유 없음
- 상호작용하는 경우
    - 프로세스 간 서로 영향을 주고받음
    - 프로세스 간 데이터를 공유함

## IPC models

### shared memory
- 공유하는 메모리 영역에 데이터를 넣고 빼고 하는 방식

### message passing
- OS에게 데이터 공유를 맡기는 방식

---

# Shared-Memory System

## Producer-Consumer Problem
- producer가 정보를 생산하고 consumer가 정보를 소비하는 모델
    - 컴파일러(producer) → 어셈블리 코드 → 어셈블러(consumer)
    - 웹서버(producer) → HTML 파일 → 브라우저(consumer)
- producer와 consumer를 동시에 돌아가게(concurrently) 하기 위해 shared memory 사용
- **shared memory** : producer와 consumer 프로세스가 공유하는 메모리 영역
    - OS가 관리

### buffer

- producer는 버퍼에 뭔가를 채우고, consumer는 버퍼를 차례로 비움
- 대부분은 bounded buffer로 사이즈가 한정되어 있음.
    - 버퍼가 꽉 차면 producer는 wait
    - 버퍼가 비어있으면 consumer는 wait

**shared buffer 예제**

```c
#define BUFFER_SIZE 10

typedef struct {
	...
} item

item buffer[BUFFER_SIZE];
int in = 0;
int out = 0;
```

- in, out 포인터 모두 0으로 초기화 후 배열에 넣거나 빼면서 하나씩 증가
- 되도록 circular queue면 좋겠죠

**producer 예제**

```c
item next_produced;

while (true) {
	while (((in + 1) % BUFFER_SIZE) == out)
		; /* do nothing */
	buffer[in] = next_produced;
	in = (in + 1) % BUFFER_SIZE;
}
```

- `((in + 1) % BUFFER_SIZE) == out`인 동안, 즉 버퍼가 가득 찬 동안은 while문 돌며 기다린다

**consumer 예제**

```c
item next_consumed;

while (true) {
	while (in == out)
		; /* do nothing */
	next_consumed = buffer[out];
	out = (out + 1) % BUFFER_SIZE;
}
```

- `in == out`인 동안, 즉 버퍼가 비어있는 동안은 while문 돌며 기다린다.

## shared memory의 문제

- 메모리 영역을 공유하게 되면 애플리케이션 단에서 공유 메모리에 접근하고 쓰는 코드를 짜줘야 함
- 그러나 Prosumer - Prosumer 간 통신하는 방식과 같은 특수한 상황에서는 직접 만들어 관리할 수 있는 shared memory 방식이 필요함

---

# Message-Passing System

- OS가 프로세스 간 상호작용을 관리해주는 것

## Message-passing facility

- send(message)
- receive(message)

```c
message next_produced;

while (true) {
	send(next_produced);
}

message next_consumed;

while (true) {
	receive(next_consumed);
}
```

## Communication Links

- P → Q로 메시지를 보내고 받는 통신 방식. 복잡한 구현은 OS단에 숨겨져 있음
- 링크를 구현하는 방식
    - direct or indirect
    - synchronous or asynchronous
    - automatic or explicit buffering

### direct communication

- 각 프로세스가 통신할 때 발신자와 수신자를 명시하는 것
- `send(P, message)` - P 프로세스에 메세지를 보냄
- `receive(Q, message)` - Q 프로세스로부터 메세지를 받음
- 두 프로세스가 통신할 때 링크가 자동적으로 생성됨
- 링크는 두 프로세스 간 딱 하나만 있을 수 있음

### indirect communication

- **port**에 메세지를 보내고 수신함
    - port에 메세지를 두거나 port에서 메세지를 없앨 수 있음
- `send(A, message)` - port A로 메세지를 보냄
- `receive(A, message)` - port A로부터 메세지를 받음
- port를 이용할 때에만 링크가 생성됨
- 두개 이상의 프로세스 간에도 링크가 생길 수 있고, 여러 개의 port와 여러 개의 링크가 생길 수 있음
- OS는 새로운 port 생성, Send와 Receive 기능, port 삭제 기능을 제공함

### synchronous or asynchrounous

- Blocking send : 메세지를 전부 소비할 때까지 sender는 기다려야 함
- Non-blocking send : sender가 메세지를 보내놓고 자기 할 일 하는 것. 실제 buffer에 넣고 빼는 작업은 OS에서 알아서 해준다.
- Blocking receive : 메세지가 available해질 때까지 기다리는 것. 예를 들어 2기가짜리 데이터를 수신한다면 2기가를 전부 수신할 때까지 기다려야 함
- Non-blocking receive : receiver는 valid한 메세지나 null 메세지를 둘 다 받을 수 있다.
- 동기의 경우 끝날때까지 기다려야 하지만 작업이 완료됐음을 보장할 수 있음. 비동기는 반대

---

# Examples of IPC Systems

## POSIX Shared Memory

- POSIX : Portable Operating System Interface (for uniX)
    - IEEE에서 지정한 운영체제간 호환성을 유지하기 위한 표준
    - 운영체제의 표준화를 시도했던… 그래도 리눅스가 POSIX 표준을 따르고 있음
- **memory-mapped** file을 사용하여 버퍼(shared-memory) 영역을 잡음.
    - 겁나 빠르겠죠?
    1. create a shared-memory object
        
        ```c
        // parameter : 공유메모리 이름, open flag, 접근 권한
        // return : file descriptor(int)
        fd = shm_open(name, O_CREAT | ORDWR, 0666);
        ```
        
    2. Configure the size of the object in bytes
    shared memory의 크기 설정. 즉, read / write할 때 chunk의 크기 단위를 결정
        
        ```c
        // parameter : file descriptor, size of shared memory
        ftruncate(fd, 4096);
        ```
        
    3. establish a memory-mapped file
    memory-mapped file을 shared memory에 매핑
        
        ```c
        // parameter : *start, length, prot(메모리 보호모드), flag, fd, offset
        // fd로 지정된 파일에서 offset을 시작으로 length 바이트만큼 start 주소로 대응시키도록 한다.
        // 즉, 열린 memory-mapped file을 메모리에 대응시킨다.
        // return : 대응된 포인터(주소)
        mmap(0, SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
        ```
        
    
    ### Example Code
    
    ```c
    #include <stdio.h>
    #include <stdlib.h>
    #include <sstring.h>
    #include <fcntl.h>
    #include <sys/shm.h>
    #include <sys/stat.h>
    #include <sys/mman.h>
    
    // Write Code
    int main(void) {
        const int SIZE = 4096;
        const char *name = "OS";
        const char *message_0 = "Hello, ";
        const char *message_1 = "Shared Memory!\n";
        
        int shm_fd; // file descriptor of shared memory
        char *ptr;  // pointer to shared memory
        
        // create the shared memory object;
        shm_fd = shm_open(name, O_CREAT | ORDWR, 0666);
        
        // configure the size of the shared memory
        ftruncate(shm_fd, SIZE);
        
        // map the shared memory object
        ptr = (char *)mmap(0, SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, shm_fd, 0);
        
        // write to the shared memory
        // ptr에 메세지를 쓰고, message의 len 만큼 포인터를 옮긴다.
        sprintf(ptr, "%s", message_0);
        ptr += strlen(message_0);
        sprintf(ptr, "%s", message_1);
        ptr += strlen(message_1);
        
        return 0;
    }
    ```
    
    ```c
    // Read Code
    int main(void) {
        const int SIZE = 4096;
        const char *name = "OS";
    
        int shm_fd; // file descriptor of shared memory
        char *ptr;  // pointer to shared memory
    		
    		// Write 때와 같은 이름을 쓰면 같은 shared-memory 영역을 열어준다.
    		shm_fd = shm_open(name, O_RDDONLY, 0666);
        ptr = (char *)mmap(0, SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, shm_fd, 0);
    		// 그냥 해당 포인터를 읽어 출력하면 됨
        printf("%s", (char *)str);
    		// remove the shared memory
        shm_unlink(name);
        
        return 0;
    }
    ```
    

### 문제점

- 일일이 open, close, write 등을 해줘야 함

## Pipes

- Unix의 전통적인 IPC 구조
- 2개의 프로세스가 통신하는 도관처럼 행동한다.

### Issues

- unidirectional vs bidirectional
- in case of two-way comm., half-duplex vs full duplex?
    - 한 번에 하나씩, 동시에 여러 개?
    - 동시에 여러 개는 pipe를 여러 개 만들면 된다.
- relationship?
    - 두 프로세스 사이에 관계가 있어야 하는가? 예를 들면 parent-child
    - 구현의 편의상 관계를 가지도록 함
- pipes communicate over a network?
    - network에서 쓸 수 있는 파이프를 **socket**이라고 함

## Types of Pipes

### Ordinary Pipes(고전적인 형태)

- parent가 파이프를 만들면 반드시 child와 통신하기 위해 사용한다.
- producer-consumer 형태로 양방향 통신이 가능함
    - producer가 한쪽 끝에서 쓰고, consumer가 다른 쪽 끝에서 읽는다.

```c
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>

#define BUFFER_SIZE 25
#define READ_END 0
#define WRITE_END 1

int main(void) {
    char write_msg[BUFFER_SIZE] = "Greetings";
    char read_msg[BUFFER_SIZE];
    int fd[2];  // size : read 1, write 1
    pid_t pid;
    
    // create a pipe
    pipe(fd);
    
	// fork new process
    pid = fork();
    
    if (pid > 0) {  // parent process
        close(fd[READ_END]);
        write(fd[WRITE_END], write_msg, strlen(write_msg) + 1);
        close(fd[WRITE_END]);
    } else if (pid == 0) {  // child process
        close(fd[WRITE_END]);
        read(fd[READ_END], read_msg, BUFFER_SIZE);
        printf("read %s\n", read_msg);
        close(fd[READ_END]);
    }
    
    return 0;
}
```

- 궁금증 - 무조건 parent → child 순으로 실행되나? 어떻게 무조건 parent가 적은 것을 child가 읽을 수 있게 되는 걸까?
    - pipe() 함수는 2개의 스트림을 여는 함수이다. pipe()의 결과 만들어진 디스크립터는 fd[0], fd[1]에 각각 할당되고, 한쪽 스트림에 쓴 데이터는 다른 쪽 스트림에서 바로 읽을 수 있다.
    - 파이프는 언제나 한 방향으로만 작동한다. 부모 자식 간 양쪽으로 데이터를 보내려면 파이프를 두 개 만들어야 한다.

### Named Pipes

- 여러 개의 파이프를 두고 파이프에 이름을 붙이는 것
- parent-child relationship이 없어도 쓸 수 있음 → 좀 고도화된 파이프

---

# Client-Server Systems

## Socket

- remote computer과의 통신을 위한 endpoints.
- IP Address : 컴퓨터를 특정할 수 있는 주소
- Port : 컴퓨터 간 연결된 파이프
- Socket : IP Address + Port. (ex. https://www.google.com:80)

## RPCs(Remote Procedure Calls)

- 네트워크 시스템 상의 프로세스들 사이의 원격 호출을 추상화한 것
    - 즉, 원격 컴퓨터에 있는 함수를 호출하는 것
- Java에서는 RMI(Remote Method Invocation)로 구현함
- 클라이언트는 로컬에서 프로시저를 호출하듯이 remote host에 있는 프로시저를 호출함
- **stub**을 제공함으로써 통신이 이루어지게 하는 디테일을 숨김
    - ex. little endian이냐, serialization이 어떻게 되냐,,,
    - marshals : 원격 서비스를 이용하는 데 필요한 데이터를 정리하는 것. marshaling한 객체를 주고받음.

### stub

- 클라이언트와 서버 간 통신을 추상화하고 단순화하는 데 사용하는 코드 조각
- 클라이언트와 서버 모두에 존재
- client-side : 파라미터들을 marshaling하여 서버에 네트워크 프로토콜을 이용해 전송함
- server-side : 클라이언트로부터 데이터를 받아 unmarshaling하고, 프로시저를 호출하고 반환값을 다시 marshaling하여 클라이언트로 전송함
    - server stub은 skeleton이라는 용어로도 쓰임.

## Java sockets

- `Socket` : connection-oriented(**TCP**)
- `DatagramSocket` : connectionless(**UDP**). broadcasting
- `MulticastSocket` : multiple recipients. broadcast하긴 하나, 특정 recipients에게만 주겠다.

### Server Socket example

```java
import java.net.*;
import java.io.*;

class DateServer {
    public static void main(String[] args) throws Exception {
        // create server new socket. port 번호는 6013
        // listens to client request
        ServerSocket server = new ServerSocket(6013);
        
        while (true) {
            // 연결이 수용되면(즉, 클라이언트가 연결되면) Socket 객체를 반환한다.
            Socket client = server.accept();
            
            // write the Date to the socket
            PrintWriter pout = new PrintWriter(client.getOutputStream(), true);
            pout.println(new java.util.Date().toString());
            
            // close the socket and resume listening for connections
            client.close();
        }
    }
}
```

- `server.accept()`의 결과로 반환되는 Socket은 새로운 소켓이다. 즉, 새로운 포트번호를 갖는다. 클라이언트와 동일하다.
- 따라서 이론상 동접 가능한 클라이언트 수는 포트 수로 한정된다.

### Client Socket example

```java
import java.net.*;
import java.io.*;

class DateClient {
    public static void main(String[] args) throws Exception {
        // create new socket
        Socket socket = new Socket("127.0.0.1", 6013);
        
        InputStream in = socket.getInputStream();
        BufferedReader br = new BufferedReader(new InputStreamReader(in));
        
        String line = null;
        while ((line = br.readLine()) != null)
            System.out.println(line);
            
        socket.close();
    }
}
```

## Reference
- 인프런 - 운영체제 공룡책 강의