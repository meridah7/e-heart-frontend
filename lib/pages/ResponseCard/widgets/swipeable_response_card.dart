import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:namer_app/models/strategy_card.dart';
import 'package:namer_app/providers/strategy_list_data.dart';
import 'package:namer_app/utils/index.dart';
import 'response_card.dart';
import 'edit_card_dialog.dart';
import '../hero_dialog_route.dart';
import '../index.dart';

// 问卷内部使用，卡片滑动展示组件

class SwipeableResponseCardList extends ConsumerStatefulWidget {
  @override
  _SwipeableResponseCardList createState() => _SwipeableResponseCardList();
}

class _SwipeableResponseCardList
    extends ConsumerState<SwipeableResponseCardList> {
  int _currentPage = 0;
  late final _strategyListDataNotifier;
  // bool _isInitialized = false;

  // Future<void> loadData() async {
  //   try {
  //     Response response =
  //         await dioClient.getRequest('/impulse/impulse-strategies');
  //     List<dynamic> data = response.data;

  //     _cardList = data.map((val) => StrategyCard.fromJson(val)).toList();

  //     // 按照 order 字段升序排序
  //     _cardList.sort((a, b) => a.activityOrder.compareTo(b.activityOrder));
  //   } catch (e) {
  //     print('Error in fetching data $e');
  //     throw Exception(e);
  //   }
  //   setState(() {
  //     _isInitialized = true;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    _strategyListDataNotifier = ref.read(strategyListDataProvider.notifier);
    // loadData();
  }

  // 更新接口
  Future<void> handleUpdateStrategy(StrategyCard updatedCard) async {
    try {
      await _strategyListDataNotifier.updateStrategy(updatedCard);
    } catch (e) {
      print('Error in editing card');
    }
  }

  // 应对卡列表项
  Widget _getChild({required int index, required StrategyCard card}) {
    return GestureDetector(
      onDoubleTap: () => _openEditDialog(context, card),
      onTap: () => _handleResponseCardPage(),
      child: Hero(
        tag: 'card-${card.activityOrder.toString() + card.customActivity}',
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
  void _openEditDialog(BuildContext context, StrategyCard card) {
    Navigator.of(context).push(HeroDialogRoute(builder: (context) {
      return EditCardDialog(
        card: card,
        onSave: (updatedCard) {
          setState(() {
            handleUpdateStrategy(updatedCard);
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
            builder: (context) => ResponseCardPage()));
  }

  Widget _buildContent() {
    // TODO:使用StreamBuilder 改造
    // if (!_isInitialized) {
    //   return Center(child: CircularProgressIndicator());
    // }
    final strategyList = ref.watch(strategyListDataProvider);
    return strategyList.when(
        data: (cardList) {
          return Column(
            children: [
              Expanded(
                child: CarouselSlider.builder(
                  itemCount: cardList.length,
                  itemBuilder: (context, index, realIndex) {
                    final entry = cardList[index];
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
                  count: cardList.length,
                  index: _currentPage,
                  color: Colors.grey,
                  activeColor: Colors.black,
                  width: 8,
                  height: 8,
                ),
              ),
            ],
          );
        },
        loading: () => customLoading(),
        error: (error, stackTrace) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Icon(Icons.error_outline),
            ),
          );
        });
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
}
