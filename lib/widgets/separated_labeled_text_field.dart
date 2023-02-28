import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class SeparatedLabeledTextField extends StatelessWidget {
  final String labelText;
  final String hintText;

  const SeparatedLabeledTextField(
      {Key? key, required this.labelText, required this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.deepPurple,
            fontFamily: 'BaiJamjuree',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8.0),
        TextField(
          onChanged: (value) {},
          style: const TextStyle(
            color: AppColors.deepPurple,
            fontFamily: 'BaiJamjuree',
          ),
          decoration: InputDecoration(
            hintText: hintText,
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
          ),
        ),
      ],
    );
  }
}
