import 'package:flutter/widgets.dart';
import 'package:studentmanagement/service/auth_service.dart';
import 'package:studentmanagement/views/screen/get_started_view.dart';
import 'package:studentmanagement/views/screen/home_screen.dart';

class CurrnetUserScreen extends StatefulWidget {
  const CurrnetUserScreen({super.key});

  @override
  State<CurrnetUserScreen> createState() => _CurrnetUserScreenState();
}

class _CurrnetUserScreenState extends State<CurrnetUserScreen> {
  AuthService auth = AuthService();
  @override
  Widget build(BuildContext context) {
    if (auth.currentUser() != null) {
      return HomeScreen();
    } else {
      return GetStartedScreen();
    }
  }
}
