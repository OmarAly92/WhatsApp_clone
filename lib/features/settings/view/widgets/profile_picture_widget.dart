import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePictureWidget extends StatelessWidget {
  const ProfilePictureWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          SizedBox(
            height: 165.r,
            width: 165.r,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100.r),
              child: Image.asset('assets/images/default_profile_picture.jpg'),
            ),
          ),
          Positioned(
            top: 100.h,
            left: 120.w,
            child: Container(
              width: 45.r,
              height: 45.r,
              decoration: BoxDecoration(
                color: const Color(0xff01aa84),
                borderRadius: BorderRadius.circular(30),
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.camera_alt_rounded,
                  size: 22,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
