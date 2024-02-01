part of '../../login_screen.dart';

class _LoginBody extends StatefulWidget {
  const _LoginBody({required this.themeColors});

  final ThemeColors themeColors;

  @override
  State<_LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<_LoginBody> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  bool obscureText = true;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: _BlocListener(
          child: Column(
            children: [
              _CircleImage(themeColors: widget.themeColors),
              EmailPasswordTextForm(
                emailController: _emailController,
                themeColors: widget.themeColors,
                passwordController: _passwordController,
                formKey: _formKey,
              ),
              _Buttons(
                themeColors: widget.themeColors,
                formKey: _formKey,
                emailController: _emailController,
                passwordController: _passwordController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
