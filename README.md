# E-Heart App

## Getting Started

项目的目录结构进行了一次初步重构。

* /lib/models 用于存放数据模型
* /lib/services 用于处理服务接口和实现
* /lib/provider 用于处理响应式数据

### 推荐插件

* Json To Dart Model： 用于将接口返回的响应JSON，直接自动生成带fromJson、toJson、toString方法的Dart class。

### 模型生成

在VSCode 中使用Json To Dart 插件，直接将接口的响应转换成dart class，命名后存放在/lib/models 目录下。

* **user**
* **user_progress**

### 接口请求

项目中使用的Dio 作为网络请求库。基于Dio 进行封装，以处理接口请求，Token更新等操作。

在项目中可以直接于代码中使用 lib/services/dio_client.dart 里对应的getRequest 和postRequest 来处理接口。

建议的做法是在service/api_service.dart 的抽象类中创建需要的接口，在对应的service 文件中去实现接口。

### 状态管理

目前使用provider 做响应式的状态管理。目前实现的功能有用户信息的provider。

### 问卷提交

## Build & Release
