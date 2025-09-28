import 'package:flutter/material.dart';

/// A controller that manages and notifies about the current step
/// of a [DiscreteSlider].
class DiscreteSliderController extends ChangeNotifier {
  int _currentStep = 0;

  /// The currently selected step.
  int get currentStep => _currentStep;

  /// Moves the slider to the given [step] and notifies listeners if changed.
  void moveTo(int step) {
    if (step != _currentStep) {
      _currentStep = step;
      notifyListeners();
    }
  }
}
