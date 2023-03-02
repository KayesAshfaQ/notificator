import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../util/utils.dart';

class EmployeeProfileCardWidget extends StatelessWidget {
  const EmployeeProfileCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                children: const [
                  Text(
                    'Name',
                    style: Utils.myTxtStyleTitleSmall,
                  ),
                  Text(
                    'John Doe',
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
                children: const [
                  Text(
                    'Email',
                    style: Utils.myTxtStyleTitleSmall,
                  ),
                  Text(
                    'example@email.com',
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
                children: const [
                  Text(
                    'Phone',
                    style: Utils.myTxtStyleTitleSmall,
                  ),
                  Text(
                    '+880 17065-24797',
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
                children: const [
                  Text(
                    'Position',
                    style: Utils.myTxtStyleTitleSmall,
                  ),
                  Text(
                    'Developer',
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
