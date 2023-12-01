import 'package:flutter/material.dart';
import 'package:namer_app/global_setting.dart';

class RecordReportPage extends StatefulWidget {
  @override
  _RecordReportPageState createState() => _RecordReportPageState();
}

class _RecordReportPageState extends State<RecordReportPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // 模拟加载时间
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('饮食监控报告'),
          backgroundColor: themeColor,
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '首先，让我们来看看你的饮食情况：',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      Text(
                        '你吃了小碗牛肉, 进餐地点是玉树园。\n'
                        '这次进食时你心情一般，但在进食过程中感受到了愉悦。\n'
                        '你描述了这次进食为“轻度暴食”，诱因是上午试演讲完有点焦虑，想要通过暴食来缓解一下。\n'
                        '你没有进行食物消除的行为。吃完之后有点撑，不太舒服。',
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(height: 20),
                      Text(
                        '亲爱的，非常感谢你分享了这次的饮食日志。首先，我想肯定你坚持记录这些细节，这对于我们更好地理解你的饮食模式和情绪关联非常有帮助。',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      Text(
                        '这次进食中，我注意到你选择了小碗牛肉，而且你描述它让你感到愉悦。然而，你提到了一点轻度的暴食，而且诱因是因为上午试演讲后感到焦虑。这表明情绪和饮食之间可能存在一定的关联。',
                        style: TextStyle(fontSize: 15),
                      ),
                      // 添加更多建议内容
                      SizedBox(height: 20),
                      Text(
                        '在接下来的分析中，我想重点关注你的情绪和饮食之间的联系。试演讲后的焦虑似乎是这次暴食的触发因素。了解这种关系有助于我们更好地探讨情绪对饮食行为的影响，以及反之亦然。',
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(height: 20),
                      Text(
                        '另外，你提到吃完后感到有点撑和不太舒服，这也是我们需要关注的一点。这可能与暴食行为以及食物选择有关，进一步的分析可以帮助我们了解这些体验的背后机制。最后，我想强调，偶尔的饮食偏离并不代表彻底的失败。你在这里表达的努力和坚持对于你的治疗进程非常重要。请不要过度自责，专注于未来的进食，我们一起努力，一切都仍然充满了希望。',
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(height: 20),
                      Text(
                        '自我接纳和同情：请记住，对自己保持温柔和理解是很重要的。暴食可能是一种应对压力或其他情绪的方式，尝试对自己的体验保持开放和同情。',
                        style: TextStyle(fontSize: 15),
                      ),
                      // 添加更多建议内容
                      SizedBox(height: 20),
                      Text(
                        '记住，改变饮食行为和应对暴食症是一个渐进的过程，需要时间和耐心。每一步，无论大小，都是向前迈进的一步。',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
          child: Icon(Icons.arrow_back),
        ));
  }
}
