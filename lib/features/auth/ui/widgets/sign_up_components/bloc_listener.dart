part of '../../sign_up_screen.dart';

class _BlocListener extends StatelessWidget {
  const _BlocListener({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRouter.homeScreen,
            (route) => false,
          );
        } else if (state is AuthenticationFailure) {
          GlFunctions.showSnackBar(context, state.failureMessage);
        }
      },
      child: child,
    );
  }
}
