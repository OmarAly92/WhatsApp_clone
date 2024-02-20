import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_router.dart';
import '../../../core/themes/text_style/text_styles.dart';
import '../../../core/themes/theme_color.dart';
import 'widgets/tab_bar_view_body.dart';
import 'widgets/tabs_floating_action_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.themeColors});

  final ThemeColors themeColors;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        floatingActionButton: TabsFloatingActionButton(
            tabController: _tabController, themeColors: widget.themeColors),
        appBar: _buildHomeAppBar(),
        body: TabBarViewBody(
          themeColors: widget.themeColors,
          tabController: _tabController,
        ),
      ),
    );
  }

  AppBar _buildHomeAppBar() {
    List<Widget> actions = [
      IconButton(onPressed: () {}, icon: const Icon(Icons.camera_alt_outlined)),
      _tabController.index == 1
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
      bottom: _tabBar(),
    );
  }

  TabBar _tabBar() {
    return TabBar(
      controller: _tabController,
      unselectedLabelColor: widget.themeColors.appbarTextColor,
      indicatorSize: TabBarIndicatorSize.tab,
      tabs: [
        Tab(
          child: Text(
            'Chats',
            style: Styles.textStyle14.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 15.sp,
            ),
          ),
        ),
        Tab(
          child: Text(
            'Updates',
            style: Styles.textStyle14.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 15.sp,
            ),
          ),
        ),
        Tab(
          child: Text(
            'Calls',
            style: Styles.textStyle14.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 15.sp,
            ),
          ),
        ),
      ],
    );
  }

  void _handleTabChange() {
    setState(() {});
  }
}
