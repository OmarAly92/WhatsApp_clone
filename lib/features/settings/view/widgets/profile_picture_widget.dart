import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/features/settings/view_model/settings_cubit.dart';

class ProfilePictureWidget extends StatelessWidget {
  const ProfilePictureWidget({
    super.key,
    required this.profileImage,
  });

  final String profileImage;

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
              child: Image.network(profileImage),
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
                onPressed: () async {
                  BlocProvider.of<SettingsCubit>(context)
                      .changeProfilePicture();
                },
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
