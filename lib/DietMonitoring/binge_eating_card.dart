import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BingeEatingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('冲动应对卡片', style: TextStyle(color: Colors.black)),
        backgroundColor: Color.fromARGB(255, 223, 221, 240),
        elevation: 0,
      ),
      body: SwipeableCardsSection(
        cardTexts: [
          '当有暴食/清除冲动时，我将:和朋友/家人打电话聊天',
          '当有暴食/清除冲动时，我将:看一部引人入胜的电影',
          // 添加更多卡片的文字
        ],
        imageUrls: [
          'assets/images/background1.jpg', // 替换为你的图片URL
          'assets/images/background1.jpg', // 替换为你的图片URL
          // 添加更多图片URL
        ],
      ),
    );
  }
}

class SwipeableCardsSection extends StatefulWidget {
  final List<String> cardTexts; // 卡片文本的列表
  final List<String> imageUrls; // 图片URL的列表

  SwipeableCardsSection({
    required this.cardTexts,
    required this.imageUrls,
  });

  @override
  _SwipeableCardsSectionState createState() => _SwipeableCardsSectionState();
}

class _SwipeableCardsSectionState extends State<SwipeableCardsSection> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            itemCount: widget.cardTexts.length,
            controller: _pageController,
            itemBuilder: (context, index) {
              return buildSwipeableCard(widget.cardTexts[index], widget.imageUrls[index]);
            },
          ),
        ),
        // 小点指示器
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              widget.cardTexts.length,
              (index) => buildDot(index, context),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSwipeableCard(String text, String imageUrl) {
  return Card(
    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Column(
      children: <Widget>[
        Expanded(
          flex: 3, // 图片占据3份空间
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              imageUrl, // 这里的imageUrl应该是资源路径
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ),
        Expanded(
          flex: 1, // 文字占据1份空间
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            child: Text(
              text,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    ),
  );
}


  Widget buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index
            ? Theme.of(context).primaryColor // 当前页点显示主题色
            : Theme.of(context).primaryColor.withOpacity(0.3), // 其他页点显示淡化的主题色
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
