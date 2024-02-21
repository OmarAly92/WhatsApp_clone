import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/themes/theme_color.dart';
import '../../../core/utils/app_router.dart';
import 'widgets/custom_tab_bar.dart';
import 'widgets/tab_bar_view_body.dart';
import 'widgets/tabs_floating_action_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.themeColors});

  final ThemeColors themeColors;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late PageController pageController;
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    pageController.addListener(() {
      setState(() {
        currentPageIndex = pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    pageController.removeListener(handleTabChange);
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQuery.sizeOf(context).width;
    return Scaffold(
      floatingActionButton:
          TabsFloatingActionButton(currentPageIndex: currentPageIndex, themeColors: widget.themeColors),
      appBar: buildHomeAppBar(),
      body: TabBarViewBody(
        themeColors: widget.themeColors,
        pageController: pageController,
      ),
    );
  }

  AppBar buildHomeAppBar() {
    List<Widget> actions = [
      IconButton(onPressed: () {}, icon: const Icon(Icons.camera_alt_outlined)),
      currentPageIndex == 1
          ? const SizedBox()
          : IconButton(
              onPressed: () {},
              icon: const Icon(CupertinoIcons.search),
            ),
      IconButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRouter.settingsScreen);
          },
          icon: const Icon(Icons.more_vert)),
    ];
    return AppBar(
      title: const Text('WhatsApp'),
      actions: actions,
      bottom: buildCustomTabBar(),
    );
  }

  CustomTabBar buildCustomTabBar() {
    return CustomTabBar(
      tabs: [
        // TabItem(
        //   index: 0,
        //   isActive: currentPageIndex == 0,
        //   icon: Icons.groups,
        //   pageController: pageController,
        // ),
        TabItem(
          index: 0,
          isActive: currentPageIndex == 0,
          text: 'Chats',
          pageController: pageController,
          activeColor: widget.themeColors.activeTabBarColor,
          inActiveColor: widget.themeColors.appbarTextColor,
        ),
        TabItem(
          index: 1,
          isActive: currentPageIndex == 1,
          text: 'Updates',
          pageController: pageController,
          activeColor: widget.themeColors.activeTabBarColor,
          inActiveColor: widget.themeColors.appbarTextColor,
        ),
        TabItem(
          index: 2,
          isActive: currentPageIndex == 2,
          text: 'Calls',
          pageController: pageController,
          activeColor: widget.themeColors.activeTabBarColor,
          inActiveColor: widget.themeColors.appbarTextColor,
        ),
      ],
    );
  }

  void handleTabChange() {
    setState(() {});
  }
}
