# mybatis

## xml로 mybatis mapper 설정하기
spring boot에서 mybatis를 사용할 경우 resource 폴더 안에 xml 파일들을 구현해 mapper를 설정할 수 있다.
먼저 맨 위에 다음 태그들을 써준다.
```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
  "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
```
가장 상위에는 `<mapper namespace="mapperName"></mapper>`이 있어야 한다.

### INSERT문 예시
```xml
<insert id="insertId" parameterType="string">
    INSERT INTO TableA
    FROM TableB
    ...
</insert>
```
* insert문에는 파라미터값이 필요하므로 `parameterType`을 지정해줘야 한다.

### SELECT문 예시
```xml
<select id="selectId" parameterType="string" resultType="Integer">
    SELECT id
    FROM TableA
    WHERE ...
</select>
```
* select문에는 `parameterType`뿐만 아니라 `resultType`도 필요하므로, 꼭 타입을 정확하게 지정해주자.