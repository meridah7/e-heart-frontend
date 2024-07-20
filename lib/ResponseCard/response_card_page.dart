import 'package:flutter/material.dart';
import 'package:flutter_reorderable_grid_view/widgets/widgets.dart';
import './response_card_model.dart';
import './response_card.dart';

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

  final _gridViewKey = GlobalKey();

  bool isEditing = false;

  var lockedIndices;

  var nonDraggableIndices;

  List<ResponseCardModel> _box = [
    ResponseCardModel(
        custom_activity: "title 1", details: "desc", activity_order: 1),
    ResponseCardModel(
        custom_activity: "title 2", details: "desc", activity_order: 2),
    ResponseCardModel(
        custom_activity: "title 3", details: "desc", activity_order: 3),
    ResponseCardModel(
        custom_activity: "title 4", details: "desc", activity_order: 4),
    ResponseCardModel(
        custom_activity: "title 5", details: "desc", activity_order: 5),
  ];

  void toggleEditing() {
    setState(() {
      isEditing = !isEditing;
      if (isEditing) {
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
    lockedIndices = [_box.length];
    nonDraggableIndices = [_box.length];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // static const _startCounter = 20;

  // int keyCounter = _startCounter;
  // List<int> children = List.generate(_startCounter, (index) => index);

  // 应对卡列表容器
  Widget _getReorderableWidget() {
    final generatedChildren = _getGeneratedChildren(_box);
    return ReorderableBuilder(
      key: Key(_gridViewKey.toString()),
      onReorder: _handleReorder,
      onDragStarted: _handleDragStarted,
      onUpdatedDraggedChild: _handleUpdatedDraggedChild,
      onDragEnd: _handleDragEnd,
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
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          children: children,
        );
      },
    );
  }

  //  应对卡列表
  List<Widget> _getGeneratedChildren(list) {
    var length = isEditing ? list.length + 1 : list.length;

    return List<Widget>.generate(length, (index) {
      if (isEditing && index == list.length) {
        return Container(
          key: Key('card add'),
          decoration:
              BoxDecoration(color: Theme.of(context).colorScheme.secondary),
          height: 300.0,
          width: 100.0,
          child: IconButton(
            onPressed: () {
              setState(() {
                _box.add(ResponseCardModel(
                    custom_activity: 'title ${index.toString()}',
                    details: "desc",
                    activity_order: index + 1));
                lockedIndices = [_box.length];
                nonDraggableIndices = [_box.length];
              });
            },
            icon: Icon(Icons.add),
          ),
        );
      }
      return _getChild(index: index, card: list[index]);
    });
  }

  Widget _buildIcon(int index, bool isDragging) {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: _controller,
          child: Icon(Icons.apps, size: 50),
          builder: (context, child) {
            return Transform.rotate(
              angle:
                  isEditing && !isDragging ? _controller.value * 0.1 - 0.05 : 0,
              child: child,
            );
          },
        ),
        if (isEditing && !isDragging)
          Positioned(
            top: 0,
            right: -4,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.red),
              onPressed: () {
                setState(() {
                  _box.removeAt(index);
                });
              },
            ),
          ),
      ],
    );
  }

  // 应对卡列表项
  Widget _getChild({required int index, required ResponseCardModel card}) {
    return CustomDraggable(
      key: Key(card.activity_order.toString()),
      data: index,
      child: Container(
          width: 80,
          height: 240,
          // decoration:
          //     BoxDecoration(color: Theme.of(context).colorScheme.primary),
          child: ResponseCard(responseCard: card)),
    );
  }

  // 触发拖拽
  void _handleDragStarted(int index) {
    if (!isEditing) {
      toggleEditing();
    }
  }

  void _handleUpdatedDraggedChild(int index) {
    // ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Dragging child updated at $index!')));
  }

  void _handleReorder(ReorderedListFunction reorderedListFunction) {
    setState(() {
      _box = reorderedListFunction(_box) as List<ResponseCardModel>;
    });
  }

  void _handleDragEnd(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Dragging was finished at $index!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('冲动应对卡', style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
              onPressed: toggleEditing,
              icon: Icon(isEditing ? Icons.done : Icons.edit))
        ],
        backgroundColor: Color.fromARGB(255, 223, 221, 240),
      ),
      body: _getReorderableWidget(),
    );
  }
}
