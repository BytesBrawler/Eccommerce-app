import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/widgets/bottom_bar.dart';
import '../providers/user_provider.dart';
import 'admin/screens/admin_screen.dart';
import 'auth/screens/auth_screens.dart';
import 'auth/services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    nextStep();
  }

  void nextStep() {
    //
    Timer(const Duration(milliseconds: 500), () async {
      await authService.getUserData(context);
      // ignore: use_build_context_synchronously
      Provider.of<UserProvider>(context, listen: false).user.token.isNotEmpty
          // ignore: use_build_context_synchronously
          ? Provider.of<UserProvider>(context, listen: false).user.type ==
                  "user"
              // ignore: use_build_context_synchronously
              ? Navigator.pushReplacementNamed(context, BottomBar.routeName)
              // ignore: use_build_context_synchronously
              : Navigator.pushReplacementNamed(context, AdminScreen.routeName)
          //     : const AdminScreen()
          // ignore: use_build_context_synchronously
          : Navigator.pushReplacementNamed(context, AuthScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
            'assets/images/amazon_in.png'),
      ),
    );
  }
}
