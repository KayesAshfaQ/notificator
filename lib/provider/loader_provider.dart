import 'package:flutter/foundation.dart';

class LoaderProvider extends ChangeNotifier {
  bool _finishLoading = true;

  bool get finishLoading => _finishLoading;

  void setLoading(bool value) {
    _finishLoading = value;
    notifyListeners();
  }
}
