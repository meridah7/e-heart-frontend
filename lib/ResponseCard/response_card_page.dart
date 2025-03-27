import 'package:flutter/material.dart';
import 'package:flutter_reorderable_grid_view/widgets/widgets.dart';
import './response_card_model.dart';
import './response_card.dart';
import './editable_card.dart';
import './edit_card_dialog.dart';
import 'hero_dialog_route.dart';
import 'package:namer_app/services/dio_client.dart';
import 'package:dio/dio.dart';

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
  final DioClient dioClient = DioClient();
  late List<ResponseCardModel> _cardList = [];

  final _gridViewKey = GlobalKey();

  bool _isEditing = false;

  List<int> lockedIndices = [];

  List<int> nonDraggableIndices = [];

  Future<void> loadData() async {
    // 获取数据，调用你的 dio 请求逻辑

    try {
      Response response =
          await dioClient.getRequest('/impulse/impulse-strategies');
      List<dynamic> data = response.data;

      _cardList = data.map((val) => ResponseCardModel.fromJson(val)).toList();

      // 按照 order 字段升序排序
      _cardList.sort((a, b) => a.activity_order.compareTo(b.activity_order));
    } catch (e) {
      print('Error in fetching data $e');
      throw Exception(e);
    }
  }

  // 更新接口
  Future<void> handleUpdateStrategy(ResponseCardModel updatedCard) async {
    try {
      Response response = await dioClient
          .putRequest('/impulse/impulse-strategies/${updatedCard.id}', {
        "custom_activity": updatedCard.custom_activity,
        "details": updatedCard.details,
        "activity_order": updatedCard.activity_order,
      });
      if (response.statusCode == 200) {
        await _initializeData();
      }
    } catch (e) {
      print('Error in editing card');
    }
  }

  Future<void> _initializeData() async {
    await loadData();

    setState(() {
      lockedIndices = [_cardList.length];
      nonDraggableIndices = [_cardList.length];
    });
  }

  // 添加卡片接口
  Future<void> handleAddImpulseStrategy(
      {ResponseCardModel? card, int? order}) async {
    try {
      Response response =
          await dioClient.postRequest('/impulse/impulse-strategies', {
        "custom_activity": card?.custom_activity,
        "details": card?.details,
        "activity_order": order
      });
      if (response.statusCode == 200) {
        await _initializeData();
      }
    } catch (e) {
      print('Error in Update');
    }
    return;
  }

  // 排序接口
  Future<void> handleReorder(List<int> list) async {
    try {
      Response response =
          await dioClient.postRequest('/impulse/strategy-order', {
        "strategy_order": list,
      });
      if (response.statusCode == 200) {
        await _initializeData();
      }
    } catch (e) {
      throw Exception('Error in reorder $e');
    }
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
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    )..repeat(reverse: true);
    lockedIndices = [_cardList.length];
    nonDraggableIndices = [_cardList.length];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeData();

    // // 在 didChangeDependencies 中调用 Provider.of
    // final provider =
    //     Provider.of<ResponseCardModelProvider>(context, listen: false);
    // provider.loadData();
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
      // onDragStarted: _handleDragStarted,
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
            onPressed: () async {
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
        showDeleteConfirmationDialog(context, card);
        // 处理删除逻辑
      },
      key: Key(card.id.toString()),
      child: CustomDraggable(
        key: Key(card.id.toString() + card.custom_activity),
        data: index,
        child: GestureDetector(
          onTap: () =>
              _openEditDialog(context, _cardList[index], DetailScene.check),
          child: Hero(
            tag: 'card-${card.id.toString() + card.custom_activity}',
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

  // 拖拽
  // void _handleDragEnd(int index) {}

  // 确认删除弹窗
  Future<void> showDeleteConfirmationDialog(
      BuildContext context, ResponseCardModel card) async {
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
                _handleDelete(card);
                Navigator.of(context).pop(); // 关闭对话框
              },
            ),
          ],
        );
      },
    );
  }

  // 删除接口
  void _handleDelete(ResponseCardModel card) async {
    try {
      if (card.id == null) return;
      Response response = await dioClient
          .deleteRequest('/impulse/impulse-strategies/${card.id}');
      if (response.statusCode == 200) {
        await loadData();
      }
    } catch (e) {
      throw Exception('Error in Delete');
    }
  }

  // 列表重新排序
  void _handleReorder(ReorderedListFunction reorderedListFunction) async {
    setState(() {
      _cardList = reorderedListFunction(_cardList) as List<ResponseCardModel>;
    });
    try {
      List<int?> orderList = _cardList.map((v) => v.id).toList();
      Response response =
          await dioClient.putRequest('/impulse/strategy-order', {
        "strategy_order": orderList,
      });
      if (response.statusCode == 200) {
        await loadData();
      }
    } catch (e) {
      throw Exception('Error in reorder $e');
    }
  }

  // 详情弹窗

  void _openEditDialog(
      BuildContext context, ResponseCardModel card, DetailScene scene) {
    Navigator.of(context).push(HeroDialogRoute(builder: (context) {
      return EditCardDialog(
        card: card,
        // 编辑卡片回调
        onSave: (saveCard) {
          setState(() {
            // 编辑卡片
            if (saveCard.id != null) {
              handleUpdateStrategy(saveCard);
            } else {
              // 新增卡片
              handleAddImpulseStrategy(card: saveCard, order: _cardList.length);
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
      ),
      body: _getReorderableWidget(),
    );
  }
}
