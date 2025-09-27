import 'package:flutter/material.dart';

class DiscreteSliderPainter extends CustomPainter {
  final int steps;
  final int currentStep;
  final List<String>? labels;
  final TextStyle? labelTextStyle;
  final Color? inActiveTrackColor;
  final Color? activeTrackColor;
  final Color? activeColor;
  final Color? inActiveColor;
  final EdgeInsets? labelPadding;
  final double? labelBorderRadius;
  final double? trackWidth;

  DiscreteSliderPainter({
    required this.steps,
    required this.currentStep,
    this.labels,
    this.labelTextStyle,
    this.inActiveTrackColor,
    this.activeTrackColor,
    this.activeColor,
    this.inActiveColor,
    this.labelPadding,
    this.labelBorderRadius,
    this.trackWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint trackPaint = Paint()
      ..color = inActiveTrackColor ?? Colors.blueGrey.shade800
      ..strokeWidth = trackWidth ?? 4
      ..strokeCap = StrokeCap.round;

    Paint progressPaint = Paint()
      ..color = activeTrackColor ?? Colors.blue
      ..strokeWidth = trackWidth ?? 4
      ..strokeCap = StrokeCap.round;

    double stepWidth = size.width / (steps);
    double progressEnd = (currentStep) * stepWidth;

    // Draw track
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      trackPaint,
    );

    // Draw progress
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(progressEnd, size.height / 2),
      progressPaint,
    );

    canvas.drawCircle(
      Offset(0, size.height / 2),
      8,
      Paint()
        ..color = currentStep == 0
            ? const Color(0xFF6378A7)
            : Colors.transparent,
    );

    for (int i = 0; i <= steps; i++) {
      double x = i * stepWidth;
      double y = size.height / 2;

      String label;
      if (labels != null && i < labels!.length) {
        label = labels![i];
      } else {
        label = "$i";
      }

      // Draw text inside circles
      TextPainter tp = TextPainter(
        text: TextSpan(
          text: label,
          style:
              labelTextStyle ??
              const TextStyle(
                color: Colors.white,
                fontSize: 12,
                height: 1,
                fontWeight: FontWeight.w500,
              ),
        ),
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      final pad =
          labelPadding ??
          const EdgeInsets.symmetric(horizontal: 12, vertical: 8);

      Rect rect = Rect.fromCenter(
        center: Offset(x, y),
        width: tp.width + pad.horizontal,
        height: tp.height + pad.vertical,
      );
      bool isActive = i == currentStep;
      Paint labelPaint = Paint()
        ..color = isActive
            ? (activeColor ?? Colors.blue)
            : (inActiveColor ?? Colors.blueGrey.shade800);

      if (labels != null) {
        RRect rrect = RRect.fromRectAndRadius(
          rect,
          Radius.circular(labelBorderRadius ?? 12),
        );
        canvas.drawRRect(rrect, labelPaint);
      } else {
        // Draw circles
        canvas.drawCircle(Offset(x, y), labelBorderRadius ?? 12, labelPaint);
      }

      tp.paint(canvas, Offset(x - tp.width / 2, y - tp.height / 2));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
