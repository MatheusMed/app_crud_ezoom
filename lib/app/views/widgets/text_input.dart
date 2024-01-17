import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final String labelText;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  const TextInput(
      {super.key,
      required this.textEditingController,
      required this.labelText,
      this.focusNode,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 370,
      child: TextFormField(
        controller: textEditingController,
        validator: validator,
        decoration: InputDecoration(
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
