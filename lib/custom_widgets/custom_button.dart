import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      // Add custom styling later
      style: ElevatedButton.styleFrom(
        // Example styling:
        // backgroundColor: Colors.green,
        // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        // textStyle: TextStyle(fontSize: 16),
      ),
      child: Text(text),
    );
  }
}
