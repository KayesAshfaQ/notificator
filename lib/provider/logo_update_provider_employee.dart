import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:notificator/model/logo_update_response.dart';

import 'package:notificator/repository/employee_update_repository.dart';

class EmployeePhotoUpdateProvider with ChangeNotifier {
  bool _success = false;
  String? _error;
  Data? _data;

  bool get success => _success;

  String? get error => _error;

  Data? get data => _data;

  final EmployeeUpdateRepository _employeeRepository =
      EmployeeUpdateRepository();

  /// This method is for creating new group
  Future<void> update(String token, String id, File photo) async {
    try {
      final response = await _employeeRepository.updatePhoto(token, id, photo);
      _success = response.success ?? false;

      if (success) {
        _data = response.data;
      } else {
        _error = 'image upload failed!';
      }
      notifyListeners();
    } catch (e) {
      if (kDebugMode) print('EmployeePhotoUpdateProvider:::${e.toString()}');
      _success = false;
      _error = e.toString();
      notifyListeners();
    }
  }
}
