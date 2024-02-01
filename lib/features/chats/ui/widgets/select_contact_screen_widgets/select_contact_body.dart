import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/themes/theme_color.dart';
import '../../../logic/select_contact_cubit/select_contact_cubit.dart';
import 'first_actions_buttons_in_select_contact_and_text.dart';
import 'list_view_of_contacts_in_select_contact_body.dart';
import 'share_and_contacts_help_buttons_in_select_contact_body.dart';

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
