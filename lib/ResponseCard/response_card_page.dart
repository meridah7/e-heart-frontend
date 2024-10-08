import 'package:flutter/material.dart';
import 'package:flutter_reorderable_grid_view/widgets/widgets.dart';
import './response_card_model.dart';
import './response_card.dart';
import './editable_card.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import './edit_card_dialog.dart';
import 'hero_dialog_route.dart';

class BingeEatingResponseCard extends StatefulWidget {
  const BingeEatingResponseCard({Key? key}) : super(key: key);
  @override
  _BingeEatingResponseCardState createState() =>
      _BingeEatingResponseCardState();
}

class _BingeEatingResponseCardState extends State<BingeEatingResponseCard>
    with SingleTickerProviderStateMixin {
  final _scrollController = ScrollController();
  late AnimationController _controller;
  late List<ResponseCardModel> _cardList = [];

  final _gridViewKey = GlobalKey();

  bool _isEditing = false;

  List<int> lockedIndices = [];

  List<int> nonDraggableIndices = [];

  Future<List<ResponseCardModel>> loadMockData() async {
    String jsonString = await rootBundle.loadString('assets/mock_data.json');
    List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => ResponseCardModel.fromJson(json)).toList();
  }

  Future<void> _initializeMockData() async {
    _cardList = await loadMockData();
    setState(() {
      lockedIndices = [_cardList.length];
      nonDraggableIndices = [_cardList.length];
    });
  }

  void toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
      if (_isEditing) {
        _controller.repeat(reverse: true);
      } else {
        _controller.stop();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeMockData();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    )..repeat(reverse: true);
    lockedIndices = [_cardList.length];
    nonDraggableIndices = [_cardList.length];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 应对卡列表容器
  Widget _getReorderableWidget() {
    final generatedChildren = _getGeneratedChildren(_cardList);
    return ReorderableBuilder(
      key: Key(_gridViewKey.toString()),
      onReorder: _handleReorder,
      // onUpdatedDraggedChild: _handleUpdatedDraggedChild,
      // onDragEnd: _handleDragEnd,
      onDragStarted: _handleDragStarted,
      scrollController: _scrollController,
      enableLongPress: true,
      nonDraggableIndices: nonDraggableIndices,
      lockedIndices: lockedIndices,
      children: generatedChildren,
      builder: (children) {
        return GridView(
          key: _gridViewKey,
          controller: _scrollController,
          padding: EdgeInsets.all(8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            childAspectRatio: 9 / 16,
          ),
          children: children,
        );
      },
    );
  }

  //  应对卡列表
  List<Widget> _getGeneratedChildren(list) {
    var length = _isEditing ? list.length + 1 : list.length;
    return List<Widget>.generate(length, (index) {
      if (_isEditing && index == list.length) {
        return Card(
          key: Key('card add'),
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          // color: Theme.of(context).colorScheme.secondary,
          color: Colors.white60,
          child: IconButton(
            onPressed: () {
              setState(() {
                _cardList.add(ResponseCardModel(
                    custom_activity: '请填写你的冲动应对策略',
                    details: "请填应对策略的详细执行方法",
                    activity_order: index + 1));
                lockedIndices = [_cardList.length];
                nonDraggableIndices = [_cardList.length];
                _openEditDialog(
                    context, _cardList[_cardList.length - 1], DetailScene.edit);
              });
            },
            icon: Icon(
              Icons.add,
              color: Colors.white,
              size: 48,
            ),
          ),
        );
      }
      return _getChild(index: index, card: list[index]);
    });
  }

  // 应对卡列表项
  Widget _getChild({required int index, required ResponseCardModel card}) {
    return EditableCard(
      isEditing: _isEditing, // 控制是否处于编辑状态的变量
      onDelete: () {
        showDeleteConfirmationDialog(context, index);
        // 处理删除逻辑
      },
      key: Key(card.activity_order.toString()),
      child: CustomDraggable(
        key: Key(card.activity_order.toString()),
        data: index,
        child: GestureDetector(
          onTap: () =>
              _openEditDialog(context, _cardList[index], DetailScene.check),
          child: Hero(
            tag:
                'card-${card.activity_order.toString() + card.custom_activity}',
            child: Material(
              color: Colors.transparent,
              child: ResponseCard(
                responseCard: card,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 触发拖拽
  void _handleDragStarted(int index) {
    if (!_isEditing) {
      toggleEditing();
    }
  }

  // 确认删除弹窗
  Future<void> showDeleteConfirmationDialog(
      BuildContext context, int index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // 用户必须点击按钮才能关闭对话框
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('确认删除'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('你确定要删除该应对卡吗？'),
                Text('此操作无法撤销。'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('取消'),
              onPressed: () {
                Navigator.of(context).pop(); // 关闭对话框
              },
            ),
            TextButton(
              child: Text('删除'),
              onPressed: () {
                //TODO 在这里添加删除操作的接口
                _handleDelete(index);
                Navigator.of(context).pop(); // 关闭对话框
              },
            ),
          ],
        );
      },
    );
  }

  void _handleDelete(int index) {
    setState(() {
      _cardList.removeAt(index);
    });
  }

  // 列表重新排序
  void _handleReorder(ReorderedListFunction reorderedListFunction) {
    setState(() {
      _cardList = reorderedListFunction(_cardList) as List<ResponseCardModel>;
    });
  }

  // 详情弹窗

  void _openEditDialog(
      BuildContext context, ResponseCardModel card, DetailScene scene) {
    Navigator.of(context).push(HeroDialogRoute(builder: (context) {
      return EditCardDialog(
        card: card,
        onSave: (updatedCard) {
          setState(() {
            int index = _cardList.indexWhere(
                (item) => item.activity_order == updatedCard.activity_order);
            if (index != -1) {
              _cardList[index] = updatedCard;
            }
          });
        },
        scene: scene,
      );
    }));
  }

  // 调试拖拽场景用的方法
  // void _handleUpdatedDraggedChild(int index) {
  //   // ScaffoldMessenger.of(context).showSnackBar(
  //   //     SnackBar(content: Text('Dragging child updated at $index!')));
  // }
  // void _handleDragEnd(int index) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Dragging was finished at $index!')));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('冲动应对卡', style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
              onPressed: toggleEditing,
              icon: Icon(_isEditing ? Icons.done : Icons.edit))
        ],
        backgroundColor: Color.fromARGB(255, 223, 221, 240),
      ),
      body: _getReorderableWidget(),
    );
  }
}
