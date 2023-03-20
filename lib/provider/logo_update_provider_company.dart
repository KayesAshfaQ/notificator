import 'dart:io';

import 'package:flutter/material.dart';
import 'package:notificator/model/logo_update_response.dart';

import 'package:notificator/repository/company_repository.dart';

class CompanyLogoUpdateProvider with ChangeNotifier {
  bool _success = false;
  String? _error;
  Data? _data;

  bool get success => _success;

  String? get error => _error;

  Data? get data => _data;

  final CompanyRepository _companyRepository = CompanyRepository();

  /// This method is for creating new group
  Future<void> update(String token, String id, File logo) async {
    try {
      final response = await _companyRepository.updateLogo(token, id, logo);
      _success = response.success ?? false;

      if (success) {
        _data = response.data;
      } else {
        _error = 'image upload failed!';
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
