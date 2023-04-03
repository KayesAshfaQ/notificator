import 'package:flutter/foundation.dart';

class SendToOptionProvider extends ChangeNotifier {
  // 1 = individual, 2 = group
  int _selectedOption = 1;

  int get selectedOption => _selectedOption;

  void setSelectedOption(int value) {
    _selectedOption = value;
    notifyListeners();
  }
}
