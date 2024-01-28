import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../core/app_router/app_router.dart';
import '../../../../core/themes/theme_color.dart';
import '../../view_model/authentication_cubit.dart';
import 'otp_intro_text.dart';

class OtpBody extends StatefulWidget {
  const OtpBody({
    super.key,
    required this.themeColors,
    required this.phoneNumber,
  });

  final ThemeColors themeColors;
  final String phoneNumber;

  @override
  State<OtpBody> createState() => _OtpBodyState();
}

class _OtpBodyState extends State<OtpBody> {
  TextEditingController pinCodeController = TextEditingController();

  late String _smsCode;

  Widget _buildPinCodeFields(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      autoFocus: true,
      cursorColor: widget.themeColors.greenButton,
      keyboardType: TextInputType.number,
      length: 6,
      obscureText: false,
      animationType: AnimationType.scale,
      controller: pinCodeController,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        borderWidth: 1,
        activeColor: widget.themeColors.greenButton,
        activeFillColor: widget.themeColors.backgroundColor,
        inactiveColor: widget.themeColors.greenButton,
        inactiveFillColor: widget.themeColors.backgroundColor,
        selectedColor: widget.themeColors.greenButton,
        selectedFillColor: widget.themeColors.backgroundColor,
      ),
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: true,
      onCompleted: (code) {
        _smsCode = code;
        _login(context, smsCode: _smsCode);
      },
      beforeTextPaste: (text) {
        return true;
      },
    );
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

  Widget _buildPhoneVerificationBloc() {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is AuthenticationLoading) {
          showProgressIndicator(context);
        } else if (state is PhoneOTPVerified) {
          Navigator.pop(context);
          Navigator.pushNamedAndRemoveUntil(context, AppRouter.homeScreen, (route) => false);
        } else if (state is AuthenticationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.failureMessage),
              backgroundColor: Colors.black,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      child: Container(),
    );
  }

  void _login(BuildContext context, {required String smsCode}) {
    BlocProvider.of<AuthenticationCubit>(context).submitOtp(smsCode);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 70.h),
      child: Column(
        children: [
          OTPIntroText(themeColors: widget.themeColors, phoneNumber: widget.phoneNumber),
          SizedBox(height: 80.h),
          _buildPinCodeFields(context),
          SizedBox(height: 50.h),
          _buildPhoneVerificationBloc(),
        ],
      ),
    );
  }
}
