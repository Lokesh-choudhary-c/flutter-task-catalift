// ignore_for_file: use_build_context_synchronously

import 'package:catalift_task/screens/Auth/sign_in_screen.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initApp();
  }

Future<void> _initApp() async {
  await Future.delayed(const Duration(seconds: 2)); 
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => const GoogleSignInScreen()),
  );
}

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF0A0B75), 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "CATALIFT",
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}




