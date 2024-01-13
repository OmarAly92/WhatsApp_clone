import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/core/themes/text_style/text_styles.dart';
import 'package:whats_app_clone/features/chats/view/widgets/select_contact_screen_widgets/actions_buttons_widgets_items.dart';

class FirstActionsButtonsInSelectContactAndText extends StatelessWidget {
  const FirstActionsButtonsInSelectContactAndText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ActionsButtonsWidgetsItems(
            iconsSize: 28,
            title: 'New group',
            containerColor: const Color(0xff02a785),
            leftIcon: Icons.people,
            iconColor: Colors.white,
            customPadding: const EdgeInsets.only(top: 22),
            onTap: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(top: 22),
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'New contact',
                    style: Styles.textStyle18.copyWith(
                      fontSize: 17.spMin,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Icon(
                    CupertinoIcons.qrcode,
                    size: 30.spMin,
                    color: const Color(0xff8c99a1),
                  )
                ],
              ),
              leading: Container(
                height: 53,
                width: 53,
                decoration: BoxDecoration(
                  color: const Color(0xff02a785),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Icon(
                  Icons.person_add,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              onTap: () {},
            ),
          ),
          ActionsButtonsWidgetsItems(
            iconsSize: 28,
            title: 'New community',
            containerColor: const Color(0xff02a785),
            leftIcon: CupertinoIcons.person_3_fill,
            iconColor: Colors.white,
            customPadding: const EdgeInsets.only(top: 22),
            onTap: () {},
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 13.w),
            child: Text(
              'Contacts on WhatsApp',
              style: Styles.textStyle12.copyWith(
                color: const Color(0xff8c99a1),
                fontSize: 13.spMin,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
