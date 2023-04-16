import 'package:flutter/foundation.dart';
import 'package:notificator/model/employee_list_response.dart';

class EmployeeChipProvider extends ChangeNotifier {
  final List<EmployeeListResponseData> _employeeList = [];
 final List<EmployeeListResponseData> _selectedEmployeeList = [];

  //bool isSubmitted = false;

  String _selectedEmployeeName = '';
  String _selectedEmployeeId = '';

  List<EmployeeListResponseData> get employeeList => _employeeList;

  List<EmployeeListResponseData> get selectedEmployee => _selectedEmployeeList;

  String get selectedEmployeeName => _selectedEmployeeName;

  String get selectedEmployeeId => _selectedEmployeeId;

  void setEmployeeList(List<EmployeeListResponseData> employeeList) {
    _employeeList.clear();
    _employeeList.addAll(employeeList);
    notifyListeners();
  }

  void addToSelectedEmployee(EmployeeListResponseData value) {
    _selectedEmployeeList.add(value);
    if (kDebugMode) {
      print('employeeList::: ${value.firstName}');
    }
    notifyListeners();
  }

  void removeFromSelectedEmployee(EmployeeListResponseData value) {
      _selectedEmployeeList.remove(value);
      notifyListeners();
  }



  void setSelectedEmplyeeName(String value) {
    _selectedEmployeeName = value;
    notifyListeners();
  }

  void setSelectedEmployeeId(String value) {
    _selectedEmployeeId = value;
    notifyListeners();
  }

  void clearSelectedEmployees() {
    _selectedEmployeeList.clear();
    _selectedEmployeeName = '';
    _selectedEmployeeId = '';
    //notifyListeners();
  }

}
