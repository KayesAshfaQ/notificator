import 'package:flutter/material.dart';
import 'package:notificator/repository/group_repository.dart';

class GroupDeleteProvider with ChangeNotifier {
  bool _success = false;
  String _error = '';
  String _message = '';

  bool get success => _success;

  String get error => _error;

  String get token => _message;

  final GroupRepository _groupRepository = GroupRepository();

  Future<void> login(String id, String token) async {
    try {
      final response = await _groupRepository.delete(id, token);
      _success = response.success;

      if (success) {
        _message = response.message ?? '';
      } else {
        _error = response.errors ?? 'Login failed!';
      }
      notifyListeners();
    } catch (e) {
      _success = false;
      _error = e.toString();
      print(_error);
      notifyListeners();
    }
  }
}
