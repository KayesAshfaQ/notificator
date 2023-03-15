import 'package:flutter/material.dart';
import 'package:notificator/model/company.dart';
import 'package:notificator/repository/company_repository.dart';

class CompanyUpdateProvider with ChangeNotifier {
  bool _success = false;
  String _error = '';
  Company? _data;

  bool get success => _success;

  String get error => _error;

  Company? get data => _data;

  final CompanyRepository _companyRepository = CompanyRepository();

  /// This method is for creating new group
  Future<void> update(Company company, String token, int id) async {
    try {
      final response = await _companyRepository.update(company, token, id);
      _success = response.success;

      if (success) {
        _data = response.data;
      } else {
        _error = response.errors!;
      }
      notifyListeners();
    } catch (e) {
      print('EmployeeCreateProvider:::${e.toString()}');
      _success = false;
      _error = e.toString();
      notifyListeners();
    }
  }
}
