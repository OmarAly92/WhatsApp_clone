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
    return SafeArea(
      child: Form(
        key: _formKey,
        child: _BlocListener(
          child: Column(
            children: [
              const _ProfileImage(),
              SignUpTextForms(
                nameController: nameController,
                themeColors: widget.themeColors,
                emailController: emailController,
                phoneNumberController: phoneNumberController,
                formKey: _formKey,
                passwordController: passwordController,
              ),
              Buttons(
                themeColors: widget.themeColors,
                formKey: _formKey,
                nameController: nameController,
                emailController: emailController,
                passwordController: passwordController,
                phoneNumberController: phoneNumberController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
