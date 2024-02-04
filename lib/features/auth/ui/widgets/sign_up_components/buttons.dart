part of '../../sign_up_screen.dart';

class Buttons extends StatelessWidget {
  const Buttons({
    super.key,
    required this.themeColors,
    required GlobalKey<FormState> formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.phoneNumberController,
  }) : _formKey = formKey;

  final ThemeColors themeColors;
  final GlobalKey<FormState> _formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController phoneNumberController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, AppRouter.loginScreen);
            },
            child: const Text('Do you have an account'),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
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
                  themeColors: themeColors,
                  buttonName: 'Sign up',
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true) {
                      BlocProvider.of<AuthenticationCubit>(context).createAccountWithEmailAndPassword(
                        userSignUpData: UserSignUpData(
                          userImage: kDefaultProfilePicture,
                          name: nameController.text,
                          emailAddress: emailController.text.toLowerCase().trim(),
                          password: passwordController.text.trim(),
                          phoneNumber: phoneNumberController.text.trim(),
                          isOnline: false,
                          lastActive: 0,
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
