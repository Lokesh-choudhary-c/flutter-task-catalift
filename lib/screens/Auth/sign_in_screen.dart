// ignore_for_file: use_build_context_synchronously

import 'package:catalift_task/screens/Auth/google_sign_in_provider.dart';
import 'package:catalift_task/screens/Home_screen/education_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GoogleSignInScreen extends ConsumerWidget {
  const GoogleSignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(googleUserProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Google Sign In"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: user == null
              ? ElevatedButton(
                  onPressed: () async {
                    await ref.read(signInControllerProvider)();
                    if (ref.read(googleUserProvider) != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const EducationDetailsScreen(),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    shadowColor: Colors.grey,
                    elevation: 2,
                    side: const BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/googleicon.png',
                        height: 24,
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Sign in with Google',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Welcome, ${user.displayName}"),
                    const SizedBox(height: 12),
                    CircleAvatar(
                      backgroundImage: NetworkImage(user.photoUrl ?? ""),
                      radius: 40,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
