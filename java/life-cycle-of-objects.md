# 객체 생명주기(Life Cycle of Objects)

## 생명주기란?
생명주기(life cycle)란 문자 그대로 어떤 생명이 탄생하고 죽어서 소멸하기까지의 과정을 의미하는 말이다. Java의 객체도 생명...이라고 본다면 객체가 생성되고, 사용되고, 더 이상 사용될 수 없게 되어 소멸할 때까지 일련의 과정을 생명주기라고 할 수 있다.  

Java 객체의 생명주기는 보통 7단계로 구분된다.

![cycle](/img/life_cycle_of_objects.JPG)  

일반적으로 개발할 때 이 모든 단계를 고려하지는 않지만, 어쨌든 객체는 이와 같은 7단계의 생명주기를 거쳐가게 된다. 생명주기의 모든 단계를 잘 이해하면 버그와 메모리 누수가 더 적은 코드를 쓸 수 있게 된다고 한다. Java에 대한 기본적인 이해가 된 상태라면 그렇게 어렵지 않은 내용이니 한 번 읽고 익혀보는 것도 나쁘지 않은 듯 하다.

<br>

## 생명주기 단계
### Created(생성)
객체를 위한 메모리가 할당되고, 생성자가 호출되어 내장변수가 초기화되는 단계이다. 메모리는 JVM의 `heap`에 할당되어 존재한다.
### In Use(사용 중)
객체가 다른 객체에 의해 참조되어 사용 중인 상태이다. 이러한 참조를 **strong reference**라고 하는데, strongly referenced된 객체에는 `가비지 컬렉터(Garbage Collector, GC)`가 접근할 수 없다.
### Invisible(비가시적)
이 단계는 모든 객체가 거쳐가지는 않는다. 이 상태의 객체는 strongly referenced된 상태이지만 접근할 수 없다. 무슨 말인가 싶은데, 아래 코드를 살펴보자.
```java
public void run() {
    try {
        Object obj = new Object();
    } catch(Exception e) {
        e.printStackTrace();
    }

    while(true) {
        //.........
    }
}
```
위 코드에서 객체 obj는 'new Object()'구문으로 생성된 어떤 객체에 의해 참조되고 있는 상태, 즉 strongly referenced된 상태이다. 그러나 while문이 실행되면서, 프로그램이 종료될 때까지 객체 obj에 접근할 수 없으므로 말 그대로 invisible한 객체가 된다. 그렇다면 obj는 try문 안에서 생성되고 사용된 이후로 전혀 사용되지 않으므로 GC에 의해 소멸하는 것이 효율적이겠지만, strongly referenced된 상태가 그대로 유지되기 때문에 GC는 obj에 접근할 수 없다. 결국 obj는 계속해서 메모리의 한 부분을 차지한 채로 남아있는 것이다.
### Unreachable(접근 불가)
객체를 참조하고 있는 다른 객체가 존재하지 않아서 접근할 수 없는 상태이다. 즉, Strong reference가 존재하지 않는 상태이다. 대표적으로 아래와 같이 null값을 할당한 경우 그 객체는 Unreachable 단계가 된다. 이러한 상태의 객체는 GC의 후보가 되어 **GC 대상 Queue**에 들어간다.
```java
Object obj = new Object();
obj = null;
```
### Collected(수거됨...?)
메모리 해제 이전의 상태로, 객체가 Unreachable 상태에 이른 뒤 GC의 대상이 된 상태이다. 만일 해당 객체에 finalize 메소드가 있으면 **finalizer Queue**에 들어가고, finalize 메소드가 없다면 바로 다음 단계인 finalized 단계로 넘어간다.  
만약 finalize 메소드가 있으면 객체를 소멸하는 단계에서 추가적인 딜레이가 발생한다는 것이므로 finalize 메소드를 쓰는 것에 주의를 기울이는 것이 좋을 것 같다.
### Finalized(소멸)
finalize 메소드가 실행된 후의 상태이다. finalizer 메소드를 가진 객체의 경우 queue에 들어가 순서대로 소멸되는데, 소멸하는 때는 GC 마음대로 결정되기 때문에 소멸되기 전까지는 메모리를 차지하고 있게 된다.
### Deallocated(메모리 해제)
객체에 할당되었던 메모리가 해제된 단계로, 가비지 컬렉션의 마지막 단계이다.

<br>

## Reference
<https://himanshugpt.wordpress.com/2010/03/17/life-cycle-of-java-object/>
