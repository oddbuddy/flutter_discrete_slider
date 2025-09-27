import 'package:flutter/material.dart';

class DiscreteSliderController extends ChangeNotifier {
  int _currentStep = 0;

  int get currentStep => _currentStep;

  void moveTo(int step) {
    if (step != _currentStep) {
      _currentStep = step;
      notifyListeners();
    }
  }
}
