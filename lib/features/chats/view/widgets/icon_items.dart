import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/features/chats/view/widgets/icon_item_widget.dart';

import '../../../../core/themes/theme_color.dart';
import '../../view_model/chat_details_cubit/chat_details_cubit.dart';

class IconItems extends StatelessWidget {
  const IconItems({
    super.key,
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
        Row(
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
                BlocProvider.of<ChatDetailsCubit>(context).sendImage(
                  phoneNumber: phoneNumber,
                  time: timestamp,
                  type: 'image',
                );
              },
            ),
          ],
        ),
        Row(
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
        ),
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
