part of '../../sign_up_screen.dart';

class _SignUpBody extends StatefulWidget {
  const _SignUpBody({required this.themeColors});

  final ThemeColors themeColors;

  @override
  State<_SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<_SignUpBody> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController phoneNumberController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    phoneNumberController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double customTextHeightPadding = 5.h;
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
            Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: const ProfileImage(),
            ),
            Padding(
              padding: EdgeInsets.all(customTextHeightPadding),
              child: CustomTextForm(
                emailController: nameController,
                hintText: 'Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(customTextHeightPadding),
              child: CustomTextForm(
                emailController: emailController,
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
                emailController: passwordController,
                hintText: 'Password',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(customTextHeightPadding),
              child: CustomTextForm(
                emailController: phoneNumberController,
                hintText: 'Phone Number',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
                onFieldSubmitted: (value) {
                  if (_formKey.currentState?.validate() == true) {
                    BlocProvider.of<AuthenticationCubit>(context).createAccountWithEmailAndPassword(
                      userSignUpData: UserSignUpData(
                        userImage: kDefaultProfilePicture,
                        name: nameController.text,
                        emailAddress: emailController.text.toLowerCase().trim(),
                        password: passwordController.text.trim(),
                        phoneNumber: phoneNumberController.text.trim(),
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

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          BlocBuilder<AuthenticationCubit, AuthenticationState>(
            buildWhen: (previous, current) {
              if (current is AuthenticationProfileImageChanged) {
                return true;
              } else {
                return false;
              }
            },
            builder: (context, state) {
              return SizedBox(
                height: 165.r,
                width: 165.r,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.r),
                  child: (state is AuthenticationProfileImageChanged)
                      ? Image.file(
                          File(state.profileImage),
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          kDefaultProfilePicture,
                          fit: BoxFit.fitWidth,
                        ),
                ),
              );
            },
          ),
          Positioned(
            top: 100.h,
            left: 120.w,
            child: Container(
              width: 45.r,
              height: 45.r,
              decoration: BoxDecoration(
                color: const Color(0xff01aa84),
                borderRadius: BorderRadius.circular(30),
              ),
              child: IconButton(
                onPressed: () {
                  BlocProvider.of<AuthenticationCubit>(context).pickImageFromGallery();
                },
                icon: const Icon(
                  Icons.camera_alt_rounded,
                  size: 22,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
