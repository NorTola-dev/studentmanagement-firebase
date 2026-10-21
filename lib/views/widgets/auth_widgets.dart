import 'package:flutter/material.dart';
import 'package:studentmanagement/service/auth_service.dart';
import 'package:studentmanagement/views/screen/home_screen.dart';

const kDark = Color(0xFF1E232C);
const kFieldBg = Color(0xFFF7F8F9);
const kBorder = Color(0xFFE8ECF4);
const kHint = Color(0xFF8391A1);

class AuthScaffold extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final String bottomText;
  final String bottomAction;
  final VoidCallback onBottomTap;

  const AuthScaffold({
    super.key,
    required this.title,
    required this.children,
    required this.bottomText,
    required this.bottomAction,
    required this.onBottomTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12),
                    InkWell(
                      onTap: () => Navigator.maybePop(context),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: kFieldBg,
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 14,
                          color: kDark,
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 26,
                        height: 1.25,
                        fontWeight: FontWeight.w700,
                        color: kDark,
                      ),
                    ),
                    const SizedBox(height: 28),
                    ...children,
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            // Bottom link
            Padding(
              padding: const EdgeInsets.only(bottom: 18, top: 8),
              child: GestureDetector(
                onTap: onBottomTap,
                child: Text.rich(
                  TextSpan(
                    text: bottomText,
                    style: const TextStyle(color: kDark, fontSize: 13),
                    children: [
                      TextSpan(
                        text: bottomAction,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AuthField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final Widget? suffix;
  final TextInputType? keyboardType;

  const AuthField({
    super.key,
    required this.controller,
    required this.hint,
    this.obscure = false,
    this.suffix,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 14, color: kDark),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: kHint, fontSize: 14),
        filled: true,
        fillColor: kFieldBg,
        suffixIcon: suffix,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: kBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: kDark),
        ),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: kDark,
        foregroundColor: Colors.white,
        elevation: 0,
        minimumSize: const Size.fromHeight(52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class OrDivider extends StatelessWidget {
  final String text;
  const OrDivider({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: kBorder)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(text, style: const TextStyle(color: kDark, fontSize: 12)),
        ),
        const Expanded(child: Divider(color: kBorder)),
      ],
    );
  }
}

class SocialRow extends StatelessWidget {
  const SocialRow({super.key});

  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();
    return Row(
      children: [
        Expanded(
          child: SocialButton(
            onTap: () {},
            child: const Icon(
              Icons.facebook,
              color: Color(0xFF1877F2),
              size: 26,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: SocialButton(
            onTap: () async {
              var user = await authService.googleAuth();
              if (user != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Welcome home from google')),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              }
            },
            child: const Text(
              'G',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: Color(0xFFEA4335),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: SocialButton(
            onTap: () {},
            child: const Icon(Icons.apple, color: Colors.black, size: 28),
          ),
        ),
      ],
    );
  }
}

class SocialButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  const SocialButton({super.key, required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 52,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: kBorder),
        ),
        child: child,
      ),
    );
  }
}
