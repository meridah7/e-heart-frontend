import "package:flutter/material.dart";
import 'response_card_model.dart';

class EditCardDialog extends StatefulWidget {
  final ResponseCardModel card;
  final Function(ResponseCardModel) onSave;
  final DetailScene scene;

  EditCardDialog(
      {required this.card, required this.onSave, required this.scene});

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
    _scene = _scene = widget.scene;
    if (_scene != DetailScene.check) {
      _isEditing = true;
    }
    _customActivityController =
        TextEditingController(text: widget.card.custom_activity);
    _detailsController = TextEditingController(text: widget.card.details);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(32.0),
      child: Hero(
          tag:
              'card-${widget.card.activity_order.toString() + widget.card.custom_activity}',
          child: Center(
            child: Container(
              width: 325,
              height: 565,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(16)),
              child: Material(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 325,
                      height: 360,
                      child: Stack(
                        children: [
                          // 背景图片
                          Positioned(
                              width: 325,
                              height: 360,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16)),
                                child: Image.asset(
                                  'assets/images/bg_1.jpg',
                                  fit: BoxFit.cover,
                                ),
                              )),
                          Positioned(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () => {
                                        // 编辑状态
                                        setState(() {
                                          _isEditing = !_isEditing;
                                          if (!_isEditing) {
                                            widget.onSave(ResponseCardModel(
                                              activity_order:
                                                  widget.card.activity_order,
                                              custom_activity:
                                                  _customActivityController
                                                      .text,
                                              details: _detailsController.text,
                                              id: widget.card.id,
                                            ));
                                          }
                                        })
                                      },
                                  icon: _isEditing
                                      ? Icon(
                                          Icons.done,
                                          color: Colors.white,
                                        )
                                      : Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ))
                            ],
                          )),
                          Positioned(
                            width: 325,
                            bottom: 32,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: InkWell(
                                child: _isEditing
                                    ? TextField(
                                        controller: _customActivityController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                        onEditingComplete: () {
                                          widget.onSave(ResponseCardModel(
                                            activity_order:
                                                widget.card.activity_order,
                                            custom_activity:
                                                _customActivityController.text,
                                            details: _detailsController.text,
                                            id: widget.card.id,
                                          ));
                                        },
                                      )
                                    : Text(
                                        _customActivityController.text,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Expanded(
                        child: InkWell(
                          child: _isEditing
                              ? TextField(
                                  controller: _detailsController,
                                  decoration: InputDecoration(
                                      alignLabelWithHint: true,
                                      border: OutlineInputBorder(),
                                      fillColor: Colors.black),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                  maxLines: null,
                                  keyboardType: TextInputType.multiline,
                                  onEditingComplete: () {
                                    widget.onSave(ResponseCardModel(
                                      activity_order:
                                          widget.card.activity_order,
                                      custom_activity:
                                          _customActivityController.text,
                                      details: _detailsController.text,
                                      id: widget.card.id,
                                    ));
                                  },
                                )
                              : Text(
                                  _detailsController.text,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    ));
  }

  @override
  void dispose() {
    _customActivityController.dispose();
    _detailsController.dispose();
    super.dispose();
  }
}
