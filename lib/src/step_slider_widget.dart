import 'package:step_slider/src/step_slider_painter.dart';

import 'step_slider_controller.dart';
import 'package:flutter/material.dart';

class StepSlider extends StatefulWidget {
  final int steps;
  final ValueChanged<int> onChanged;
  final StepSliderController? controller;
  final List<String>? labels;
  final EdgeInsets? labelPadding;
  final TextStyle? labelTextStyle;
  final Color? inActiveTrackColor;
  final Color? activeTrackColor;
  final Color? activeColor;
  final Color? inActiveColor;
  final double? labelBorderRadius;
  final double height;
  final double? trackWidth;

  const StepSlider({
    super.key,
    required this.steps,
    required this.onChanged,
    this.controller,
    this.labels,
    this.labelPadding,
    this.labelTextStyle,
    this.inActiveTrackColor,
    this.activeTrackColor,
    this.activeColor,
    this.inActiveColor,
    this.labelBorderRadius,
    this.height = 28,
    this.trackWidth,
  }) : assert(steps > 0, "Steps must be greater than 0"),
       assert(
         labels == null || labels.length == steps + 1,
         "Labels length must equal steps",
       );

  @override
  State<StepSlider> createState() => StepSliderState();
}

class StepSliderState extends State<StepSlider> {
  late StepSliderController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? StepSliderController();
    _controller.addListener(_handleControllerUpdate);
  }

  @override
  void dispose() {
    _controller.removeListener(_handleControllerUpdate);
    super.dispose();
  }

  void _handleControllerUpdate() {
    setState(() {});
    widget.onChanged(_controller.currentStep);
  }

  void _updateStep(Offset localPosition, double width) {
    double stepWidth = width / widget.steps;
    int newStep = (localPosition.dx / stepWidth).round().clamp(0, widget.steps);
    _controller.moveTo(newStep);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        _updateStep(details.localPosition, context.size?.width ?? 0);
      },
      onTapUp: (details) {
        _updateStep(details.localPosition, context.size?.width ?? 0);
      },
      child: SizedBox(
        height: widget.height,
        width: double.infinity,
        child: CustomPaint(
          painter: StepSliderPainter(
            steps: widget.steps,
            currentStep: _controller.currentStep,
            labels: widget.labels,
            labelTextStyle: widget.labelTextStyle,
            inActiveTrackColor: widget.inActiveTrackColor,
            activeTrackColor: widget.activeTrackColor,
            activeColor: widget.activeColor,
            inActiveColor: widget.inActiveColor,
            labelPadding: widget.labelPadding,
            labelBorderRadius: widget.labelBorderRadius,
            trackWidth: widget.trackWidth,
          ),
        ),
      ),
    );
  }
}
