part of '../../login_screen.dart';

class EmailPasswordTextForm extends StatefulWidget {
  const EmailPasswordTextForm({
    super.key,
    required this. emailController,
    required this.themeColors, required this.passwordController, required this.formKey,
  }) ;

  final TextEditingController emailController;
  final GlobalKey<FormState> formKey;
  final TextEditingController passwordController;
  final ThemeColors themeColors;

  @override
  State<EmailPasswordTextForm> createState() => _EmailPasswordTextFormState();
}

class _EmailPasswordTextFormState extends State<EmailPasswordTextForm> {

  bool obscureText = true;


  @override
  Widget build(BuildContext context) {
    double customTextHeightPadding = 10.r;

    return Column(
      children: [
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
            themeColors:widget.themeColors,
          ),
        ),

        Padding(
          padding: EdgeInsets.all(customTextHeightPadding),
          child: StatefulBuilder(builder: (context, setState) {
            return CustomTextForm(
              obscureText: obscureText,
              emailController:widget. passwordController,
              hintText: 'Password',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
              onFieldSubmitted: (String value) {
                if (widget.formKey.currentState?.validate() == true) {
                  BlocProvider.of<AuthenticationCubit>(context).loginInWithEmailAndPassword(
                    userLoginData: UserLoginData(
                      emailAddress:widget. emailController.text.trim(),
                      password:widget. passwordController.text.trim(),
                    ),
                  );
                }
              },
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
              keyboardType: TextInputType.visiblePassword,
              icon: Icons.password_rounded,
              themeColors: widget.themeColors,
            );
          }),
        ),
      ],
    );
  }
}
