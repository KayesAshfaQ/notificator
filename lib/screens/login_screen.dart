import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:notificator/constants/app_colors.dart';
import 'package:notificator/constants/routes.dart';
import 'package:notificator/provider/auth_key_provider.dart';
import 'package:notificator/provider/login_provider.dart';
import 'package:notificator/provider/preference_provider.dart';
import 'package:notificator/util/utils.dart';
import 'package:notificator/generated/assets.dart';
import 'package:provider/provider.dart';

import '../constants/app_info.dart';
import '../provider/toast_provider.dart';
import '../util/keys.dart';
import '../widgets/text_input_field.dart';
import '../widgets/text_input_field_pass.dart';
import '../widgets/white_button_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final String token;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _mailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Utils.closeConfirm(context);
      },
      child: Scaffold(
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: TextButton(
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'BaiJamjuree',
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              kRouteForgetPassword,
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      width: double.infinity,
                      child: WhiteButtonWidget(
                        label: 'Login',
                        onPressed: login,
                      ),
                    ),
                  ],
                ),
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

      // initialize toast provider
      final toastProvider = context.read<ToastProvider>();
      toastProvider.initialize(context);

      // call the rest api through provider
      final provider = context.read<LoginProvider>();
      await provider.login(email, password);

      if (provider.success) {
        // Display a success toast
        toastProvider.showSuccessToast('login successful');

        // store the user key in shared preferences
        if (context.mounted) {
          final keyProvider = context.read<AuthKeyProvider>();
          debugPrint('token: ${provider.token}');
          keyProvider.setUserToken(provider.token);

          // store the user type & id in shared-preferences
          final prefProvider = context.read<PreferenceProvider>();
          debugPrint('user type: ${provider.data?.type}');
          prefProvider.setData(Keys.userType, '${provider.data?.type}');
          prefProvider.setData(Keys.userID, '${provider.data?.id}');
        }

        //Navigate to the home screen
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, kRouteHome);
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
