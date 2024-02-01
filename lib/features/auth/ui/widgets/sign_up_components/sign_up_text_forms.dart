part of '../../sign_up_screen.dart';

class SignUpTextForms extends StatefulWidget {
  const SignUpTextForms({
    super.key,
    required this.nameController,
    required this.themeColors,
    required this.emailController,
    required this.phoneNumberController,
    required GlobalKey<FormState> formKey,
    required this.passwordController,
  }) : _formKey = formKey;

  final TextEditingController nameController;
  final ThemeColors themeColors;
  final TextEditingController emailController;
  final TextEditingController phoneNumberController;
  final GlobalKey<FormState> _formKey;
  final TextEditingController passwordController;

  @override
  State<SignUpTextForms> createState() => _SignUpTextFormsState();
}

class _SignUpTextFormsState extends State<SignUpTextForms> {
  bool obscureText = true;
  double customTextHeightPadding = 8.r;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(customTextHeightPadding),
          child: CustomTextForm(
            emailController: widget.nameController,
            hintText: 'Name',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
            keyboardType: TextInputType.name,
            icon: Icons.person,
            themeColors: widget.themeColors,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(customTextHeightPadding),
          child: CustomTextForm(
            emailController: widget.emailController,
            hintText: 'Email',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,
            icon: Icons.email_rounded,
            themeColors: widget.themeColors,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(customTextHeightPadding),
          child: StatefulBuilder(builder: (context, setState) {
            return CustomTextForm(
              obscureText: obscureText,
              emailController: widget.passwordController,
              hintText: 'Password',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
              keyboardType: TextInputType.visiblePassword,
              icon: Icons.password_rounded,
              themeColors: widget.themeColors,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                icon: Icon(
                  obscureText ? CupertinoIcons.eye_solid : CupertinoIcons.eye_slash_fill,
                  color: widget.themeColors.bodyIconColor,
                ),
              ),
            );
          }),
        ),
        Padding(
          padding: EdgeInsets.all(customTextHeightPadding),
          child: CustomTextForm(
            keyboardType: TextInputType.phone,
            icon: Icons.phone,
            emailController: widget.phoneNumberController,
            hintText: 'Phone Number',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              return null;
            },
            onFieldSubmitted: (value) {
              if (widget._formKey.currentState?.validate() == true) {
                BlocProvider.of<AuthenticationCubit>(context).createAccountWithEmailAndPassword(
                  userSignUpData: UserSignUpData(
                    userImage: kDefaultProfilePicture,
                    name: widget.nameController.text,
                    emailAddress: widget.emailController.text.toLowerCase().trim(),
                    password: widget.passwordController.text.trim(),
                    phoneNumber: widget.phoneNumberController.text.trim(),
                  ),
                );
              }
            },
            themeColors: widget.themeColors,
          ),
        ),
      ],
    );
  }
}
