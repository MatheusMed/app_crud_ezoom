import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final String labelText;
  final FocusNode? focusNode;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  const TextInput({
    super.key,
    required this.textEditingController,
    required this.labelText,
    this.focusNode,
    this.validator,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 370,
      child: TextFormField(
        obscureText: obscureText,
        controller: textEditingController,
        validator: validator,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          labelText: labelText,
        ),
        focusNode: focusNode,
      ),
    );
  }
}
