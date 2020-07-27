# CodeDeploy

## EC2에서 CodeDeploy를 사용하여 배포 자동화하기

### CodeDeploy 시작하기
1. IAM 사용자 셋팅
  * EC2에서 AWS CLI를 사용할 수 있도록 IAM 사용자를 생성하고, CodeDeploy와 CodeDeploy에서 사용하는 서비스에 액세스할 권한 부여
  * 예시
    ```json
    {
    "Version": "2012-10-17",
    "Statement" : [
        {
        "Effect" : "Allow",
        "Action" : [
            "autoscaling:*",
            "codedeploy:*",
            "ec2:*",
            "lambda:*",
            "ecs:*",
            "elasticloadbalancing:*",
            "iam:AddRoleToInstanceProfile",
            "iam:CreateInstanceProfile",
            "iam:CreateRole",
            "iam:DeleteInstanceProfile",
            "iam:DeleteRole",
            "iam:DeleteRolePolicy",
            "iam:GetInstanceProfile",
            "iam:GetRole",
            "iam:GetRolePolicy",
            "iam:ListInstanceProfilesForRole",
            "iam:ListRolePolicies",
            "iam:ListRoles",
            "iam:PassRole",
            "iam:PutRolePolicy",
            "iam:RemoveRoleFromInstanceProfile", 
            "s3:*"
        ],
        "Resource" : "*"
        }    
      ]
    }
      ```
2. EC2에 AWS CLI 설치
    * CodeDeploy를 호출하기 위해서 AWS CLI가 필요함(CLI 1.6.1 버전부터 사용 가능)
    * CLI 구성시 1번에서 만든 IAM 사용자의 key 사용
3. IAM 역할 만들기
    * EC2와 CodeDeploy 둘 다 서로에게 접근하기 위한 권한이 필요함
    * EC2에는 S3와 CodeDeploy에 접근할 수 있는 정책을, CodeDeploy에는 EC2에 접근할 수 있는 정책을 부여함
        * 예시) CodeDeploy에는 `AWSCodeDeployRoleForECS` 정책 부여, EC2에는 `AmazonEC2RoleforAWSCodeDeploy` 정책 부여
    * EC2 인스턴스에 생성한 IAM 역할 연결(CodeDeploy에는 배포 그룹 생성하면서 연결)
4. EC2에 CodeDeploy agent 설치
    * CodeDeploy의 요청을 받기 위함
    * EC2에서 다음 명령어 입력
        ```bash
        $ aws s3 cp s3://aws-codedeploy-ap-northeast-2/latest/install . --region ap-northeast-2
        ```

### CodeDeploy 생성
1. 애플리케이션 생성
    * 애플리케이션 이름과 컴퓨팅 플랫폼 선택
    * EC2 서버에 배포하고 싶은 경우 `EC2/온프레미스` 선택
2. 배포 그룹 생성
    * 배포 중 사용되는 설정과 구성을 포함
    * 서비스 역할 : 미리 만들어두었던 CodeDeploy용 IAM 역할 선택
    * 배포 유형 : 현재 위치 & 블루/그린 중 선택
    * **현재 위치**
        * 현재 인스턴스 그룹의 위치에서 배포를 진행하는 방식. 배포가 진행되는 동안에는 인스턴스가 중단되기 때문에 한번에 몇 개의 인스턴스를 배포할지 결정하는 것이 중요함.
        * 환경 구성 : 배포에 포함할 인스턴스 또는 Auto Scaling 그룹들을 선택할 수 있음
        * 배포 설정 - 배포 구성
            * `CodeDeployDefault.OneAtATime` : 한번에 하나씩 배포
            * `CodeDeployDefault.HalfAtATime` : 한번에 절반 배포
            * `CodeDeployDefault.AllAtOnce` : 한번에 전부 배포
            * `배포 구성 만들기` : 한번에 배포할 인스턴스 개수를 커스터마이징할 수 있음
        * 로드 밸런서 : 활성화하거나 비활성화할 수 있음. 배포 구성에 따라 순차적으로 트래픽과 인스턴스와의 연결을 끊고, 배포와 Health Check가 전부 진행된 뒤 다시 연결시킴.
    * **블루/그린**
        * 인스턴스 그룹 상태를 복제한 또 다른 그룹을 만들어 배포를 진행하고, 배포가 성공하면 해당 그룹에 로드밸런서를 연결하는 방식. 더 안전한 배포 방식이지만 비용이 더 많이 부과됨.
        * 환경 구성
            * `Amazon EC2 Auto Scaling 그룹 자동 복사` : 지정한 Auto Scaling 그룹을 프로비저닝하고 자동으로 배포하는 방식
            * `인스턴스 수동 프로비저닝` : 배포에 포함할 인스턴스 또는 Auto Scaling 그룹을 지정하는 방식
        * 배포 설정
            * 트래픽 라우팅 : 대체 환경에서 배포 성공 후 트래픽을 라우팅하는 방식 결정. 즉시 라우팅하도록 할 수도 있고 시간을 두고 라우팅하도록 할 수도 있음.
            * 배포에 성공한 다음 원본 환경의 인스턴스를 종료할지 여부 / 대기 시간
            * 배포 구성 : 현재 위치의 배포 구성과 같음.
        - 로드 밸런서 : 무조건 활성화되어 있어야 함.

### appspec.yml
- CodeDeploy 설정을 담은 파일. 배포할 압축 파일에 포함되어 있어야 함.
- 예시
    ```yaml
    # CodeDeploy 버전
    version: 0.0
    os: linux
    files:
        #revision 폴더의 루트에서 시작하는 상대 경로
      - source: /
        # 배포될 위치. source에서 지정한 파일들이 복사될 위치.
        destination: /var/www/html/WordPress
    # 배포 단계별로 진행되어야 할 이벤트 명시
    hooks:
    BeforeInstall:
        # 실행될 이벤트가 적힌 스크립트 위치
      - location: scripts/install_dependencies.sh
        # 스크립트 실행에 허용되는 최대 시간
        timeout: 300
        # 스크립트 실행할 사용자
        runas: root
    AfterInstall:
      - location: scripts/change_permissions.sh
        timeout: 300
        runas: root
    ApplicationStart:
      - location: scripts/start_server.sh
      - location: scripts/create_test_db.sh
        timeout: 300
        runas: root
    ApplicationStop:
      - location: scripts/stop_server.sh
        timeout: 300
        runas: root
    ```

<br>

## Reference
<https://docs.aws.amazon.com/ko_kr/codedeploy/latest/userguide/welcome.html>