# maven

## maven이 Java 8을 사용하도록 하는 방법

brew를 통해 maven을 설치했을 때 나타나는 현상 중 하나로, build를 시도하면 아래와 같은 에러가 뜬다.
```
[Error] Source option 5 is no longer supported. Use 7 or later.
[Error] Target option 5 is no longer supported. Use 7 or later.
```

maven이 Java 8 을 사용할 수 있도록 pom.xml에 명시해주어야 제대로 build가 되는 듯 하다.
두 가지 방법이 있다.

1. Maven Properties에 추가
```
<properties>
    <maven.compiler.target>1.8</maven.compiler.target>
    <maven.compiler.source>1.8</maven.compiler.source>
</properties>
```

2. Compiler Plugin 추가
```
<build>
    <plugins>
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-compiler-plugin</artifactId>
            <version>3.7.0</version>
            <configuration>
                <source>1.8</source>
                <target>1.8</target>
            </configuration>
        </plugin>
    </plugins>
</build>
```

<br>

## Reference 
<https://mkyong.com/maven/how-to-tell-maven-to-use-java-8/>