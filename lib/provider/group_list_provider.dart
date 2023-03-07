import 'package:flutter/material.dart';

import '../model/group_list_response.dart';
import '../repository/group_repository.dart';

class GroupListProvider with ChangeNotifier {
  bool _success = false;
  String _error = '';
  List<GroupListResponseData>? _data;

  bool get success => _success;

  String get error => _error;

  List<GroupListResponseData>? get data => _data;

  final GroupRepository _groupRepository = GroupRepository();

  /// This method is for submitting the email to the repository
  Future<void> getList(String token) async {
    try {
      final response = await _groupRepository.getGroups(token);
      _success = response.success;

      if (success) {
        _data = response.data;
        notifyListeners();
      } else {
        _error = response.errors!;
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
      _success = false;
      _error = e.toString();
      notifyListeners();
    }
  }
}
