import 'package:flutter/material.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';
import 'package:whats_app_clone/features/chats/view/widgets/select_contact_screen_widgets/actions_buttons_widgets_items.dart';

class ShareAndContactsHelpButtonsInSelectContactBody extends StatelessWidget {
  const ShareAndContactsHelpButtonsInSelectContactBody({
    super.key,
    required this.themeColors,
  });

  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ActionsButtonsWidgetsItems(
            iconsSize: 28,
            title: 'Share invite link',
            leftIcon: Icons.share,
            containerColor: themeColors.contactScreenContainerColor,
            iconColor: themeColors.contactScreenIconColor,
            customPadding: const EdgeInsets.only(top: 12),
            onTap: () {},
          ),
          ActionsButtonsWidgetsItems(
            iconsSize: 28,
            title: 'Contacts help',
            leftIcon: Icons.question_mark,
            containerColor: themeColors.contactScreenContainerColor,
            iconColor: themeColors.contactScreenIconColor,
            customPadding: const EdgeInsets.only(top: 18, bottom: 15),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
