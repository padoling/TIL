# AWS Lambda

## Lambda란?
* FaaS(Function as a Service)의 일종으로, 서버의 스펙을 고려하지 않고 **함수 단위로 로직을 실행**시킬 수 있도록 해주는 서비스
* ``트리거``라는 시스템이 있어 특정 조건을 만족하는 경우에만 Lambda가 실행되며, **실행되는 시간 동안에만 요금이 부과됨**  
ex) S3 버킷에 파일 업로드
* 프로비저닝, 관리, 오토 스케일링 등이 자동화되어 있음

### 장점
* 서버의 사양, 개수, 보안, 로깅 등이 알아서 조절되기 때문에 서버에 대한 걱정 없이 백엔드 로직 개발에 집중할 수 있음
* Serverless 아키텍쳐를 구현할 때 사용할 수 있음

<br>

## Spring boot에서 lambda 사용하기
Baeldung의 튜토리얼 참고함 : 
<https://www.baeldung.com/java-aws-lambda>

### 1. Maven Dependencies 추가
먼저 lambda 사용을 위한 aws dependency를 추가한다.
```xml
<dependency>
	<groupId>com.amazonaws</groupId>
	<artifactId>aws-lambda-java-core</artifactId>
	<version>1.1.0</version>
</dependency>
```
다음으로 lambda application을 빌드하기 위해 maven shade plugin을 추가한다.
```xml
<plugin>
	<groupId>org.apache.maven.plugins</groupId>
	<artifactId>maven-shade-plugin</artifactId>
	<version>2.4.3</version>
	<configuration>
		<createDependencyReducedPom>false</createDependencyReducedPom>
	</configuration>
	<executions>
		<execution>
			<phase>package</phase>
			<goals>
				<goal>shade</goal>
			</goals>
		</execution>
	</executions>
</plugin>
```

### 2. Handler 생성
요청을 받아들이고 lambda의 함수를 불러오기 위한 handler를 생성해야 한다. Baeldung의 튜토리얼에는 handler를 만들 수 있는 3가지 방법이 소개되어 있는데, 그 중에서 나는 RequestHandler 인터페이스를 구현하는 방법을 선택했다. 
```java
public class LambdaRequestHandler implements RequestHandler<String, String> {
	public String handleRequest(String input, Context context) {
		context.getLogger().log("Input: " + input);
		return "Hello World - " + input;
	}
}
```

### 3. 빌드하기
maven shade를 이용해 다음 명령어로 빌드하면, target 폴더에 jar 파일이 생성된다.
```terminal
$ mvn clean package shade:shade
```

### 4. lambda 함수 생성
AWS 콘솔에서 lambda 함수를 생성한다. 생성 방법은 다음과 같다.  
1) `서비스 > lambda` 선택 후 대시보드에서 `함수 생성` 선택  
2) `새로 작성` 옵션을 선택하고 런타임을 원하는 언어로 설정(여기서는 Java 8)  
![Lambda Tutorial 1](/img/lambda_tutorial_1.png)  
3) 생성한 함수의 `함수 코드` 탭에서 핸들러를 방금 만든 핸들러 메소드로 설정해 주고, 함수 패키지에 **jar 파일을 업로드**  
![Lambda Tutorial 2](/img/lambda_tutorial_2.png)  
트리거를 추가하거나 다양한 설정을 변경할 수도 있으나, 튜토리얼이기 때문에 아주 간단하게만 설정하였다.

### 테스트
함수 탭의 상단에 있는 `테스트` 버튼을 눌러서 input값을 설정하고 람다 함수를 테스트해볼 수 있다. 테스트의 성공/실패 여부에 관계 없이 상세한 실행 정보와 로그를 확인할 수 있다.  
![Lambda Tutorial 3](/img/lambda_tutorial_3.png)  

<br>

## Reference
* <https://velopert.com/3543>
* <https://docs.aws.amazon.com/ko_kr/lambda/latest/dg/welcome.html>