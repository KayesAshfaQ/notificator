import 'package:flutter/foundation.dart';

class SettingOptionProvider extends ChangeNotifier {
  bool _optionStatus = false;

  bool get optionStatus => _optionStatus;

  void setOptionStatus(bool value) {
    _optionStatus = value;
    notifyListeners();
  }
}
