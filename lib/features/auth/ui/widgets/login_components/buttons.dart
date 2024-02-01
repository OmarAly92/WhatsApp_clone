part of '../../login_screen.dart';

class _Buttons extends StatefulWidget {
  const _Buttons({
    required this.themeColors,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  final ThemeColors themeColors;
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<_Buttons> createState() => _ButtonsState();
}

class _ButtonsState extends State<_Buttons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, AppRouter.signUpScreen);
            },
            child: const Text('Don\'t have an account'),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 40.h),
          child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
            buildWhen: (previous, current) {
              if (current is AuthenticationProfileImageChanged) {
                return false;
              } else {
                return true;
              }
            },
            builder: (context, state) {
              if (state is AuthenticationLoading) {
                return const CircularProgressIndicator();
              } else {
                return AuthButton(
                  context: context,
                  themeColors: widget.themeColors,
                  buttonName: 'Login',
                  onPressed: () {
                    if (widget.formKey.currentState?.validate() == true) {
                      BlocProvider.of<AuthenticationCubit>(context).loginInWithEmailAndPassword(
                        userLoginData: UserLoginData(
                          emailAddress: widget.emailController.text.trim(),
                          password: widget.passwordController.text.trim(),
                        ),
                      );
                    }
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
