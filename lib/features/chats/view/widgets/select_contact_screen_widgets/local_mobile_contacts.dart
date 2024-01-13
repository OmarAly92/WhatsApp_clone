import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/themes/text_style/text_styles.dart';


class LocalMobileContactsItem extends StatelessWidget {
  const LocalMobileContactsItem(
      {Key? key, required this.contactName, required this.contactDescription, required this.contactImage, required this.onTap})
      : super(key: key);
  final String contactName;
  final String contactDescription;
  final Widget contactImage;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 53,
              width: 53,
              decoration: BoxDecoration(
                color: const Color(0xff1f2c34),
                borderRadius: BorderRadius.circular(40),
              ),
              child: ClipRRect(borderRadius: BorderRadius.circular(40), child: contactImage),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    contactName,
                    style: Styles.textStyle18.copyWith(
                      fontSize: 17.spMin,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  contactDescription == ''
                      ? const SizedBox.shrink()
                      : Text(
                          contactDescription,
                          style: Styles.textStyle16
                              .copyWith(fontWeight: FontWeight.w500, color: const Color(0xff8c99a1)),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
