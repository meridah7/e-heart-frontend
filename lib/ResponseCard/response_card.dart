import 'package:flutter/material.dart';
import './response_card_model.dart';

class ResponseCard extends StatelessWidget {
  final ResponseCardModel responseCard;

  ResponseCard({Key? key, required this.responseCard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final scaleFactor = constraints.maxWidth / 132;

      return GestureDetector(
        child: Card(
          elevation: 0,
          clipBehavior: Clip.antiAlias, //
          surfaceTintColor: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Stack(children: [
                  Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                    image: AssetImage('assets/images/bg_1.jpg'), // 使用本地资源图片
                    fit: BoxFit.cover,
                  ))),
                  Positioned(
                      bottom: 16,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        width: constraints.maxWidth,
                        child: Text(
                          responseCard.custom_activity,
                          style: TextStyle(
                              fontSize: 12 * scaleFactor,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )),
                ]),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Text(
                    responseCard.details,
                    style: TextStyle(fontSize: 12 * scaleFactor),
                    maxLines: 3,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              // TODO：卡片位置指示器
              // Stack(
              //   // 指示器
              //   children: [
              //     Container(
              //       height: 20,
              //     ),
              //     Positioned(
              //         child: Positioned(
              //       bottom: 0,
              //       right: 0,
              //       child: Text('222'),
              //     ))
              //   ],
              // ),
            ],
          ),
        ),
      );
    });
  }
}
