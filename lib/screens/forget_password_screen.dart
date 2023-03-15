import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:notificator/constants/routes.dart';
import 'package:notificator/provider/forgot_pass_provider.dart';
import 'package:notificator/provider/toast_provider.dart';
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
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: Utils.backGroundImage,
            fit: BoxFit.cover,
          ),
        ),
        height: double.infinity,
        child: SafeArea(
          child: Stack(
            children: [
              // show screen close on top in ios device
              if (Platform.isIOS)
                Positioned(
                  top: 0,
                  left: 0,
                  child: IconButton(
                    onPressed: () {
                      print('back clicked');
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close_sharp,
                      color: AppColors.white,
                    ),
                  ),
                ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(height: 16),
                      SvgPicture.asset(
                        Assets.svgIconBellLarge,
                        height: 50,
                      ),
                      const SizedBox(height: 4),
                      Center(
                        child: Text(
                          kAppTitle.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 22,
                            color: AppColors.lightOrange,
                            fontFamily: 'BaiJamjuree',
                            fontWeight: FontWeight.w600,
                          ),
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
                      const SizedBox(height: 24),
                      const Text(
                        'Enter your email address associated with your account we will send you an OTP to reset your password',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontFamily: 'BaiJamjuree',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Form(
                        key: _formKey,
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
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: WhiteButtonWidget(
                          label: 'Submit',
                          onPressed: submit,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
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

      // toast
      final toastProvider = context.read<ToastProvider>();
      toastProvider.initialize(context);

      // call the rest api through provider
      final provider = context.read<ForgotPassProvider>();
      await provider.submit(email);

      // check if the submission was successful
      if (provider.success) {
        // Display a success toast

        toastProvider
            .showSuccessToast('submission successful, check your email');

        // Navigate to the otp screen
        if (context.mounted) {
          Navigator.pushNamed(context, kRouteOtp);
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
