import 'package:flutter/foundation.dart';

class AppProvider extends ChangeNotifier {
  int _currentIndex = 0;
  String _title = 'Home';

  int get currentIndex => _currentIndex;

  String get title => _title;

  void setCurrentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }

  void setTitle(String value) {
    _title = value;
    notifyListeners();
  }

  void reset() {
    _currentIndex = 0;
    _title = 'Home';
   // notifyListeners();
  }
}
