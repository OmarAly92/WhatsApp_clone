part of '../../login_screen.dart';

class _LoginBody extends StatefulWidget {
  const _LoginBody({required this.themeColors});

  final ThemeColors themeColors;

  @override
  State<_LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<_LoginBody> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _phoneNumberController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _phoneNumberController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double customTextHeightPadding = 10.h;
    return Form(
      key: _formKey,
      child: BlocListener<AuthenticationCubit, AuthenticationState>(
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
        child: Column(
          children: [
            SizedBox(height: 200.h),
            Padding(
              padding: EdgeInsets.all(customTextHeightPadding),
              child: CustomTextForm(
                emailController: _emailController,
                hintText: 'Email',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(customTextHeightPadding),
              child: CustomTextForm(
                emailController: _passwordController,
                hintText: 'Password',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onFieldSubmitted: (String value) {
                  if (_formKey.currentState?.validate() == true) {
                    BlocProvider.of<AuthenticationCubit>(context).loginInWithEmailAndPassword(
                      userLoginData: UserLoginData(
                        emailAddress: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                      ),
                    );
                  }
                },
              ),
            ),
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
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
                buildWhen: (previous, current) {
                  if (current is AuthenticationProfileImageChanged) {
                    return false;
                  } else if (previous is AuthenticationProfileImageChanged) {
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
                        if (_formKey.currentState?.validate() == true) {
                          BlocProvider.of<AuthenticationCubit>(context).loginInWithEmailAndPassword(
                            userLoginData: UserLoginData(
                              emailAddress: _emailController.text.trim(),
                              password: _passwordController.text.trim(),
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
        ),
      ),
    );
  }
}
