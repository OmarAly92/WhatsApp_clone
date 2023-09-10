import 'package:flutter/cupertino.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';
import 'package:whats_app_clone/core/widgets/custom_circle_image.dart';
import 'package:whats_app_clone/features/updates/view/widgets/plus_icon.dart';

class StatusItemImage extends StatelessWidget {
  const StatusItemImage({
    super.key,
    required this.isMyStatus,
    required this.themeColors,
  });

  final bool isMyStatus;
  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            decoration: BoxDecoration(
                border: isMyStatus
                    ? Border.all()
                    : Border.all(color: const Color(0xff02c855), width: 2),
                borderRadius: BorderRadius.circular(40)),
            child:  CustomCircleImage(profileImage: '',)),
        isMyStatus ? PlusIcon(themeColors: themeColors) : const SizedBox(),
        const SizedBox(
          height: 60,
          width: 60,
        ),
      ],
    );
  }
}
