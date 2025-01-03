import 'package:flutter/material.dart';

class NavigationState extends ChangeNotifier {
  int _currentIndex = 0;
  bool _isPolish = true;

  int get currentIndex => _currentIndex;
  bool get isPolish => _isPolish; // Getter dla isPolish

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void toggleLanguage(bool value) {
    _isPolish = value;
    notifyListeners();
  }
}
