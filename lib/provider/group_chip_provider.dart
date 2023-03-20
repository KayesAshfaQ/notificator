import 'package:flutter/foundation.dart';

import '../model/group_list_response.dart';

// A list of dummy groups
//final List<String> dummyGroups = List.generate(50, (index) => 'Group $index');

class GroupChipProvider extends ChangeNotifier {
  final List<GroupListResponseData> _groupList = [];
  final List<GroupListResponseData> _selectedGroupList = [];

  //bool isSubmitted = false;

  String _selectedGroupName = '';
  String _selectedGroupId = '';

  List<GroupListResponseData> get groupList => _groupList;

  List<GroupListResponseData> get selectedGroupList => _selectedGroupList;

  String get selectedGroupName => _selectedGroupName;

  String get selectedGroupId => _selectedGroupId;

  void setGroupList(List<GroupListResponseData> groupList) {
    _groupList.clear();
    _groupList.addAll(groupList);
    notifyListeners();
  }

  void addToSelectedGroup(GroupListResponseData value) {
    _selectedGroupList.add(value);
    print('groupList::: ${selectedGroupList.length}');
    notifyListeners();
  }

  void removeFromSelectedGroup(GroupListResponseData value) {
    _selectedGroupList.remove(value);
    notifyListeners();
  }

  void setSelectedGroupName(String value) {
    _selectedGroupName = value;
    notifyListeners();
  }

  void setSelectedGroupId(String value) {
    _selectedGroupId = value;
    notifyListeners();
  }

  void clearSelectedGroups() {
    _selectedGroupList.clear();
    _selectedGroupName = '';
    _selectedGroupId = '';
    //notifyListeners();
  }
}
