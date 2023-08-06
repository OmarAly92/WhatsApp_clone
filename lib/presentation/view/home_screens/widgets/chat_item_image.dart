import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/assets_data.dart';

class ChatItemImage extends StatelessWidget {
  const ChatItemImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 49.r,
      width: 49.r,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.r),
        child: Image.asset(testOmar),
      ),
    );
  }
}
