# aws_lambda_docker_test

- 개요
  - [AWS Lambda의 새로운 기능 — 컨테이너 이미지 지원](https://aws.amazon.com/ko/blogs/korea/new-for-aws-lambda-container-image-support/) 을 테스트하기 위해 만듬

* docker image build

  ```bash
  $ docker build -t random-letter .
  ```

* 로컬 테스트를 위해서 실행

  ```bash
  $ docker run -p 9000:8080 random-letter:latest
  ```

* curl 로 함수 호출

  ```bash
  $ curl -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{}'

  ```

* aws 설정이 안되어 있다면 아래처럼 설정 필요 이 과장에서 IAM 사용자 키를 AWS 콘솔에서 발급 받아야 할 것임.

  ```bash
  aws configure
  # region : ap-northeast-2 (서울)
  ```

* aws에 컨테니어 등록

  ```
  $ aws ecr create-repository --repository-name random-letter --image-scanning-configuration scanOnPush=true
  # 바로 위에서 나온 repositoryUri 를 아래에 적용
  $ docker tag random-letter:latest {my_repository_url}/random-letter:latest
  $ docker tag random-letter:latest 430116444406.dkr.ecr.ap-northeast-2.amazonaws.com/random-letter:latest
  $ aws ecr get-login-password | docker login --username AWS --password-stdin 430116444406.dkr.ecr.ap-northeast-2.amazonaws.comㄴ
  $ docker push  :latest
  ```

* AWS ECR repositories 에 가서 해당 repository를 고르고 Lifecycle Policy를 설정

  - Rule priority : 1
  - Rule description : Remove old images
  - Image Status : Untagged
  - Image count more than : 1
  - 위와 같이 하면 unstaged 된 파일은 1개만 남게 된다.
  - 이 규칙은 바로 실행은 안되고 시간을 1~~2시간 기다려야 한다고 한다.
  - 아니면 아래와 같은 명령어로도 될 수 있음
