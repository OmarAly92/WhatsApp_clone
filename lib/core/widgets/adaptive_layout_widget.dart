import 'package:flutter/widgets.dart';

class AdaptiveLayoutWidget extends StatelessWidget {
  const AdaptiveLayoutWidget({
    super.key,
    this.mobileLayout,
    this.tabletLayout,
    this.desktopLayout,
  });

  final WidgetBuilder? mobileLayout, tabletLayout, desktopLayout;

  static const Center centerText = Center(child: Text('There is no layout'));

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      /// this is the original BreakPoints
      final mobileBreakPoint = constraints.maxWidth < 800;
      final tabletBreakPoint = constraints.maxWidth < 1200;

      /// I am using those for test
      // final mobileBreakPoint = constraints.maxWidth < 100;
      // final tabletBreakPoint = constraints.maxWidth < 300;

      if (mobileBreakPoint) {
        return mobileLayout != null ? mobileLayout!(context) : centerText;
      } else if (tabletBreakPoint) {
        return tabletLayout != null ? tabletLayout!(context) : centerText;
      } else {
        return desktopLayout != null ? desktopLayout!(context) : centerText;
      }
    });
  }
}
