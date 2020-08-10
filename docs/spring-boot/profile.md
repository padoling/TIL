# profile 설정
spring boot에서는 실행 및 빌드 시 dev 환경과 prod 환경 등을 구분하기 위해 profile을 설정할 수 있다.
gradle과 intelliJ 환경에서는 다음과 같이 구성할 수 있다.

## 파일 구성
먼저 resource의 application.properties를 환경별로 나눈다. 아래와 같이 `resources-'환경이름'`으로 폴더를 만들어 각각 설정파일을 넣어준다.
```
+ src
    + main
        + java
            + package
                - Application.java
        + resources
            + static
            + templates
            - application.properties
        + resources-dev
            - application-dev.properties
        + resources-prod
            - application-prod.properties
        ...
```
* `resources`에는 공통적으로 쓰이는 파일 및 설정들을 넣어준다. 여기서 `application.properties`는 dev와 prod 환경에서 공통적으로 사용될 설정들을 담는 파일이다.
* 같은 파일명의 `application.properties` 파일이 여러 개 존재한다면 마지막에 명시된 하나만 사용하기 때문에, 각 환경에 따라 이름을 다르게 만들어주어야 한다.

<br>

## ❕Spring profile과 Gradle profile의 차이

### Spring profile
* 빌드한 결과 안에서 스프링이 어떤 profile을 사용할지 결정
* 런타임 프로파일 설정

### Gradle profile
* 빌드할 때 어떤 profile을 리소스에 포함시킬지 결정
* 빌드타임 프로파일 설정

<br>

## build.gradle 설정
build.gradle에서는 Gradle profile을 설정할 수 있다. Gradle profile은 폴더 단위로 지정되는 듯 하다. 아래와 같이 `profile` 값을 받아서 그에 맞게 resources 폴더의 경로를 지정하는 스크립트를 추가해준다.
```groovy
ext.profile = (!project.hasProperty('profile') || !profile) ? 'dev' : profile

sourceSets {
    main {
        resources {
            srcDirs "src/main/resources", "src/main/resources-${profile}"
        }
    }
}
```
* 만약 profile 값으로 'prod'가 들어왔다면 resources 폴더로 `src/main/resources`와 더불어 `src/main/resources-prod` 폴더를 참고하기 될 것이다.

<br>

## 실행하기

### CLI 사용(Gradlew)
prod 환경으로 실행할 경우 프로젝트 루트 경로에서 CLI에 다음과 같이 입력해준다.
```shell
SPRING_PROFILES_ACTIVE=prod ./gradlew clean bootRun -Pprofile=prod
```
* `SPRING_PROFILES_ACTIVE=prod` : Spring profile이 prod임을 의미한다. 스프링은 profile이 prod인 설정파일, 즉 application-prod.properties가 있는지 찾아서 있다면 적용시킨다.
* `./gradlew clean bootRun` : gradlew로 gradle task를 시작한다. 여기서는 clean과 bootRun을 실행하도록 명령하였다.
* `-Pprofile=prod` : Gradle proifle이 prod임을 명시한다. build.gradle에서 설정했듯이 resources-prod 폴더의 파일들을 불러온다.

### IntelliJ 설정 사용
* 위쪽 실행 버튼이 있는 바의 `Edit Configurations...`를 선택한다.
* `Add new Configuration`에서 Gradle을 선택하여 Run/Debug 환경을 구성할 수 있다.
![spring boot profile 1](/img/spring_boot_profile_1.png)
    * Gradle project : gradle로 빌드할 프로젝트를 넣어준다.
    * Tasks : gradle task를 지정한다.
    * Arguments : Gradle profile을 지정할 때 사용할 argument를 넣어준다.
    * Environemnt variables : Spring profile을 지정할 때 사용할 환경변수를 넣어준다.
    * Before launch : 위에 설정한 task를 수행하기 전에 할 일을 설정한다. 여기서는 clean task를 수행하도록 설정하였다.
* profile별로 위와 같이 설정한 후 IntelliJ의 UI에서 때에 따라 다른 구성으로 실행할 수 있다.

<br>

## ❕주의할 점
* `application.properties`와 `application-xxx.properties`가 있으면 항상 `application-xxx.properties`가 더 늦게 로드된다. 
* 더 늦게 로드된다는 것은 **먼저 로드된 파일을 overwrite한다**는 의미이다. 
* 일반적으로 profile이 설정된 파일이 공통 파일을 overwrite하는 것이 좋을테니 공통 파일을 기본적인 `application.properties`라는 이름으로 만드는 것이 나을 것이다.

<br>

## Reference
* <https://perfectacle.github.io/2017/09/23/Spring-boot-gradle-profile/>
* <https://umbum.dev/1039>