import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextForm extends StatelessWidget {
  const CustomTextForm({
    super.key,
    required this.emailController,
    required this.hintText,
    required this.validator,
    this.onFieldSubmitted,
  });

  final TextEditingController emailController;
  final String hintText;
  final FormFieldValidator validator;
  final ValueChanged<String>? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.r),
      child: TextFormField(
        controller: emailController,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
        ),
        onFieldSubmitted: onFieldSubmitted,
      ),
    );
  }
}