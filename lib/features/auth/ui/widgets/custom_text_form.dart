import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';

class CustomTextForm extends StatelessWidget {
  const CustomTextForm({
    super.key,
    this.obscureText = false,
    this.onFieldSubmitted,
    this.suffixIcon,
    required this.emailController,
    required this.hintText,
    required this.validator,
    required this.keyboardType,
    required this.icon,
    required this.themeColors,
  });

  final ThemeColors themeColors;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextEditingController emailController;
  final String hintText;
  final TextInputType keyboardType;
  final IconData icon;
  final FormFieldValidator validator;
  final ValueChanged<String>? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.r),
      child: Container(
        decoration: BoxDecoration(
          color: themeColors.bodyIconColor.withOpacity(.14),
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextFormField(
          keyboardType: keyboardType,
          controller: emailController,
          validator: validator,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8.r),
            ),
            prefixIcon: Icon(
              icon,
              color: themeColors.bodyIconColor.withOpacity(.85),
            ),
            suffixIcon: suffixIcon,
          ),
          onFieldSubmitted: onFieldSubmitted,
        ),
      ),
    );
  }
}
