part of 'clip_button_pop_up.dart';

class _FirstRowIconComponents extends StatelessWidget {
  const _FirstRowIconComponents({
    Key? key,
    required this.themeColors,
    required this.phoneNumber,
  }) : super(key: key);
  final ThemeColors themeColors;
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconItemWidget(
          themeColors: themeColors,
          icons: Icons.insert_drive_file,
          title: 'Document',
          gradient: const [
            Color(0xff7866F0),
            Color(0xff644EE1),
          ],
          onTap: () {},
        ),
        IconItemWidget(
          themeColors: themeColors,
          icons: Icons.camera_alt_rounded,
          title: 'Camera',
          gradient: const [
            Color(0xffFF2F70),
            Color(0xffE00B60),
          ],
          onTap: () {},
        ),
        IconItemWidget(
          themeColors: themeColors,
          icons: Icons.image,
          title: 'Gallery',
          gradient: const [
            Color(0xffC560F7),
            Color(0xffA453D0),
          ],
          onTap: () {
            DateTime now = DateTime.now();
            Timestamp timestamp = Timestamp.fromDate(now);
            BlocProvider.of<SendMessagesCubit>(context).sendImage(
              phoneNumber: phoneNumber,
              time: timestamp,
              type: 'image',
            );
          },
        ),
      ],
    );
  }
}

class _SecondRowIconComponent extends StatelessWidget {
  const _SecondRowIconComponent({
    Key? key,
    required this.themeColors,
    required this.phoneNumber,
  }) : super(key: key);
  final ThemeColors themeColors;
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconItemWidget(
          themeColors: themeColors,
          icons: Icons.headphones,
          title: 'Audio',
          gradient: const [
            Color(0xffF96633),
            Color(0xffE35D30),
          ],
          onTap: () {},
        ),
        IconItemWidget(
          themeColors: themeColors,
          icons: Icons.location_on_sharp,
          title: 'Location',
          gradient: const [
            Color(0xff1EA856),
            Color(0xff1D9950),
          ],
          onTap: () {},
        ),
        IconItemWidget(
          themeColors: themeColors,
          icons: Icons.person,
          title: 'Contact',
          gradient: const [
            Color(0xff009CE0),
            Color(0xff078AC3),
          ],
          onTap: () {},
        ),
      ],
    );
  }
}
