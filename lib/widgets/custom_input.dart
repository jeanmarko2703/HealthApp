import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  const CustomInput(
      {super.key,
      this.title,
      required this.controller,
      this.validator,
      this.backgroundColor = Colors.grey,
      this.suffix,
      this.prefixIcon,
      this.obscureText = false,
      this.keyboardType,
      this.maxLines = 1,
      this.secondTitle,
      this.secondTitleStyle});
  final Widget? title;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Color backgroundColor;
  final Widget? suffix;
  final IconData? prefixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final String? secondTitle;
  final TextStyle? secondTitleStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null) title!,
          TextFormField(
            keyboardType: keyboardType,
            obscureText: obscureText,
            controller: controller,
            cursorColor: Colors.grey,
            maxLines: maxLines,
            validator: validator,
            decoration: InputDecoration(
              labelText: secondTitle,
              labelStyle: secondTitleStyle,
              focusedBorder: const OutlineInputBorder(),
              disabledBorder: const OutlineInputBorder(),
              enabledBorder: const OutlineInputBorder(),
              suffixIcon: suffix,
              prefixIcon: prefixIcon != null
                  ? Icon(prefixIcon, color: Colors.red)
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
