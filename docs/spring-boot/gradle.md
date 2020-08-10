# gradle

## buildscript
build.gradle 파일을 작성할 때, repositories나 dependencies를 그냥 선언할 때도 있지만 `buildscript{}` 안에 선언할 때도 있다. 예를 들면 다음과 같다.
```groovy
//buildscript 내부에 선언
buildscript {
    repositories {
        maven { url("https://plugins.gradle.org/m2/") }
    }

    dependencies {
        classpath 'net.saliman:gradle-cobertura-plugin:2.3.2'
        classpath 'com.netflix.nebula:gradle-lint-plugin:latest.release'
    }
}

//root level로 선언
repositories{
    mavenLocal()
    maven { url("https://plugins.gradle.org/m2/") }
    maven { url "https://repo.spring.io/snapshot" }
}

dependencies {
    //Groovy
    compile group: 'org.codehaus.groovy', name: 'groovy-all', version: '2.3.10'

    //Spock Test
    compile group: 'org.spockframework', name: 'spock-core', version: '1.0-groovy-2.3'

    //Test
    testCompile group: 'junit', name: 'junit', version: '4.10'
    testCompile group: 'org.testng', name: 'testng', version: '6.8.5'
}
```

### buildscript 내부에 선언
* Project external dependency
* buildscript process 자체에 사용되는 dependencies만 컨트롤함
* application code에서는 참조되지 않음

### root level로 선언
* For project dependency
* 프로젝트의 컴파일이나 테스트 시에 사용되는 dependencies

<br>

## Reference
<https://stackoverflow.com/questions/13923766/gradle-buildscript-dependencies>