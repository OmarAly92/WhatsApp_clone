part of 'clip_button_pop_up.dart';

class _IconItems extends StatelessWidget {
  const _IconItems({
    required this.themeColors,
    required this.phoneNumber,
    required this.myPhoneNumber,
  });

  final ThemeColors themeColors;
  final String phoneNumber;
  final String myPhoneNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _FirstRowIconComponents(themeColors: themeColors, phoneNumber: phoneNumber),
        _SecondRowIconComponent(themeColors: themeColors, phoneNumber: phoneNumber),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 35.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconItemWidget(
                themeColors: themeColors,
                icons: Icons.poll_outlined,
                title: 'Poll',
                gradient: const [
                  Color(0xff01A698),
                  Color(0xff05978C),
                ],
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
