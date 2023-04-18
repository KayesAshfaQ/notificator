import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:notificator/model/group_delete_response.dart';

import '../constants/app_info.dart';
import 'package:http/http.dart' as http;

import '../model/group_create_response.dart';
import '../model/group_list_response.dart';
import '../model/group_update_response.dart';

class GroupRepository {
  /// This method is used to submit the email to the server to send the password reset link
  Future<CreateGroupResponse> create(String name, String token) async {
    final url = Uri.parse('$kBaseUrl/groups');
    final response = await http.post(
      url,
      body: {'name': name},
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    //print(response.statusCode);
    final data = json.decode(response.body);
    if (kDebugMode) print(data);

    if (response.body.isNotEmpty) {
      final responseSuccess = CreateGroupResponse.fromJson(data);
      return responseSuccess;
    } else {
      throw Exception('failed!');
    }
  }

  /// This method is for getting the groups
  Future<GroupListResponse> getGroups(String token) async {
    final url = Uri.parse('$kBaseUrl/groups');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    final data = json.decode(response.body);
    if (kDebugMode) print(data);

    if (response.body.isNotEmpty) {
      final groupList = GroupListResponse.fromJson(data);
      if (kDebugMode) print(groupList);
      return groupList;
    } else {
      throw Exception('failed!');
    }
  }

  /// This method is for delete the group by id
  Future<GroupDeleteResponse> delete(int id, token) async {
    final url = Uri.parse('$kBaseUrl/groups/$id');
    final response = await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    //print(response.statusCode);
    final data = json.decode(response.body);
    if (kDebugMode) print(data);
    if (response.body.isNotEmpty) {
      return GroupDeleteResponse.fromJson(data);
    } else {
      throw Exception('Failed to login');
    }
  }

  /// This method is used to update the group name
  Future<UpdateGroupResponse> update(
      {required String name, required String token, required int id}) async {
    final url = Uri.parse('$kBaseUrl/groups/$id');
    final response = await http.put(
      url,
      body: {'name': name},
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    //print(response.statusCode);
    final data = json.decode(response.body);
    if (kDebugMode) print('update:::$data');
    if (response.body.isNotEmpty) {
      final responseSuccess = UpdateGroupResponse.fromJson(data);
      return responseSuccess;
    } else {
      throw Exception('failed!');
    }
  }
}
