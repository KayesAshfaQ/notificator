import 'package:flutter/material.dart';
import 'package:notificator/repository/create_group_repository.dart';

import '../model/crate_group_response.dart';

class CreateGroupProvider with ChangeNotifier {
  bool _success = false;
  String _error = '';
  CrateGroupResponseData? _data;

  bool get success => _success;

  String get error => _error;

  CrateGroupResponseData? get data => _data;

  final CreateGroupRepository _createGroupRepository = CreateGroupRepository();

  /// This method is for submitting the email to the repository
  Future<void> create(String name, String token) async {
    print(name);

    try {
      final response = await _createGroupRepository.create(name, token);
      _success = response.success;

      if (success) {
        _data = response.data;
      } else {
        _error = response.errors.toString();
      }
      notifyListeners();
    } catch (e) {
      print(e.toString());
      _success = false;
      _error = e.toString();
      notifyListeners();
    }
  }
}
