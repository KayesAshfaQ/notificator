import 'package:flutter/foundation.dart';

// A list of dummy groups
final List<String> dummyGroups = List.generate(50, (index) => 'Group $index');

class GroupChipProvider extends ChangeNotifier {
  final List<String> _groupList = dummyGroups;
  final List<String> _selectedGroupList = [];

  List<String> get groupList => _groupList;

  List<String> get selectedGroupList => _selectedGroupList;

  void addToSelectedGroup(String value) {
    _selectedGroupList.add(value);
    notifyListeners();
  }

  void removeFromSelectedGroup(String value) {
    _selectedGroupList.remove(value);
    notifyListeners();
  }
}
