import 'package:discrete_slider/src/discrete_slider_painter.dart';

import 'discrete_slider_controller.dart';
import 'package:flutter/material.dart';

/// A customizable discrete step-based slider widget.
///
/// This widget displays a horizontal slider with [steps] evenly distributed
/// positions. It supports custom labels, colors, and styles, making it
/// suitable for ratings, progress indicators, or settings.
class DiscreteSlider extends StatefulWidget {
  /// Total number of steps in the slider (must be > 0).
  final int steps;

  /// Called whenever the slider value changes.
  final ValueChanged<int> onChanged;

  /// Optional controller to programmatically change the step.
  final DiscreteSliderController? controller;

  /// Optional labels for each step. Must have [steps] + 1 entries if provided.
  final List<String>? labels;

  /// Padding inside each label.
  final EdgeInsets? labelPadding;

  /// Text style for labels.
  final TextStyle? labelTextStyle;

  /// Track color for inactive portion.
  final Color? inActiveTrackColor;

  /// Track color for active portion.
  final Color? activeTrackColor;

  /// Fill color for the active step.
  final Color? activeColor;

  /// Fill color for inactive steps.
  final Color? inActiveColor;

  /// Border radius for labels or step indicators.
  final double? labelBorderRadius;

  /// Height of the slider widget.
  final double height;

  /// Stroke width of the track.
  final double? trackWidth;

  /// Creates a [DiscreteSlider].
  ///
  /// The [steps] parameter must be greater than 0.
  /// If [labels] is provided, its length must equal [steps] + 1.
  const DiscreteSlider({
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
  State<DiscreteSlider> createState() => DiscreteSliderState();
}

class DiscreteSliderState extends State<DiscreteSlider> {
  late DiscreteSliderController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? DiscreteSliderController();
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
          painter: DiscreteSliderPainter(
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
