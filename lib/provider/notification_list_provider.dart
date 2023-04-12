import 'package:flutter/material.dart';
import 'package:notificator/model/notification_data.dart';
import 'package:notificator/model/notification_list_response.dart';
import 'package:notificator/repository/notification_repository.dart';

class NotificationListProvider with ChangeNotifier {
  int _currentPage = 1;
  int _lastPage = 1;
  int _limit = 50;
  bool _isLoading = false;
  bool _success = false;
  String _error = '';

  // for sort & filet
  bool isSearch = false;
  String sortType = '';
  String filterTxt = '';

  List<NotificationData>? _data;

  int get currentPage => _currentPage;

  int get lastPage => _lastPage;

  int get limit => _limit;

  bool get isLoading => _isLoading;

  bool get success => _success;

  String get error => _error;

  List<NotificationData>? get data => _data;

  final NotificationRepository _notificationRepository =
      NotificationRepository();

  /// increment the page number
  void incrementPage() {
    if (_currentPage < _lastPage) _currentPage++;
    notifyListeners();
  }

  /// reset the page number
  void resetCurrentPage() {
    if (_data != null) _data!.clear();
    _currentPage = 1;

    //notifyListeners();
  }

  /// reset the search
  void resetSearch() {
    isSearch = false;
    sortType = '';
    filterTxt = '';
    notifyListeners();
  }

  /// set the limit
  void setLimit(int limit) {
    _limit = limit;
    notifyListeners();
  }

  /// set the loading state
  void setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  /// set the mark as read state
  void markAsRead(int index) {
    _data![index].readStatus = 'read';
    notifyListeners();
  }

  /// This method is for fetching the notifications form the repository
  Future<void> getList(String token, String userType) async {

    try {

      NotificationListResponse response;
      if (userType == '1') {
        response = await _notificationRepository.getNotifications(
          token,
          limit,
          currentPage,
        );
      } else {
        response =
            await _notificationRepository.getNotificationsEmployee(token, limit, currentPage);
      }

      _success = response.success;

      if (success) {
        if (_data == null) {
          _data = response.data;
        } else {
          _data!.addAll(response.data!);
        }
        _lastPage = response.lastPage ?? 1;
        notifyListeners();
      } else {
        _error = 'Failed to fetch the notifications!';
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
      _success = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  /// This method is for fetching the notifications form the repository
  Future<void> resetNotificationList(String token, String userType) async {
    try {
      NotificationListResponse response;
      if (userType == '1') {
        response = await _notificationRepository.getNotifications(
          token,
          limit,
          currentPage,
        );
      } else {
        response =
            await _notificationRepository.getNotificationsEmployee(token, limit, currentPage);
      }

      _success = response.success;

      if (success) {
        _data = response.data;
        _currentPage = 1;
        _lastPage = response.lastPage ?? 1;
        notifyListeners();
      } else {
        _error = 'Failed to fetch the notifications!';
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
      _success = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  /// This method is for fetching the notifications form the repository
  Future<void> notificationSearch(String token) async {
    try {
      NotificationListResponse response;

      response = await _notificationRepository.search(
          token, sortType, filterTxt, currentPage);

      _success = response.success;

      if (success) {
        if (_data == null) {
          _data = response.data;
        } else {
          _data!.addAll(response.data!);
        }
        _lastPage = response.lastPage ?? 1;
        notifyListeners();
      } else {
        _error = 'Failed to fetch the notifications!';
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
