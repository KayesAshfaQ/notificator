import 'package:flutter/material.dart';
import 'package:notificator/constants/app_colors.dart';
import 'package:notificator/widgets/my_appbar_widget.dart';

import '../widgets/text_input_field_pass.dart';
import '../widgets/white_button_widgets.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBarWidget(
        title: 'Change Password',
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        children: <Widget>[
          TextFieldPasswordWidget(
            hintText: 'Current Password',
            color: AppColors.deepPurple,
            backgroundColor: AppColors.lightPurple.withOpacity(0.5),
          ),
          const SizedBox(height: 12),
          TextFieldPasswordWidget(
            hintText: 'New Password',
            color: AppColors.deepPurple,
            backgroundColor: AppColors.lightPurple.withOpacity(0.5),
          ),
          const SizedBox(height: 12),
          TextFieldPasswordWidget(
            hintText: 'Confirm Password',
            color: AppColors.deepPurple,
            backgroundColor: AppColors.lightPurple.withOpacity(0.5),
          ),
          const SizedBox(height: 20),
          WhiteButtonWidget(
            label: 'Update Password',
            color: AppColors.deepPurple,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
