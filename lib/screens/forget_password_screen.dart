import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:notificator/constants/routes.dart';
import 'package:notificator/provider/forgot_pass_provider.dart';
import 'package:provider/provider.dart';

import '../constants/app_colors.dart';
import '../constants/app_info.dart';
import '../util/utils.dart';
import '../generated/assets.dart';
import '../widgets/text_input_field.dart';
import '../widgets/toast_widget.dart';
import '../widgets/white_button_widgets.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late final FToast fToast;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _mailController = TextEditingController();
  static const double _widthPadding = 24.0;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  void dispose() {
    _mailController.dispose();
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
                  'Forget Password',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontFamily: 'BaiJamjuree',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: _widthPadding),
                  child: Text(
                    'Enter your email address associated with your account we will send you an OTP to reset your password',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontFamily: 'BaiJamjuree',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Container(
                    //width: 300,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: TextFieldWidget(
                      controller: _mailController,
                      hintText: 'Email Address',
                      validator: (value) {
                        final bool emailValid =
                            Utils.emailRegex.hasMatch(value);

                        if (value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!emailValid) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: WhiteButtonWidget(
                    label: 'Submit',
                    onPressed: submit,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void submit() async {
    String email = _mailController.text.trim();

    bool isValid = _formKey.currentState?.validate() ?? false;

    if (isValid) {
      // Display a progress loader
      context.loaderOverlay.show();

      // call the rest api through provider
      final provider = context.read<ForgotPassProvider>();
      await provider.submit(email);

      // check if the submission was successful
      if (provider.success) {
        // Display a success toast
        fToast.showToast(
          child: const ToastWidget(
            message: 'submission successful, check your email',
            iconData: Icons.check,
            backgroundColor: Colors.green,
          ),
        );

        // Navigate to the Login screen
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, kRouteLogin);
        }
      } else {
        // Display an error toast
        fToast.showToast(
          child: ToastWidget(
            message: provider.error,
            iconData: Icons.error_outline,
            backgroundColor: Colors.red,
          ),
          //toastDuration: const Duration(seconds: 20),
        );
      }

      // Hide the progress loader
      if (context.mounted) context.loaderOverlay.hide();
    }
  }
}
