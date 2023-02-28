import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class OptionSelector extends StatefulWidget {
  final List<String> options;

  const OptionSelector({super.key, required this.options});

  @override
  _OptionSelectorState createState() => _OptionSelectorState();
}

class _OptionSelectorState extends State<OptionSelector> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedOption,
      style: const TextStyle(
        color: AppColors.deepPurple,
        fontFamily: 'BaiJamjuree',
      ),
      isDense: true,
      decoration: InputDecoration(
        hintText: 'Select Group',
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
      items: widget.options.map((option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedOption = value;
        });
      },
    );
  }
}
