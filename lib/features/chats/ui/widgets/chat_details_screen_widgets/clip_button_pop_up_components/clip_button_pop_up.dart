import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/core/networking/model/user_model/user_model.dart';

import '../../../../../../core/app_router/app_router.dart';
import '../../../../../../core/themes/theme_color.dart';
import '../../../../logic/chat_details_cubit/send_messages/send_messages_cubit.dart';
import 'icon_item_widget.dart';

part 'icon_items.dart';

part 'row_icon.dart';

class ClipButtonPopUp extends StatefulWidget {
  const ClipButtonPopUp({
    super.key,
    required this.themeColors,
    required this.hisUserModel,
  });

  final ThemeColors themeColors;
  final UserModel hisUserModel;

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
              value: appRouter.getMessagesCubit,
              child: _IconItems(
                themeColors: widget.themeColors,
                hisUserModel: widget.hisUserModel,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
