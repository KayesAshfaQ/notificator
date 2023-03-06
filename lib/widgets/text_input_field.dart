import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final FormFieldValidator? validator;

  const TextFieldWidget({
    Key? key,
    required this.hintText,
    this.controller,
    this.validator,
  }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
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
      ),
      validator: (value) => widget.validator!(value),
    );
  }
}
