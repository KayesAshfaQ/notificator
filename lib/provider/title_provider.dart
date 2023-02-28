import 'package:flutter/foundation.dart';

class AppProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setCurrentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }
}
