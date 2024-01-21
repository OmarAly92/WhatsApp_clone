import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/text_style/text_styles.dart';
import '../../../../core/themes/theme_color.dart';
import 'widgets/select_contact_screen_widgets/select_contact_body.dart';

class SelectContactScreen extends StatelessWidget {
  const SelectContactScreen({Key? key, required this.themeColors}) : super(key: key);
  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: SelectContactBody(themeColors: themeColors),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back),
        color: Colors.white,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Contact',
            style: Styles.textStyle18.copyWith(
              fontSize: 17.spMin,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          // Text(
          //   '100 contacts',
          //   style: Styles.textStyle14.copyWith(
          //     fontWeight: FontWeight.w500,
          //     color: Colors.white,
          //   ),
          // ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            CupertinoIcons.search,
            size: 24.r,
            color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.more_vert,
            size: 24.r,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
