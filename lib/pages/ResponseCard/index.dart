import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:namer_app/models/strategy_card.dart';
import 'package:namer_app/pages/ResponseCard/widgets/response_card.dart';
import 'package:namer_app/providers/strategy_list_data.dart';
import 'package:flutter_reorderable_grid_view/widgets/widgets.dart';

import 'hero_dialog_route.dart';
import 'widgets/edit_card_dialog.dart';
import 'widgets/editable_card.dart';

class ResponseCardPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<ResponseCardPage> createState() => _ResponseCardPageState();
}

class _ResponseCardPageState extends ConsumerState<ResponseCardPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final _gridViewKey = GlobalKey();
  bool _isEditing = false;
  final _scrollController = ScrollController();
  late final StrategyListData _strategyListController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

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

  @override
  void initState() {
    super.initState();
    _strategyListController = ref.read(strategyListDataProvider.notifier);
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    )..repeat(reverse: true);
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

  // 确认删除弹窗
  Future<void> showDeleteConfirmationDialog(
      BuildContext context, StrategyCard card) async {
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
              onPressed: () async {
                await _strategyListController.deleteStrategy(card);
                Navigator.of(context).pop(); // 关闭对话框
              },
            ),
          ],
        );
      },
    );
  }

  // 详情弹窗
  void _openEditDialog(
      BuildContext context, StrategyCard card, DetailScene scene) {
    Navigator.of(context).push(HeroDialogRoute(
      builder: (context) {
        return EditCardDialog(
          card: card,
          onSave: (saveCard) async {
            try {
              await ref
                  .read(strategyListDataProvider.notifier)
                  .updateStrategy(saveCard);
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('保存成功')),
                );
                Navigator.of(context)
                    .pop(); // Close dialog after successful save
              }
            } catch (e) {
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('保存失败: $e')),
                );
              }
            }
          },
          scene: scene,
        );
      },
    ));
  }

  // 列表重新排序
  void _handleReorder(ReorderedListFunction reorderedListFunction) async {
    try {
      final cardList = ref.watch(strategyListDataProvider);

      // Handle the AsyncValue state properly
      cardList.whenData((currentList) async {
        final reorderedList =
            reorderedListFunction(currentList) as List<StrategyCard>;
        await _strategyListController.reorderStrategies(reorderedList);
      });
    } catch (e) {
      debugPrint('Error in reorder: $e');
      // Consider showing a snackbar or dialog to inform the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('重新排序失败: $e')),
      );
    }
  }

  // 应对卡列表容器
  Widget _getReorderableWidget() {
    final cardList = ref.watch(strategyListDataProvider);
    return cardList.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
      data: (value) {
        final generatedChildren = _getGeneratedChildren(value);
        return ReorderableBuilder(
          key: Key(_gridViewKey.toString()),
          onReorder: _handleReorder,
          scrollController: _scrollController,
          enableLongPress: true,
          nonDraggableIndices: [value.length],
          lockedIndices: [value.length],
          builder: (children) {
            return GridView.builder(
              key: _gridViewKey,
              controller: _scrollController,
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                childAspectRatio: 9 / 16,
              ),
              itemCount: children.length,
              itemBuilder: (context, index) => children[index],
            );
          },
          children: generatedChildren,
        );
      },
    );
  }

  //  应对卡列表
  List<Widget> _getGeneratedChildren(List<StrategyCard> list) {
    var length = _isEditing ? list.length + 1 : list.length;
    return List<Widget>.generate(length, (index) {
      if (_isEditing && index == list.length) {
        return Card(
          key: ValueKey('add-card-$index'), // Unique key for add card
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: Colors.white60,
          child: IconButton(
            key: ValueKey('add-button-$index'), // Unique key for button
            onPressed: () async {
              bool res = await _strategyListController.addNewStrategy();
              if (res) {
                final cardList = ref.read(strategyListDataProvider);
                cardList.whenData((value) {
                  StrategyCard card = value.last;
                  _openEditDialog(context, card, DetailScene.edit);
                });
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('添加失败')),
                );
              }
            },
            icon: const Icon(
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
  Widget _getChild({required int index, required StrategyCard card}) {
    return Container(
      key: ValueKey('container-${card.id}'),
      child: ReorderableDragStartListener(
        key: ValueKey('drag-${card.id}'),
        index: index,
        child: EditableCard(
          key: ValueKey('editable-${card.id}'),
          isEditing: _isEditing,
          onDelete: () {
            showDeleteConfirmationDialog(context, card);
          },
          child: GestureDetector(
            onTap: () {
              ref.read(strategyListDataProvider).whenData((list) {
                if (index < list.length) {
                  _openEditDialog(context, list[index], DetailScene.check);
                }
              });
            },
            child: Hero(
              tag: 'card-${card.id}-${card.customActivity}',
              child: ResponseCard(
                key: ValueKey('response-${card.id}'),
                responseCard: card,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // _cardList = ref.watch(strategyListProvider.notifier);

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
