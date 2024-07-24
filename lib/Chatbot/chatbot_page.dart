// 这个文件定义了chatbot的核心功能部分，包括聊天页面和不同对话方式的相关逻辑。
import 'package:flutter/material.dart';
import 'package:namer_app/global_setting.dart';
import 'chat_models.dart';
import 'chat_widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// ChatbotPage class是chatbot的主页面，负责显示聊天界面和处理用户输入。
class ChatbotPage extends StatefulWidget {
  final List<Content> contents;

  ChatbotPage({required this.contents});

  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

// _ChatbotPageState类是ChatbotPage的状态类，负责管理聊天页面的状态和逻辑。
class _ChatbotPageState extends State<ChatbotPage> {
  int _currentContentIndex = 0;
  bool _shouldShowUserInterface = false;
  List<ChatMessage> messages = [];
  final _controller = TextEditingController();
  List<UserResponse> userResponses = [];

  List<Content> contents = [];

  //初始化的状态
  @override
  void initState() {
    super.initState();
    contents = widget.contents;
    _displayNextContent();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // build函数用于构建聊天页面的UI。
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('认识暴食', style: TextStyle(color: Colors.black)),
        backgroundColor: themeColor,
      ),
      backgroundColor: Color.fromRGBO(243, 243, 243, 255),
      body: Column(children: [
        ..._buildBodyWidgets(),
        if (_shouldShowUserInterface) ..._buildInteractWidgets()
      ]),
    );
  }

// _displayNextContent函数用于显示下一个聊天内容。
  void _displayNextContent() {
    if (_currentContentIndex < contents.length) {
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          final currentContent = contents[_currentContentIndex];
          switch (currentContent.type) {
            case ContentType.TEXT:
              messages
                  .add(ChatMessage(text: currentContent.text!, isUser: false));
              break;
            case ContentType.IMAGE:
              messages.add(ChatMessage(
                  text: "", imageUrl: currentContent.imageUrl, isUser: false));
              break;
            case ContentType.USER_INPUT:
              _promptUserInput();
              break;
          }
        });
      });
    } else {
      _onConversationEnd();
    }
  }

// _onConversationEnd函数用于处理对话结束时的逻辑。当所有预设chatbot的contents被处理完的时候，会触发这个函数
  void _onConversationEnd() {
    print('Conversation has ended. User responses:');
    for (UserResponse response in userResponses) {
      print('Content ID: ${response.contentId}, Ue: ${response.userResponse}');
    }
  }

// _promptUserInput函数显示用户输入的对话框。
  void _promptUserInput() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Please input your response'),
          content: TextField(
            controller: _controller,
            onSubmitted: (value) {
              setState(() {
                messages.add(ChatMessage(text: value, isUser: true));
                _currentContentIndex++;
                _displayNextContent();
              });
              Navigator.of(context).pop(); // 关闭对话框
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Submit'),
              onPressed: () {
                // 这里可以获取输入的内容，并处理用户的输入
                // 例如，添加到messages列表，并显示下一个内容
              },
            ),
          ],
        );
      },
    );
  }

  // _buildBodyWidgets函数用于构建聊天页面的UI部件。
  List<Widget> _buildBodyWidgets() {
    List<Widget> widgets = [];
    widgets.add(Expanded(child: _buildMessageList()));
    return widgets;
  }

  // 判断当前内容是否需要用户输入，然后显示输入框。
  List<Widget> _buildInteractWidgets() {
    List<Widget> widgets = [];

    if (_currentContentIndex < contents.length) {
      switch (contents[_currentContentIndex].responseType) {
        case ResponseType.userInput:
          print("user input");
          widgets.add(_buildUserInputField());
          break;
        case ResponseType.choices:
          if (contents[_currentContentIndex].choices != null) {
            print("choices");
            widgets.add(_buildChoiceButtons());
          }
          break;
        case ResponseType.multiChoices:
          if (contents[_currentContentIndex].choices != null) {
            print("multi_choices");
            widgets.add(
                _buildChoices(contents[_currentContentIndex].choices!, true));
            widgets.add(_buildSubmitMultiChoiceButton());
          }
          break;
        default:
      }
    }
    return widgets;
  }

  // _buildMessageList函数用于构建聊天消息列表。
  ListView _buildMessageList() {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) => _buildMessageRow(messages[index]),
    );
  }

  // _buildMessageRow函数用于构建单条聊天消息。
  Row _buildMessageRow(ChatMessage message) {
    return Row(
      mainAxisAlignment:
          message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        if (!message.isUser) Icon(Icons.android, color: Color(0xFF6FCF97)),
        Flexible(child: _buildMessageContent(message)),
        if (message.isUser)
          Icon(Icons.person, color: Color.fromARGB(255, 228, 206, 235)),
      ],
    );
  }

  // _buildMessageContent函数用于构建聊天消息内容。
  Widget _buildMessageContent(ChatMessage message) {
    return Bubble(
        text: message.text,
        imageUrl: message.imageUrl,
        isUser: message.isUser,
        onComplete: _handleBubbleComplete);
  }

  // _handleBubbleComplete函数处理气泡显示完成后的逻辑。
  // 如果ResponseType是auto，则继续播放下一个content
  // 反之，等待用户的回复
  void _handleBubbleComplete() {
    if (contents[_currentContentIndex].responseType == ResponseType.auto) {
      _currentContentIndex++;
      _displayNextContent();
    } else {
      setState(() {
        _shouldShowUserInterface = true;
      });
    }
  }

  // _buildChoices用于构建需要用户多选回复的对话
  Widget _buildChoices(List<String> choices, bool isMultiChoice) {
    return Wrap(
      spacing: 8.0, // 水平间隔
      runSpacing: 8.0, // 垂直间隔
      children: choices.map((choice) {
        final isSelected =
            contents[_currentContentIndex].selectedChoices?.contains(choice) ??
                false;
        return Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 4.0), // 每个ChoiceChip的水平外边距
          child: ChoiceChip(
            label: Text(choice),
            selected: isSelected,
            onSelected: (selected) {
              setState(() {
                if (isMultiChoice) {
                  if (selected) {
                    contents[_currentContentIndex].selectedChoices?.add(choice);
                  } else {
                    contents[_currentContentIndex]
                        .selectedChoices
                        ?.remove(choice);
                  }
                } else {
                  messages.add(ChatMessage(text: choice, isUser: true));
                  contents[_currentContentIndex].setShowChoices(false);
                  _currentContentIndex++;
                  _displayNextContent();
                }
              });
            },
          ),
        );
      }).toList(),
    );
  }

  // _buildChoices用于构建用户多选的按钮
  Widget _buildSubmitMultiChoiceButton() {
    double screenWidth = MediaQuery.of(context).size.width;
    if (contents[_currentContentIndex].responseType ==
        ResponseType.multiChoices) {
      return Container(
        width: screenWidth * 0.8, // 设置每个选项的宽度为屏幕宽度的80%
        padding: EdgeInsets.symmetric(vertical: 4.0), // 垂直方向上的padding
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              messages.add(ChatMessage(
                  text: contents[_currentContentIndex]
                      .selectedChoices!
                      .join(', '),
                  isUser: true));
              contents[_currentContentIndex].setShowChoices(false);
              _currentContentIndex++;
              _displayNextContent();
              _shouldShowUserInterface = false;
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF9D9BE9), // 设置按钮的颜色
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20) // 设置圆角
                ),
          ),
          child: Text('选好了'),
        ),
      );
    }
    return SizedBox.shrink(); // 当不满足条件时，返回一个占位的小部件
  }

  //_buildChoiceButtons用于构建需要用户单选回复的对话
  Widget _buildChoiceButtons() {
    double screenWidth = MediaQuery.of(context).size.width;
    return Wrap(
      direction: Axis.horizontal, // 主轴方向为水平
      alignment: WrapAlignment.center, // 水平方向上居中对齐
      runSpacing: 4.0, // 垂直方向上的间距
      children: contents[_currentContentIndex].choices!.map((choice) {
        return Container(
          width: screenWidth * 0.8, // 设置每个选项的宽度为屏幕宽度
          padding: EdgeInsets.symmetric(vertical: 4.0), // 垂直方向上的padding
          child: ElevatedButton(
            onPressed: () => _handleChoiceButtonPressed(choice),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF9D9BE9),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20) // 如果你不希望有圆角，可以设置为0
                  ),
            ),
            child: Text(choice),
          ),
        );
      }).toList(),
    );
  }

  // _handleChoiceButtonPressed函数处理单选项按钮的点击后的逻辑。
  void _handleChoiceButtonPressed(String choice) {
    setState(() {
      // 1. 添加用户的选择到聊天记录中
      messages.add(ChatMessage(text: choice, isUser: true));

      // 2. 增加当前内容索引
      _currentContentIndex++;
      UserResponse response = UserResponse(
          contentId: contents[_currentContentIndex].id, userResponse: choice);
      userResponses.add(response);

      // 3. 显示下一个内容
      if (_currentContentIndex < contents.length) {
        _displayNextContent();
      }
      _shouldShowUserInterface = false;
    });
  }

  // _buildUserInputField函数构建用户输入文本框。
  Widget _buildUserInputField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, -3), // 上方阴影
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                hintText: "请输入...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Color(0xFFEDEDED),
              ),
            ),
          ),
          SizedBox(width: 10.0),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 50, // 选择合适的高度
              width: 50, // 选择合适的宽度
              child: IconButton(
                icon: Icon(MdiIcons.send),
                onPressed: () {
                  _handleUserInput(_controller.text);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // _handleUserInput函数处理用户输入的文本。
  void _handleUserInput(String inputText) async {
    // 存储到SharedPreferences
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setString('lastUserInput', inputText);

    // 将用户的输入添加到聊天消息中
    setState(() {
      messages.add(ChatMessage(text: inputText, isUser: true));
    });
    UserResponse response = UserResponse(
        contentId: contents[_currentContentIndex].id, userResponse: inputText);
    userResponses.add(response);

    _currentContentIndex++;
    _displayNextContent();

    // 清除输入框内容
    _controller.clear();
    _shouldShowUserInterface = false;
  }
}
