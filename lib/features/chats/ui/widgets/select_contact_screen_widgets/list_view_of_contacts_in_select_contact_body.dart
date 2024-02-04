import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app_router/app_router.dart';
import '../../../../../core/networking/model/user_model/user_model.dart';
import '../../../logic/select_contact_cubit/select_contact_cubit.dart';
import 'local_mobile_contacts.dart';

class ListViewOfContactsInSelectContactBody extends StatelessWidget {
  const ListViewOfContactsInSelectContactBody({
    super.key,
    required this.userModelList,
  });

  final List<UserModel> userModelList;

  @override
  Widget build(BuildContext context) {
    return SliverFixedExtentList.builder(
      itemCount: userModelList.length,
      itemBuilder: (context, index) {
        return LocalMobileContactsItem(
          contactName: userModelList[index].userName,
          contactDescription: '',
          contactImage: Image.network(
            userModelList[index].profilePicture,
            fit: BoxFit.cover,
          ),
          onTap: () async {
            BlocProvider.of<SelectContactCubit>(context).createChatRoom(
              friendContactUserModel: userModelList[index],
            );
            Navigator.pushNamed(context, AppRouter.chatDetailScreen, arguments: {
              'userModel': userModelList[index],
            });
          },
        );
      },
      itemExtent: 75,
    );
  }
}
