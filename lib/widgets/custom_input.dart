import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class CustomInput extends StatelessWidget {
  const CustomInput(
      {super.key,
      required this.title,
      required this.controller,
      this.validator,
      this.backgroundColor = Colors.grey,
      this.suffix,
      this.prefixIcon,
      this.obscureText = false,
      this.keyboardType,
      this.maxLines});
  final Widget title;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Color backgroundColor;
  final Widget? suffix;
  final IconData? prefixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          title,
          Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: backgroundColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                keyboardType: keyboardType,
                obscureText: obscureText,
                controller: controller,
                cursorColor: Colors.grey,
                maxLines: maxLines,
                // onChanged: (value) => controller.text = value,
                validator: validator,
                decoration: InputDecoration(
                  suffixIcon: suffix,
                  prefixIcon: prefixIcon != null
                      ? Icon(prefixIcon, color: AppTheme.primary)
                      : null,
                  border: InputBorder.none,
                ),
              )),
        ],
      ),
    );
  }
}
