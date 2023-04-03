import 'package:flutter/foundation.dart';
import 'package:notificator/model/employee_list_response.dart';

class EmployeeChipProvider extends ChangeNotifier {
  final List<EmployeeListResponseData> _employeeList = [];
  EmployeeListResponseData? _selectedEmployee;

  //bool isSubmitted = false;

  List<EmployeeListResponseData> get employeeList => _employeeList;

  EmployeeListResponseData? get selectedEmployee => _selectedEmployee;

  void setEmployeeList(List<EmployeeListResponseData> employeeList) {
    _employeeList.clear();
    _employeeList.addAll(employeeList);
    notifyListeners();
  }

  void setSelectedEmployee(EmployeeListResponseData value) {
    _selectedEmployee = value;
    if (kDebugMode) {
      print('employeeList::: ${_selectedEmployee?.firstName}');
    }
    notifyListeners();
  }

  void removeSelectedEmployee() {
    if (_selectedEmployee != null) {
      _selectedEmployee = null;
      //notifyListeners();
    }
  }

  String getSelectedEmployeeName() {
    String name =
        '${_selectedEmployee?.firstName} ${_selectedEmployee?.lastName}';
    print(name);
    if (name == 'null null') name = '';

    return name;
  }

  String getSelectedEmployeeId() {
    return '${_selectedEmployee?.userId}';
  }
}
