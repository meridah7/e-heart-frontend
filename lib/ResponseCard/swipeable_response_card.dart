import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import './response_card_model.dart';
import './response_card.dart';
import './edit_card_dialog.dart';
import 'hero_dialog_route.dart';
import '../ResponseCard/response_card_page.dart';

// 问卷内部使用，卡片滑动展示组件

class SwipeableResponseCardList extends StatefulWidget {
  @override
  _SwipeableResponseCardList createState() => _SwipeableResponseCardList();
}

class _SwipeableResponseCardList extends State<SwipeableResponseCardList> {
  int _currentPage = 0;
  late List<ResponseCardModel> _cardList = [];
  bool _isInitialized = false;

  // TODO 接口调用
  Future<List<ResponseCardModel>> loadMockData() async {
    String jsonString = await rootBundle.loadString('assets/mock_data.json');
    List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => ResponseCardModel.fromJson(json)).toList();
  }

  // 初始化数据
  Future<void> _initializeMockData() async {
    _cardList = await loadMockData();
    setState(() {
      _isInitialized = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeMockData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          // Content area
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  // 应对卡列表项
  Widget _getChild({required int index, required ResponseCardModel card}) {
    return GestureDetector(
      onDoubleTap: () => _openEditDialog(context, _cardList[index]),
      onTap: () => _handleResponseCardPage(),
      child: Hero(
        tag: 'card-${card.activity_order.toString() + card.custom_activity}',
        child: Material(
          color: Colors.transparent,
          child: ResponseCard(
            responseCard: card,
          ),
        ),
      ),
    );
  }

  // 双击编辑
  void _openEditDialog(BuildContext context, ResponseCardModel card) {
    Navigator.of(context).push(HeroDialogRoute(builder: (context) {
      return EditCardDialog(
        card: card,
        onSave: (updatedCard) {
          setState(() {
            // TODO: 接口更新应对卡状态
            int index = _cardList.indexWhere(
                (item) => item.activity_order == updatedCard.activity_order);
            if (index != -1) {
              _cardList[index] = updatedCard;
            }
          });
        },
        scene: DetailScene.edit,
      );
    }));
  }

  // 单击跳转应对卡
  void _handleResponseCardPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            // builder: (context) => BingeEatingResponsePage())),
            builder: (context) => BingeEatingResponseCard()));
  }

  Widget _buildContent() {
    // TODO:使用StreamBuilder 改造
    if (!_isInitialized) {
      return Center(child: CircularProgressIndicator());
    }
    return Column(
      children: [
        Expanded(
          child: CarouselSlider.builder(
            itemCount: _cardList.length,
            itemBuilder: (context, index, realIndex) {
              final entry = _cardList[index];
              return SizedBox(
                width: 325,
                height: 526,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _getChild(index: index, card: entry)),
              );
            },
            options: CarouselOptions(
              // height: double.infinity,
              height: 565,
              enlargeCenterPage: true,
              viewportFraction: 1.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentPage = index;
                });
              },
              enableInfiniteScroll: true,
              autoPlay: false,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: CarouselIndicator(
            count: _cardList.length,
            index: _currentPage,
            color: Colors.grey,
            activeColor: Colors.black,
            width: 8,
            height: 8,
          ),
        ),
      ],
    );
  }
}
