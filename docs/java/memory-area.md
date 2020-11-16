# Java Memory Area

## 메소드 영역(Method Area)
* 클래스 생성자, 클래스의 인스턴스 변수, 메소드의 바이트코드 등이 저장됨
* 메소드가 실행되는 시점에 클래스 정보가 메소드 영역이 저장됨

<br>

## 스택 영역(Stack Area)
* 특정 메소드에서 사용되는 원시 타입 변수(primitive values)나 힙 영역에 저장된 객체를 가리키는 reference들이 저장됨
* 스택 구조이므로 LIFO(Last-In-First-Out)임
* 메소드가 호출될 때 스택 영역에 저장될 변수들이 스택에 올라가고, 메소드의 실행이 끝나면 해당 스택 프레임이 스택 영역에서 제거됨
* 스택 영역이 꽉 차면 `StackOverFlowError`가 뜬다!!
* 스레드 별로 각자의 스택을 가지기 때문에 threadsafe함

<br>

## 힙 영역(Heap Area)
* 동적 메모리 할당이 이루어짐
* 이 메모리들은 어디에서든 접근 가능하지만, 해당 메모리에 대한 reference는 스택 영역에 저장되기 때문에 결국 스택 영역을 관리해줘야 하는 듯,,,
* 힙 영역이 꽉 차면 `OutOfMemoryError`가 뜬다!
* 사용되지 않은 시점에 자동으로 제거되지 않고 GC에 의해 수집되어야만 할당 해제됨
* threadsafe하지 않으므로 적절하게 동기화해주어야 함

<br>

## Reference
* <https://www.baeldung.com/java-stack-heap>
* <https://mirinae312.github.io/develop/2018/06/04/jvm_memory.html>
* <https://www.holaxprogramming.com/2013/07/16/java-jvm-runtime-data-area/>