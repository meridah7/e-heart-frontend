# E-Heart App

## Getting Started

### 开发须知

项目的目录结构进行了一次初步重构。

* /lib/models 用于存放数据模型
* /lib/services 用于处理服务接口和实现
* /lib/provider 用于处理响应式数据，用于与页面交互

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

### 模型代码生成

在获取到接口的数据之后，将接口返回值的data的JSON内容复制，去quickType 网站上选择将JSON转换成dart class，并勾选freezed，命名并复制代码内容存放在/lib/models 目录下。

* **user**
* **user_progress**

### 接口请求

项目中使用的Dio 作为网络请求库。Dio 可以方便地设置响应器和拦截器，基于Dio 进行封装，以处理接口请求，Token更新等操作。

在项目中可以直接于代码中使用 lib/services/dio_client.dart 里对应的getRequest、postRequest、putRequest、deleteRequest 来处理接口。

建议的做法是在lib/service 下的抽象类中创建需要的接口class，在对应的service 文件中去实现接口。

### 状态管理

目前使用Riverpod，做整体的状态管理，接口的缓存,以及页面搭建。详情见lib/provider 文件夹。

Riverpod 不仅是一个全局的状态管理库，它将自己作为一个管理依赖项的库，它还提供了依赖注入，单例模式等等。

Riverpod 的AutoDispose 特性可以提升性能。如果Widget 不再监听Riverpod的provider，会自动销毁。如果不需要自动销毁，注解上标明keepAlive。

使用Riverpod 的注解方法生成代码，在页面使用配套的ConsumerStatefulWidget 和ConsumerWidget以及ref 可以方便实现响应式页面。但是有一些上手难度。

### 问卷提交

问卷提交的相关处理接口放在/lib/survey/utils.dart 下处理，根据taskId 来执行不同的问卷内容变量抽取和接口。

## Build & Release

TODO
希望采用项目里的GitHub Actions 处理。使用/.github/workflows/Flutter_Release.yml 作为执行流水线。
目前调试到上传产物阶段。
