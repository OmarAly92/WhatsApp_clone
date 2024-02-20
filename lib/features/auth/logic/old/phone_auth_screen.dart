import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_router.dart';
import '../../../../core/themes/text_style/text_styles.dart';
import '../../../../core/themes/theme_color.dart';
import 'authentication_old_cubit.dart';
import '../../ui/widgets/auth_button.dart';
import '../../ui/widgets/phone_auth_screen_top_title_section.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({Key? key, required this.themeColors}) : super(key: key);
  final ThemeColors themeColors;

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final TextEditingController phoneNumberController = TextEditingController();
  final GlobalKey<FormState> _phoneFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    phoneNumberController.dispose();
  }

  void showProgressIndicator(BuildContext context) {
    AlertDialog alertDialog = const AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
        ),
      ),
    );
    showDialog(
      barrierColor: Colors.white.withOpacity(0),
      barrierDismissible: false,
      context: context,
      builder: (context) => alertDialog,
    );
  }

  Widget buildBlocListener() {
    return BlocListener<AuthenticationOldCubit, AuthenticationOldState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is AuthenticationLoadingOld) {
          showProgressIndicator(context);
        } else if (state is PhoneNumberSubmitted) {
          Navigator.pop(context);
          Navigator.pushNamed(context, AppRouter.otpScreen, arguments: phoneNumberController.text);
        } else if (state is AuthenticationFailureOld) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.failureMessage),
              backgroundColor: Colors.white,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      child: Container(),
    );
  }

  Future<void> _register(BuildContext context) async {
    if (!_phoneFormKey.currentState!.validate()) {
      Navigator.pop(context);

      return;
    } else {
      Navigator.pop(context);
      _phoneFormKey.currentState!.save();
      BlocProvider.of<AuthenticationOldCubit>(context).submitPhoneNumber(phoneNumber: phoneNumberController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _phoneFormKey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    PhoneAuthScreenTopTitleSection(
                      themeColors: widget.themeColors,
                    ),
                    SizedBox(height: 45.h),
                    buildPhoneFormField(),
                    SizedBox(height: 20.h),
                    Text(
                      'Carrier charges may apply',
                      style: Styles.textStyle14.copyWith(
                        color: widget.themeColors.bodyTextColor,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    SizedBox(height: 30.h),
                    AuthButton(
                        context: context,
                        themeColors: widget.themeColors,
                        buttonName: 'Next',
                        onPressed: () {
                          showProgressIndicator(context);
                          _register(context);
                        }),
                    buildBlocListener(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String generateCountryFlag({required String countryCode}) {
    String flag = countryCode.toUpperCase().replaceAllMapped(
        RegExp(r'[A-Z]'), (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
    return flag;
  }

  Widget buildPhoneFormField() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                '${generateCountryFlag(countryCode: 'eg')} +2',
                style: Styles.textStyle18.copyWith(
                  letterSpacing: 2.0,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            decoration: BoxDecoration(
              border: Border.all(color: widget.themeColors.greenColor),
              borderRadius: BorderRadius.circular(6),
            ),
            child: TextFormField(
              controller: phoneNumberController,
              style: Styles.textStyle18,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              cursorColor: widget.themeColors.greenColor,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your phone number!';
                } else if (value.length < 11) {
                  return 'Too short for a phone number!';
                } else if (value.length > 11) {
                  return 'Too long for a phone number!';
                } else {
                  return null;
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
