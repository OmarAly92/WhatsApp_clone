import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/chats/logic/select_contact_cubit/select_contact_cubit.dart';
import 'features/chats/ui/widgets/select_contact_screen_widgets/local_mobile_contacts.dart';

class TestContactsWidget extends StatefulWidget {
  const TestContactsWidget({Key? key}) : super(key: key);

  @override
  State<TestContactsWidget> createState() => _TestContactsWidgetState();
}

class _TestContactsWidgetState extends State<TestContactsWidget> {
  @override
  void initState() {
    BlocProvider.of<SelectContactCubit>(context).sortingContactData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<SelectContactCubit, SelectContactState>(builder: (context, state) {
          if (state is SelectContactLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SelectContactSuccess) {
            return CustomScrollView(
              slivers: [
                SliverFixedExtentList.builder(
                  itemCount: state.userModel.length,
                  itemBuilder: (context, index) {
                    return LocalMobileContactsItem(
                      contactName:state.userModel[index].phoneNumber,
                      contactDescription: '',
                      contactImage: Image.network(
                        state.userModel[index].profilePicture,
                        fit: BoxFit.cover,
                      ),
                      onTap: () async {},
                    );
                  },
                  itemExtent: 75,
                ),
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
        }),
      ),
    );
  }
}
