import "package:flutter/material.dart";
import "./response_card_model.dart";

class ResponseCard extends StatelessWidget {
  final ResponseCardModel responseCard;

  ResponseCard({super.key, required this.responseCard});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
      height: 200.0,
      width: 100.0,
      child: Column(children: [
        Icon(Icons.favorite),
        Text(responseCard.custom_activity),
        Text(responseCard.details),
        Text(responseCard.activity_order.toString()),
      ]),
    );
  }
}
