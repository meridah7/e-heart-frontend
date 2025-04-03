# E-Heart App

## Getting Started

### 开发须知

项目的目录结构进行了一次初步重构。

* /lib/models 用于存放数据模型
* /lib/services 用于处理服务接口和实现
* /lib/provider 用于处理响应式数据

### 项目运行

1. 配置fvm环境，指定flutter执行版本 3.22.1
2. 使用VSCode 进行开发，安装Flutter 相关插件
3. 安卓模拟器/真机调试：

* 将设备调整至开发者模式，通过adb 连接到开发设备中
* 配置launch.json,指定好设备调试ID信息和模式
* 启动launch 模式

4. 苹果设备调试：

* 配置好launch.json，指定模拟器或者真机
* 需要使用mac设备，用XCode打开/ios/Runnner.xcodeproj 或者/ios/Runner.xcworkspace,并运行

### 推荐插件

* freezed： 用于将接口返回的响应JSON，直接自动生成带fromJson、toJson、toString方法的Dart class
* build runner: 用于生成Freezed和Riverpod等模板代码
* Flutter
* Dart
* Github Copilot: 提供AI代码补全
* Code Spell Checker： 检查单词拼写
* Flutter Riverpod Snippets： 补全Riverpod 的代码脚本
......

### 模型生成

在获取到接口的数据之后，将接口返回值的data的JSON内容复制，去quickType 网站上选择将JSON转换成dart class，并勾选freezed，命名并复制代码内容存放在/lib/models 目录下。

* **user**
* **user_progress**

### 接口请求

项目中使用的Dio 作为网络请求库。基于Dio 进行封装，以处理接口请求，Token更新等操作。

在项目中可以直接于代码中使用 lib/services/dio_client.dart 里对应的getRequest 和postRequest 来处理接口。

建议的做法是在lib/service 下的抽象类中创建需要的接口class，在对应的service 文件中去实现接口。

### 状态管理

目前使用provider（逐步迁移至Riverpod） 做响应式的状态管理。目前实现的功能有用户信息的user provider和用户进度相关的progress provider。

### 问卷提交

问卷提交的相关处理接口放在/lib/survey/utils.dart 下处理，根据taskId 来执行不同的问卷内容变量抽取和接口。

## Build & Release

TODO
希望采用项目里的GitHub Actions 处理。使用/.github/workflows/Flutter_Release.yml 作为执行流水线。
目前调试到上传产物阶段。
