import 'package:app_crud_ezoom/app/views/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Function() onPressed;
  final String label;
  const Button({super.key, required this.onPressed, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 370,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 190, 183, 204),
            Color.fromARGB(255, 196, 188, 212)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: OutlinedButton(
        onPressed: onPressed,
        child: TextWidget(
          label: label,
          color: Colors.black,
          fontSize: 17,
        ),
      ),
    );
  }
}
