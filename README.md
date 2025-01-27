# E-Heart App

## Getting Started

### 开发须知

项目的目录结构进行了一次初步重构。

* /lib/models 用于存放数据模型
* /lib/services 用于处理服务接口和实现
* /lib/provider 用于处理响应式数据

### 项目运行

1. 配置fvm环境，指定flutter执行版本 3.19.5
2. 使用VSCode 进行开发，安装Flutter 相关插件
3. 安卓模拟器/真机调试：

* 将设备调整至开发者模式，通过adb 连接到开发设备中
* 配置launch.json,指定好设备调试ID信息和模式
* 启动launch 模式

4. 苹果设备调试：

* 配置好launch.json，指定模拟器或者真机
* 需要使用mac设备，用XCode打开/ios/Runnner.xcodeproj 或者/ios/Runner.xcworkspace,并运行

### 推荐插件

* Json To Dart Model： 用于将接口返回的响应JSON，直接自动生成带fromJson、toJson、toString方法的Dart class。
* build runner: 用于一键生成model相关的操作代码。

### 模型生成

在VSCode 中使用Json To Dart 插件，直接将接口的响应转换成dart class，命名后存放在/lib/models 目录下。
在项目中使用@JsonSerializable 生成所需的toJson 和fromJson 方法。

* **user**
* **user_progress**

### 接口请求

项目中使用的Dio 作为网络请求库。基于Dio 进行封装，以处理接口请求，Token更新等操作。

在项目中可以直接于代码中使用 lib/services/dio_client.dart 里对应的getRequest 和postRequest 来处理接口。

建议的做法是在service/api_service.dart 的抽象类中创建需要的接口，在对应的service 文件中去实现接口。

### 状态管理

目前使用provider 做响应式的状态管理。目前实现的功能有用户信息的user provider和用户进度相关的progress provider。

### 问卷提交

问卷提交的相关处理接口放在/lib/survey/utils.dart 下处理，根据taskId 来执行不同的问卷内容变量抽取和接口。

## Build & Release

TODO
希望采用项目里的GitHub Actions 处理。使用/.github/workflows/Flutter_Release.yml 作为执行流水线。
目前调试到上传产物阶段。
