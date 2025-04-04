import 'package:flutter/material.dart';
import 'package:namer_app/models/strategy_card.dart';
import 'dart:math' as math;
import 'dart:ui' show lerpDouble;

class EditCardDialog extends StatefulWidget {
  const EditCardDialog({
    super.key,
    required this.card,
    required this.onSave,
    required this.scene,
  });

  final StrategyCard card;
  final Function(StrategyCard) onSave;
  final DetailScene scene;

  @override
  _EditCardDialogState createState() => _EditCardDialogState();
}

class _EditCardDialogState extends State<EditCardDialog> {
  late TextEditingController _customActivityController;
  late TextEditingController _detailsController;
  bool _isEditing = false;
  DetailScene _scene = DetailScene.check;

  @override
  void initState() {
    super.initState();
    _scene = widget.scene;
    if (_scene != DetailScene.check) {
      _isEditing = true;
    }
    _customActivityController =
        TextEditingController(text: widget.card.customActivity);
    _detailsController = TextEditingController(text: widget.card.details);
  }

  @override
  void dispose() {
    _customActivityController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  Widget _buildTitleField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: _isEditing
          ? TextField(
              controller: _customActivityController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                _customActivityController.text,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
    );
  }

  Widget _buildDetailsField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: _isEditing
          ? TextField(
              controller: _detailsController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(12),
              ),
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
              ),
              maxLines: null,
              minLines: 3,
            )
          : Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                _detailsController.text,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                ),
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final maxWidth = math.min(325.0, size.width - 48.0);
    final maxHeight = size.height * 0.8;

    return Material(
      type: MaterialType.transparency,
      child: Stack(
        fit: StackFit.expand,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              color: Colors.black54,
            ),
          ),
          SafeArea(
            child: AnimatedPadding(
              padding: EdgeInsets.symmetric(
                vertical:
                    MediaQuery.of(context).viewInsets.bottom > 0 ? 0 : 24.0,
                horizontal: 24.0,
              ),
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              child: Center(
                child: Hero(
                  tag: 'card-${widget.card.id}-${widget.card.customActivity}',
                  createRectTween: (begin, end) {
                    return MaterialRectCenterArcTween(begin: begin, end: end);
                  },
                  flightShuttleBuilder: (
                    flightContext,
                    animation,
                    direction,
                    fromContext,
                    toContext,
                  ) {
                    return AnimatedBuilder(
                      animation: animation,
                      builder: (context, child) {
                        return Material(
                          color: Colors.white,
                          elevation: lerpDouble(0, 24, animation.value) ?? 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: SingleChildScrollView(
                            child: direction == HeroFlightDirection.push
                                ? toContext.widget
                                : fromContext.widget,
                          ),
                        );
                      },
                    );
                  },
                  child: Material(
                    color: Colors.white,
                    elevation: 24,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: maxWidth,
                        maxHeight: maxHeight,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AspectRatio(
                            aspectRatio: 0.9,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(16),
                                  ),
                                  child: Image.asset(
                                    'assets/images/bg_1.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withOpacity(0.5),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isEditing = !_isEditing;
                                        if (!_isEditing) {
                                          widget.onSave(StrategyCard(
                                            activityOrder:
                                                widget.card.activityOrder,
                                            customActivity:
                                                _customActivityController.text,
                                            details: _detailsController.text,
                                            id: widget.card.id,
                                          ));
                                        }
                                      });
                                    },
                                    icon: Icon(
                                      _isEditing ? Icons.done : Icons.edit,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 16,
                                  left: 16,
                                  right: 16,
                                  child: _buildTitleField(),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    const SizedBox(height: 8),
                                    _buildDetailsField(),
                                    const SizedBox(height: 16),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
