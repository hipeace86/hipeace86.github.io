---
layout: post
title:  Docker alpine 编译go项目运行失败分析
date:   2019-04-28 10:10:49
categories: Golang
tags: Golang
---

# 0x01 gitlab-ci 配置

``` yaml
image: golang:1.12-alpine

variables:
  REPO_NAME: 91python.com/x/xxx

before_script:
  - mkdir -p $GOPATH/src/$(dirname $REPO_NAME)
  - ln -svf $CI_PROJECT_DIR $GOPATH/src/$REPO_NAME
  - cd $GOPATH/src/$REPO_NAME

stages:
  - test
  - build
  - deploy

format:
  stage: test
  script:
    - go fmt $(go list ./... | grep -v /vendor/)

build:linux:
  stage: build
  script:
    - sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
    - apk add gcc libc-dev
    - GOOS=linux GOARCH=amd64 go build -o $CI_PROJECT_DIR/xxx-linux
  artifacts:
    paths:
      - xxx-linux
    expire_in: 1 week
    
deploy_stage:
  stage: deploy
  dependencies:
    - build:linux
  script:
    - 'which ssh-agent || (apk add openssh-client)'
    - eval $(ssh-agent -s)
    - echo "$SSH_PRIVATE_KEY" | tr -d '\r' | ssh-add - > /dev/null
    - mkdir -p ~/.ssh
    - chmod 700 ~/.ssh
    - echo -e "Host *\\n\\tStrictHostKeyChecking no\\n\\n" > ~/.ssh/config
    - ssh root@$DEPLOY_SERVER "circusctl stop go-api"
    - scp $CI_PROJECT_DIR/xxx-linux root@$DEPLOY_SERVER:/data/www/go-api/xxx
    - ssh root@$DEPLOY_SERVER "circusctl start go-api"
```

# 0x02 发布后问题

文件发布后发现`circus`监控的进程启动失败，直接运行文件会出现**`no such file or directory`** 错误；而在机器上直接运行go build是可以直接运行的。

## 0x0201 文件对比

* 物理机编译

``` shell
GOOS=linux GOARCH=amd64 go build
file xxx
xxx: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), statically linked, not stripped
```

* Docker 容器编译

``` shell
GOOS=linux GOARCH=amd64 go build
  file xxx
  xxx: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib/ld-musl-x86_64.so.1, not stripped
```

一个是静态链接，一个是动态链接，动态链接的在微型镜像alpine上不支持

  # 0x03 总结

1. 默认go使用静态链接，在docker的golang环境中默认是使用动态编译。
2. 如果想使用docker编译+alpine部署，可以通过禁用cgo`CGO_ENABLED=0`来解决。
3. 如果要使用cgo可以通过`go build --ldflags "-extldflags -static"` 来让gcc使用静态编译。

``` yaml
build:linux:
  stage: build
  script:
    - sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
    - apk add gcc libc-dev
    - GOOS=linux GOARCH=amd64 go build --ldflags "-extldflags -static" -o $CI_PROJECT_DIR/xxx-linux
  artifacts:
    paths:
      - xxx-linux
    expire_in: 1 week
```

所以只要把gitlab-ci里的`build-linux` 里的build做如上修改，加上编译参数即可！