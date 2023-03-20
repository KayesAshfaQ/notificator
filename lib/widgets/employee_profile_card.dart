import 'package:flutter/material.dart';
import 'package:notificator/model/home_response_employee.dart';

import '../constants/app_colors.dart';
import '../util/utils.dart';

class EmployeeProfileCardWidget extends StatelessWidget {
  final Employee? employee;

  const EmployeeProfileCardWidget({
    super.key,
    this.employee,
  });

  @override
  Widget build(BuildContext context) {
    String name = '${employee?.firstName} ${employee?.lastName}';
    String email = employee?.email ?? '';
    String phone = employee?.phone ?? '';
    String position = employee?.position ?? '';

    return Container(
      decoration: BoxDecoration(
        color: AppColors.purple_100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Name',
                    style: Utils.myTxtStyleTitleSmall,
                  ),
                  Text(
                    name,
                    style: Utils.myTxtStyleBodySmall,
                  ),
                ],
              ),
            ),
            Divider(
              height: 2,
              thickness: 1,
              color: Colors.grey.shade300,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Email',
                    style: Utils.myTxtStyleTitleSmall,
                  ),
                  Text(
                    email,
                    style: Utils.myTxtStyleBodySmall,
                  ),
                ],
              ),
            ),
            Divider(
              height: 2,
              thickness: 1,
              color: Colors.grey.shade300,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Phone',
                    style: Utils.myTxtStyleTitleSmall,
                  ),
                  Text(
                    phone,
                    style: Utils.myTxtStyleBodySmall,
                  ),
                ],
              ),
            ),
            Divider(
              height: 2,
              thickness: 1,
              color: Colors.grey.shade300,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Position',
                    style: Utils.myTxtStyleTitleSmall,
                  ),
                  Text(
                    position,
                    style: Utils.myTxtStyleBodySmall,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
