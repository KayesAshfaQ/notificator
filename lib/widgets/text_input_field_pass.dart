import 'package:flutter/material.dart';
import 'package:notificator/constants/app_colors.dart';

class TextFieldPasswordWidget extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final Color? color;
  final Color? backgroundColor;
  final FormFieldValidator? validator;

  const TextFieldPasswordWidget(
      {Key? key,
      required this.hintText,
      this.controller,
      this.color,
      this.backgroundColor,
      this.validator})
      : super(key: key);

  @override
  State<TextFieldPasswordWidget> createState() =>
      _TextFieldPasswordWidgetState();
}

class _TextFieldPasswordWidgetState extends State<TextFieldPasswordWidget> {
  bool isObscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: isObscurePassword,
      onChanged: (value) {},
      style: TextStyle(color: widget.color ?? Colors.white),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(color: widget.color ?? Colors.white),
        filled: true,
        fillColor: widget.backgroundColor ?? Colors.white.withOpacity(0.2),
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
      validator: widget.validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            } else if (value.length < 8) {
              return 'Password must be at least 8 characters';
            }
            return null;
          },
    );
  }
}
