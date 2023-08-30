import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whats_app_clone/core/themes/text_style/text_styles.dart';
import 'package:whats_app_clone/data/model/user_model/user_model.dart';

import '../../../../../core/themes/theme_color.dart';

class UserNameAlertDialogWidget extends StatefulWidget {
  const UserNameAlertDialogWidget({
    super.key,
    required this.themeColors,
    required this.userModel,
  });

  final ThemeColors themeColors;
  final UserModel userModel;

  @override
  State<UserNameAlertDialogWidget> createState() =>
      _UserNameAlertDialogWidgetState();
}

class _UserNameAlertDialogWidgetState
    extends State<UserNameAlertDialogWidget> {
  late String userName;

  final GlobalKey<FormState> popUpUserFormKey = GlobalKey<FormState>();

  void sendUserNameFireStore(String userName, UserModel userModel) {
    var userQuerySnapshot =
        FirebaseFirestore.instance.collection('users').doc(userModel.userPhone);
    userQuerySnapshot.update({
      'userName': userName,
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog.adaptive(
        backgroundColor: widget.themeColors.backgroundColor,
        title: const Text('Enter your name'),
        content: Form(
          key: popUpUserFormKey,
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'You must enter your name';
              } else if (value.length <= 2) {
                return 'Your name is too short';
              } else if (value.length >= 20) {
                return 'Your name is too long';
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: "Name",
            ),
            onChanged: (value) {
              userName = value;
            },
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              if (popUpUserFormKey.currentState!.validate()) {
                sendUserNameFireStore(userName, widget.userModel);
                Navigator.pop(context);
              }
            },
            child: Text(
              'Done',
              style: Styles.textStyle18.copyWith(
                color: widget.themeColors.regularTextColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
