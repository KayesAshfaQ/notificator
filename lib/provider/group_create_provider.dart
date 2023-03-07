import 'package:flutter/material.dart';
import 'package:notificator/repository/group_repository.dart';

import '../model/group_create_response.dart';

class CreateGroupProvider with ChangeNotifier {
  bool _success = false;
  String _error = '';
  CreateGroupResponseData? _data;

  bool get success => _success;

  String get error => _error;

  CreateGroupResponseData? get data => _data;

  final GroupRepository _createGroupRepository = GroupRepository();

  /// This method is for submitting the email to the repository
  Future<void> create(String name, String token) async {
    print(name);

    try {
      final response = await _createGroupRepository.create(name, token);
      _success = response.success;

      if (success) {
        _data = response.data;
      } else {
        _error = response.errors!;
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
