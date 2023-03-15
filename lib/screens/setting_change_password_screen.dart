import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:notificator/constants/app_colors.dart';
import 'package:notificator/widgets/my_appbar_widget.dart';
import 'package:provider/provider.dart';

import '../provider/auth_key_provider.dart';
import '../provider/password_change_provider.dart';
import '../provider/toast_provider.dart';
import '../util/helper.dart';
import '../widgets/text_input_field_pass.dart';
import '../widgets/white_button_widgets.dart';

class SettingChangePasswordScreen extends StatefulWidget {
  const SettingChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<SettingChangePasswordScreen> createState() =>
      _SettingChangePasswordScreenState();
}

class _SettingChangePasswordScreenState
    extends State<SettingChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();

  late final String token;

  @override
  void initState() {
    // initialize late fields

    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBarWidget(
        title: 'Change Password',
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          children: [
            TextFieldPasswordWidget(
              controller: _passwordController,
              hintText: 'Current Password',
              color: AppColors.deepPurple,
              backgroundColor: AppColors.purple_100,
            ),
            const SizedBox(height: 12),
            TextFieldPasswordWidget(
              controller: _newPasswordController,
              hintText: 'New Password',
              color: AppColors.deepPurple,
              backgroundColor: AppColors.purple_100,
            ),
            const SizedBox(height: 12),
            TextFieldPasswordWidget(
              controller: _passwordConfirmController,
              hintText: 'Confirm Password',
              color: AppColors.deepPurple,
              backgroundColor: AppColors.purple_100,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                } else if (value.length < 8) {
                  return 'Password must be at least 8 characters';
                } else if (_newPasswordController.text != value) {
                  return 'password doesn\'t matched';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            WhiteButtonWidget(
              label: 'Update Password',
              color: AppColors.deepPurple,
              onPressed: updatePassword,
            ),
          ],
        ),
      ),
    );
  }

  void updatePassword() async {
    bool isValid = _formKey.currentState?.validate() ?? false;

    if (isValid) {
      // Display a progress loader
      context.loaderOverlay.show();

      // get data form text fields
      String oldPass = _passwordController.text.trim();
      String newPass = _passwordConfirmController.text.trim();

      // initialize toast provider
      final toastProvider = context.read<ToastProvider>();
      toastProvider.initialize(context);

      // initialize provider
      final provider = context.read<PassChangeProvider>();

      // get token
      token = await Helper.getToken(context);

      // call the rest api through provider
      await provider.logout(token, oldPass, newPass);

      // check if the submission was successful
      if (provider.success) {
        // Display a success toast
        toastProvider.showSuccessToast('password changed, successful');

        // Navigate to the previous/setting screen
        if (context.mounted) {
          Navigator.pop(context);
        }
      } else {
        // Display an error toast
        toastProvider.showErrorToast(provider.error);
      }

      // Hide the progress loader
      if (context.mounted) context.loaderOverlay.hide();
    }
  }
}
