import 'package:flutter/material.dart';

import '../../../../core/themes/text_style/text_styles.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomTabBar({
    Key? key,
    required this.tabs,
  }) : super(key: key);

  final List<TabItem> tabs;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: tabs,
    );
  }

  @override
  Size get preferredSize {
    return const Size.fromHeight(kToolbarHeight);
  }
}

class TabItem extends StatelessWidget {
  const TabItem({
    Key? key,
    required this.isActive,
    this.text = 'Tab Name',
    this.icon,
    required this.index,
    required this.pageController,
    this.tapTextStyle,
    this.activeColor,
    this.inActiveColor,
  }) : super(key: key);

  final bool isActive;
  final String text;
  final IconData? icon;
  final int index;
  final PageController pageController;
  final TextStyle? tapTextStyle;
  final Color? activeColor;
  final Color? inActiveColor;

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return SizedBox(
        width: 35,
        child: InkWell(
          onTap: () {
            pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
          },
          child: Column(
            children: [
              const SizedBox(height: 13),
              Icon(
                icon,
                color: isActive ? activeColor ?? const Color(0xff008069) : const Color(0xff909ea6),
              ),
              const SizedBox(height: 10),
              Container(
                color: isActive ? activeColor ?? const Color(0xff008069) : Colors.transparent,
                height: 3,
              ),
            ],
          ),
        ),
      );
    } else {
      return Expanded(
        child: Container(
          alignment: Alignment.bottomCenter,
          child: InkWell(
            onTap: () {
              pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
            },
            child: Column(
              children: [
                const SizedBox(height: 13),
                Text(
                  text,
                  style: tapTextStyle ??
                      Styles.textStyle18().copyWith(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w500,
                        color: isActive
                            ? activeColor ?? const Color(0xff008069)
                            : inActiveColor ?? const Color(0xff909ea6),
                      ),
                ),
                const SizedBox(height: 10),
                Container(
                  color: isActive ? activeColor ?? const Color(0xff008069) : Colors.transparent,
                  width: double.infinity,
                  height: 3,
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
