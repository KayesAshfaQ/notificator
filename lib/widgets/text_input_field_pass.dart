import 'package:flutter/material.dart';
import 'package:notificator/constants/app_colors.dart';

class TextFieldPasswordWidget extends StatefulWidget {
  final String? hintText;

  const TextFieldPasswordWidget({
    Key? key,
    required this.hintText,
  }) : super(key: key);

  @override
  State<TextFieldPasswordWidget> createState() =>
      _TextFieldPasswordWidgetState();
}

class _TextFieldPasswordWidgetState extends State<TextFieldPasswordWidget> {
  bool isObscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isObscurePassword,
      onChanged: (value) {},
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.white.withOpacity(0.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide.none,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            isObscurePassword
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: AppColors.lightOrange,
          ),
          onPressed: () {
            setState(() {
              isObscurePassword = !isObscurePassword;
            });
          },
        ),
      ),
    );
  }
}
