import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app_clone/core/themes/theme_color.dart';
import 'package:whats_app_clone/features/chats/view/widgets/select_contact_screen_widgets/first_actions_buttons_in_select_contact_and_text.dart';
import 'package:whats_app_clone/features/chats/view/widgets/select_contact_screen_widgets/list_view_of_contacts_in_select_contact_body.dart';
import 'package:whats_app_clone/features/chats/view/widgets/select_contact_screen_widgets/share_and_contacts_help_buttons_in_select_contact_body.dart';

import '../../../view_model/select_contact_cubit/select_contact_cubit.dart';

class SelectContactBody extends StatelessWidget {
  const SelectContactBody({Key? key, required this.themeColors}) : super(key: key);
  final ThemeColors themeColors;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectContactCubit, SelectContactState>(
      builder: (context, state) {
        if (state is SelectContactLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SelectContactSuccess) {
          return CustomScrollView(
            slivers: [
              const FirstActionsButtonsInSelectContactAndText(),
              ListViewOfContactsInSelectContactBody(userModelList: state.userModel),
              ShareAndContactsHelpButtonsInSelectContactBody(themeColors: themeColors),
            ],
          );
        } else if (state is SelectContactFailure) {
          return Center(
            child: Text('${state.failureMessage} state is SelectContactFailure ERROR'),
          );
        } else {
          return const Center(
            child: Text(' Else ERROR'),
          );
        }
      },
    );
  }
}
