import 'package:flutter/foundation.dart';
import 'package:notificator/repository/group_repository.dart';

import '../model/group_create_response.dart';
import '../model/group_update_response.dart';

class GroupProvider with ChangeNotifier {
  bool _success = false;
  String _error = '';
  CreateGroupResponseData? _createData;
  GroupUpdateResponseData? _updateData;

  bool get success => _success;

  String get error => _error;

  CreateGroupResponseData? get createData => _createData;

  GroupUpdateResponseData? get updateData => _updateData;

  final GroupRepository _groupRepository = GroupRepository();

  /// This method is for creating new group
  Future<void> create(String name, String token) async {
    if (kDebugMode) print(name);

    try {
      final response = await _groupRepository.create(name, token);
      _success = response.success;

      if (success) {
        _createData = response.data;
      } else {
        _error = response.errors!;
      }
      notifyListeners();
    } catch (e) {
      if (kDebugMode) print(e.toString());
      _success = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  /// This method is for updating the group
  Future<void> update(String token, int id, String name) async {
    if (kDebugMode) print(name);

    try {
      final response = await _groupRepository.update(
        id: id,
        token: token,
        name: name,
      );
      _success = response.success;

      if (success) {
        _updateData = response.data;
      } else {
        _error = response.errors!;
      }
      notifyListeners();
    } catch (e) {
      if (kDebugMode) print(e.toString());
      _success = false;
      _error = e.toString();
      notifyListeners();
    }
  }
}
