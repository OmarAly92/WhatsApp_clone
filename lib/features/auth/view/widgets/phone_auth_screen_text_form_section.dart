import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PhoneAuthScreenTextFormSection extends StatelessWidget {
  const PhoneAuthScreenTextFormSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 230.w,
          child: TextFormField(
            enabled: false,
            decoration: InputDecoration(
                prefixIcon:
                    const Icon(Icons.ac_unit, color: Colors.transparent),
                suffixIcon: IconButton(
                    onPressed: () {}, icon: const Icon(Icons.arrow_drop_down)),
                hintText: '           Egypt',
                alignLabelWithHint: true),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 60.w,
              child: TextFormField(
                enabled: false,
                decoration: const InputDecoration(hintText: '+      20'),
              ),
            ),
            SizedBox(width: 15.w),
            SizedBox(
              width: 155.w,
              child: TextFormField(
                keyboardType: const TextInputType.numberWithOptions(),
                decoration: const InputDecoration(hintText: ' phone number'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
