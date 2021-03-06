import 'dart:ui';

import 'package:flutter/material.dart';

class AnswerCard extends StatelessWidget {
  final String answer;
  final bool chosen;
  const AnswerCard({@required this.answer, @required this.chosen});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: chosen
                  ? Theme.of(context).colorScheme.primary
                  : Colors.transparent,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Text(
                answer,
                style: Theme.of(context).accentTextTheme.headline6.copyWith(
                    color: !chosen
                        ? Theme.of(context).colorScheme.onSurface
                        : Theme.of(context).colorScheme.onPrimary),
              ),
            )));
  }
}
