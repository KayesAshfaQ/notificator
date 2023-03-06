import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:notificator/constants/app_colors.dart';
import 'package:notificator/constants/routes.dart';
import 'package:notificator/provider/auth_key_provider.dart';
import 'package:notificator/provider/login_provider.dart';
import 'package:notificator/util/utils.dart';
import 'package:notificator/generated/assets.dart';
import 'package:provider/provider.dart';

import '../constants/app_info.dart';
import '../widgets/text_input_field.dart';
import '../widgets/text_input_field_pass.dart';
import '../widgets/toast_widget.dart';
import '../widgets/white_button_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final FToast fToast;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  void dispose() {
    _mailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                    'Account Login',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontFamily: 'BaiJamjuree',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    //width: 300,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: TextFieldWidget(
                      hintText: 'Email',
                      controller: _mailController,
                      validator: (value) {
                        final bool emailValid =
                            Utils.emailRegex.hasMatch(value);

                        if (value == null) {
                          return 'Please enter your email';
                        } else if (!emailValid) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: TextFieldPasswordWidget(
                      hintText: 'Password',
                      controller: _passwordController,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: GestureDetector(
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'BaiJamjuree',
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            kRouteForgetPassword,
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    width: double.infinity,
                    child: WhiteButtonWidget(
                      label: 'Login',
                      onPressed: login,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Don\'t have an account? ',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'BaiJamjuree',
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, kRouteRegister);
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: AppColors.orange,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'BaiJamjuree',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void login() async {
    String email = _mailController.text.trim();
    String password = _passwordController.text.trim();

    bool isValid = _formKey.currentState?.validate() ?? false;

    if (isValid) {
      // Display a progress loader
      context.loaderOverlay.show();

      // call the rest api through provider
      final provider = context.read<LoginProvider>();
      await provider.login(email, password);

      if (provider.success) {
        // Display a success toast
        fToast.showToast(
          child: const ToastWidget(
            message: 'Login successful',
            iconData: Icons.check,
            backgroundColor: Colors.green,
          ),
        );

        // store the user key in shared preferences
        if (context.mounted) {
          final keyProvider = context.read<AuthKeyProvider>();
          keyProvider.setUserToken(provider.token);
        }

        // Navigate to the OTP screen
        if (context.mounted) Navigator.pushReplacementNamed(context, kRouteOtp);
      } else {
        // Display an error toast
        fToast.showToast(
          child: ToastWidget(
            message: provider.error,
            iconData: Icons.error_outline,
            backgroundColor: Colors.red,
          ),
        );
      }

      // Hide the progress loader
      if (context.mounted) context.loaderOverlay.hide();
    }
  }
}
