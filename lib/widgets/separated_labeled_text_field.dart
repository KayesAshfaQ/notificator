import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class SeparatedLabeledTextField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final FormFieldValidator? validator;
  final bool? isPassword;
  final FocusNode? focusNode;

  const SeparatedLabeledTextField({
    Key? key,
    required this.labelText,
    required this.hintText,
    this.controller,
    this.validator,
    this.isPassword,
    this.focusNode,
  }) : super(key: key);

  @override
  State<SeparatedLabeledTextField> createState() =>
      _SeparatedLabeledTextFieldState();
}

class _SeparatedLabeledTextFieldState extends State<SeparatedLabeledTextField> {
  bool isObscurePassword = false;
  int firstBuild = 0;

  @override
  Widget build(BuildContext context) {
    if (firstBuild == 0) {
      isObscurePassword = widget.isPassword ?? false;
      firstBuild++;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.deepPurple,
            fontFamily: 'BaiJamjuree',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          focusNode: widget.focusNode,
          obscureText: isObscurePassword,
          controller: widget.controller,
          validator: widget.validator,
          style: const TextStyle(
            color: AppColors.deepPurple,
            fontFamily: 'BaiJamjuree',
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: AppColors.deepPurple.withOpacity(0.5),
              fontFamily: 'BaiJamjuree',
            ),
            filled: true,
            fillColor: AppColors.deepPurple.withOpacity(0.1),
            isDense: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide.none,
            ),
            suffixIcon: widget.isPassword ?? false
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isObscurePassword = !isObscurePassword;
                      });
                    },
                    icon: Icon(
                      !isObscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppColors.lightOrange,
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
