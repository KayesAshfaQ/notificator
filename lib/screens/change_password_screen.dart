import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:notificator/constants/app_colors.dart';
import 'package:notificator/util/utils.dart';
import 'package:notificator/generated/assets.dart';
import 'package:provider/provider.dart';

import '../constants/app_info.dart';
import '../constants/routes.dart';
import '../provider/password_change_provider.dart';
import '../provider/toast_provider.dart';
import '../widgets/text_input_field_pass.dart';
import '../widgets/white_button_widgets.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  String? email, code;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  @override
  void didChangeDependencies() {
    // get the email and code from the route arguments if they are not set yet
    if (email == null && code == null) {
      final map =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

      email = map['email'];
      code = map['code'];
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: Utils.backGroundImage,
            fit: BoxFit.cover,
          ),
        ),
        height: double.infinity,
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SvgPicture.asset(
                    Assets.svgIconBellLarge,
                    height: 50,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    kAppTitle.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 22,
                      color: AppColors.lightOrange,
                      fontFamily: 'BaiJamjuree',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Your personal reminder'.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 8,
                      color: Colors.white,
                      fontFamily: 'BaiJamjuree',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Change Password',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontFamily: 'BaiJamjuree',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: TextFieldPasswordWidget(
                      controller: _passController,
                      validator: Utils.validatePassword,
                      hintText: 'New Password',
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: TextFieldPasswordWidget(
                      controller: _confirmPassController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 8) {
                          return 'Password must be at least 8 characters';
                        } else if (_passController.text != value) {
                          return 'password doesn\'t matched';
                        }
                        return null;
                      },
                      hintText: 'Confirm Password',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    width: double.infinity,
                    child: WhiteButtonWidget(
                      label: 'Update Password',
                      onPressed: resetPassword,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void resetPassword() async {
    bool isValid = _formKey.currentState?.validate() ?? false;

    if (isValid) {
      // Display a progress loader
      context.loaderOverlay.show();

      // get data form text fields
      String password = _confirmPassController.text.trim();

      // initialize toast provider
      final toastProvider = context.read<ToastProvider>();
      toastProvider.initialize(context);

      // initialize provider
      final provider = context.read<PassChangeProvider>();

      // call the rest api through provider
      await provider.resetPass(email!, code!, password);

      // check if the submission was successful
      if (provider.success) {
        // Display a success toast
        toastProvider.showSuccessToast('password successfully changed');

        // Navigate to the login screen
        if (context.mounted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            kRouteLogin,
            (Route<dynamic> route) => false,
          );
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
