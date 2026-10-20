import 'package:flutter/material.dart';
import 'package:studentmanagement/service/auth_service.dart';
import 'package:studentmanagement/views/screen/register_screen.dart';
import 'package:studentmanagement/views/widgets/auth_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscure = true;

  AuthService service = AuthService();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Welcome back! Glad\nto see you. Again!',
      bottomText: "Don't have an account? ",
      bottomAction: 'Register Now',
      onBottomTap: () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => RegisterScreen()),
      ),
      children: [
        AuthField(
          controller: emailController,
          hint: 'Enter your email',
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 14),
        AuthField(
          controller: passwordController,
          hint: 'Enter your password',
          obscure: obscure,
          suffix: IconButton(
            icon: Icon(
              obscure
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              size: 20,
              color: kHint,
            ),
            onPressed: () => setState(() => obscure = !obscure),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 8),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              'Forgot Password?',
              style: TextStyle(color: kDark, fontSize: 12),
            ),
          ),
        ),
        SizedBox(height: 18),
        PrimaryButton(
          label: 'Login',
          onPressed: () async {
            String email = emailController.text.trim();
            String password = passwordController.text.trim();

            if (email.isEmpty || password.isEmpty) {
              showSnackBar("Please input all fields");
            } else if (!email.contains('@gmail.com')) {
              showSnackBar("Email Erorr");
            } else if (password.length < 6) {
              showSnackBar("Password Error");
            } else {
              var user = await service.login(email, password);
              if (user != null) {
                showSnackBar('Welcome home');
              }
            }
          },
        ),
        SizedBox(height: 22),
        OrDivider(text: 'Or Login with'),
        SizedBox(height: 18),
        SocialRow(),
      ],
    );
  }

  void showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    return;
  }
}
