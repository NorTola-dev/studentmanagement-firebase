import 'package:flutter/material.dart';
import 'package:studentmanagement/service/auth_service.dart';
import 'package:studentmanagement/views/screen/login_screen.dart';
import 'package:studentmanagement/views/widgets/auth_widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  AuthService service = AuthService();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Hello! Register to get\nstarted',
      bottomText: 'Already have an account? ',
      bottomAction: 'Login Now',
      onBottomTap: () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
      ),
      children: [
        AuthField(controller: usernameController, hint: 'Username'),
        SizedBox(height: 14),
        AuthField(
          controller: emailController,
          hint: 'Email',
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 14),
        AuthField(
          controller: passwordController,
          hint: 'Password',
          obscure: true,
        ),
        SizedBox(height: 14),
        AuthField(
          controller: confirmController,
          hint: 'Confirm password',
          obscure: true,
        ),
        SizedBox(height: 28),
        PrimaryButton(
          label: 'Register',
          onPressed: () async {
            String username = usernameController.text.trim();
            String email = emailController.text.trim();
            String password = passwordController.text.trim();
            String confirmPassword = confirmController.text.trim();

            if (username.isEmpty ||
                email.isEmpty ||
                password.isEmpty ||
                confirmPassword.isEmpty) {
              showSnackBar("Please input all fields");
            } else if (!email.contains('@gmail.com')) {
              showSnackBar("Email Erorr");
            } else if (password.length < 6) {
              showSnackBar("Password Error");
            } else if (password != confirmPassword) {
              showSnackBar("Password not match");
            } else {
              var user = await service.register(email, password);
              if (user != null) {
                showSnackBar('Welcome home');
              }
            }
          },
        ),
        SizedBox(height: 22),
        OrDivider(text: 'Or Register with'),
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
