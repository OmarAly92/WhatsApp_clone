import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCircleImage extends StatelessWidget {
  const CustomCircleImage({
    super.key,
    required this.profileImage,
  });

  final String profileImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 49.r,
      width: 49.r,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.r),
        child: Image.network(profileImage,fit: BoxFit.cover),
      ),
    );
  }
}
