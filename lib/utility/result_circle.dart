import 'dart:math';
import 'dart:ui' as ui;
import 'package:final_cs426/constants/color.dart';
import 'package:flutter/material.dart';

class ResultCircle extends StatelessWidget {
  final int questionCount;
  final int corrects;

  const ResultCircle({@required this.questionCount, @required this.corrects});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 300,
      child: Stack(children: [
        CustomPaint(
          foregroundPainter: _CircularProgress(corrects / questionCount * 100),
          child: SizedBox(
            height: 300,
            width: 300,
          ),
        ),
        Column(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "$corrects",
                  style: TextStyle(
                      fontFamily: "Open Sans",
                      color: correct,
                      fontSize: 100,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  SizedBox(
                    width: 50,
                    child: Divider(
                      color: correct,
                      thickness: 5,
                    ),
                  ),
                  Text(
                    "$questionCount",
                    style: TextStyle(
                        fontFamily: "Open Sans", color: correct, fontSize: 40),
                  )
                ],
              ),
            )
          ],
        )
      ]),
    );
  }
}

class _CircularProgress extends CustomPainter {
  double currentProgress;

  _CircularProgress(this.currentProgress);
  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2) - 10;

    Paint outerCircle = Paint()
      ..strokeWidth = 30
      ..color = Colors.black.withOpacity(0.15)
      ..style = PaintingStyle.stroke;

    Paint completeArc = Paint()
      ..strokeWidth = 30
      ..color = correct
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, outerCircle);

    double angle = 2 * pi * (currentProgress / 100);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        angle, false, completeArc);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
