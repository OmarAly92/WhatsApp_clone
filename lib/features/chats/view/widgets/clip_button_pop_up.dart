import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/features/chats/view/widgets/icon_items.dart';

import '../../../../core/app_router/app_router.dart';
import '../../../../core/themes/theme_color.dart';

class ClipButtonPopUp extends StatefulWidget {
  const ClipButtonPopUp({
    super.key,
    required this.themeColors,
    required this.phoneNumber,
    required this.myPhoneNumber,
  });

  final ThemeColors themeColors;
  final String phoneNumber;
  final String myPhoneNumber;

  @override
  State<ClipButtonPopUp> createState() => _ClipButtonPopUpState();
}

class _ClipButtonPopUpState extends State<ClipButtonPopUp> {
 final AppRouter appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 310.h,
        width: double.maxFinite,
        padding: EdgeInsets.only(bottom: 28.h),
        child: Card(
          color: widget.themeColors.clipButtonPopUp,
          margin: EdgeInsets.all(16.r),
          child: Padding(
            padding: EdgeInsets.all(20.r),
            child: BlocProvider.value(
              value: appRouter.chatDetailsCubit,
              child: IconItems(
                themeColors: widget.themeColors,
                phoneNumber: widget.phoneNumber,
                myPhoneNumber: widget.myPhoneNumber,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
