import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:otp_text_field/otp_field_style.dart';

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    OtpTextFieldWidget(),
                    OtpTextFieldWidget(),
                    OtpTextFieldWidget(),
                    OtpTextFieldWidget(),
                    OtpTextFieldWidget(),
                    OtpTextFieldWidget(),
                  ],
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
                    onPressed: () {},
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

class OtpTextFieldWidget extends StatefulWidget {
  const OtpTextFieldWidget({Key? key}) : super(key: key);

  @override
  State<OtpTextFieldWidget> createState() => _OtpTextFieldWidgetState();
}

class _OtpTextFieldWidgetState extends State<OtpTextFieldWidget> {
  final _textController = TextEditingController();
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode();
    _textController.addListener(_onTextChange);
  }

  void _onTextChange() {
    print("ON_TEXT_CHANGE");
    if (_textController.text.isNotEmpty && _textController.text.length == 1) {
      // when text inputs are filled, move to next input
      _focusNode.nextFocus();
    } else if (_textController.text.isEmpty) {
      // when text inputs are empty, move to previous input
      _focusNode.previousFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 48,
      child: TextFormField(
        controller: _textController,
        focusNode: _focusNode,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(6),
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(0.2),

        ),
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontFamily: 'BaiJamjuree',
            ),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
      ), // TextFormField
    );
  }
}
