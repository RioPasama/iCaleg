import 'dart:math';
import 'package:flutter/material.dart';
import 'package:icaleg/infrastructure/theme/theme_utils.dart';

class ChartDoughnutView extends CustomPainter {
  final double data1Value;
  final double data2Value;

  ChartDoughnutView({
    required this.data1Value,
    required this.data2Value,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width * 0.5;
    const double strokeWidth = 80.0;
    const double startAngle = pi;

    final double sweepAngle1 = data1Value * pi;
    final double sweepAngle2 = data2Value * pi;

    final Rect outerRect =
        Rect.fromCircle(center: Offset(radius, radius), radius: radius);
    final Rect innerRect = Rect.fromCircle(
        center: Offset(radius, radius), radius: radius - strokeWidth * 0.5);

    final Paint fillPaint1 = Paint()..color = Colors.blue.withOpacity(0.6);
    final Paint fillPaint3 = Paint()..color = colorPrimary;
    final Paint fillPaint2 = Paint()..color = Colors.green.withOpacity(0.6);
    // const TextStyle textStyle = TextStyle(
    //   color: Colors.black,
    //   fontSize: 16.0,
    // );

    // Draw data 1
    canvas.drawArc(outerRect, startAngle, sweepAngle1, true, fillPaint1);

    // Draw data 2
    canvas.drawArc(
        outerRect, startAngle + sweepAngle1, sweepAngle2, true, fillPaint2);

    // Draw white inner arc
    canvas.drawArc(
        innerRect, startAngle, sweepAngle1 + sweepAngle2, true, fillPaint3);

    // Display data values
    // final double centerX = size.width * 0.5;
    // final double centerY = size.height * 0.5;
    // final double data1ValueDegrees = sweepAngle1 * 180 / pi;
    // final double data2ValueDegrees = sweepAngle2 * 180 / pi;

    // final String data1ValueText = '${(data1Value * 100).toStringAsFixed(2)}%';
    // final String data2ValueText = '${(data2Value * 100).toStringAsFixed(2)}%';

    // Display data 1 value
    // final Offset data1TextOffset = Offset(
    //   centerX + radius * cos(-data1ValueDegrees / 2),
    //   centerY + radius * sin(-data1ValueDegrees / -2),
    // );
    // drawText(canvas, data1ValueText, data1TextOffset, textStyle);

    // Display data 2 value
    // final Offset data2TextOffset = Offset(
    //   centerX + radius * cos(data2ValueDegrees / 2),
    //   centerY + radius * sin(data2ValueDegrees / 2),
    // );
    // drawText(canvas, data2ValueText, data2TextOffset, textStyle);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

  void drawText(
      Canvas canvas, String text, Offset offset, TextStyle textStyle) {
    final TextSpan span = TextSpan(text: text, style: textStyle);
    final TextPainter textPainter = TextPainter(
      text: span,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    final Offset textOffset = Offset(
      offset.dx - textPainter.width / 2,
      offset.dy - textPainter.height / 2,
    );
    textPainter.paint(canvas, textOffset);
  }
}
