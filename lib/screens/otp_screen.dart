import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:notificator/constants/routes.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../constants/app_colors.dart';
import '../constants/app_info.dart';
import '../util/utils.dart';
import '../generated/assets.dart';
import '../widgets/white_button_widgets.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

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
                  'Verification Code',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontFamily: 'BaiJamjuree',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'We send OTP to verify your email address',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontFamily: 'BaiJamjuree',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 28),
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: PinCodeTextField(
                      appContext: context,
                      length: 6,
                      obscuringCharacter: '*',
                      animationType: AnimationType.scale,
                      validator: (v) {
                        if (v!.length < 3) {
                          return "I'm from validator";
                        } else {
                          return null;
                        }
                      },
                      
                      textStyle: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'BaiJamjuree',
                          fontWeight: FontWeight.w300),
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 42,
                          borderWidth: 1,
                          activeColor: Colors.orange,
                          selectedColor: Colors.orange,
                          inactiveColor: Colors.white.withOpacity(0.5),
                          disabledColor: Colors.grey.withOpacity(0.2),
                          activeFillColor: Colors.white.withOpacity(0.2),
                          inactiveFillColor: Colors.white.withOpacity(0.2),
                          selectedFillColor: Colors.white.withOpacity(0.2),
                          errorBorderColor: Colors.red),
                      animationDuration: const Duration(milliseconds: 300),
                      keyboardType: TextInputType.number,
                      boxShadows: const [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 10,
                        )
                      ],
                      onCompleted: (v) {
                        debugPrint("Completed");
                      },
                      onChanged: (value) {
                        debugPrint(value);
                        setState(() {
                          currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        debugPrint("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                RichText(
                  text: const TextSpan(
                    text: 'Don\'t receive OTP? ',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'BaiJamjuree',
                    ),
                    children: [
                      TextSpan(
                        text: 'Resend OTP',
                        style: TextStyle(
                          color: AppColors.orange,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'BaiJamjuree',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  width: double.infinity,
                  child: WhiteButtonWidget(
                    label: 'Submit',
                    onPressed: () {
                      Navigator.pushNamed(context, kRouteChangePass);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
