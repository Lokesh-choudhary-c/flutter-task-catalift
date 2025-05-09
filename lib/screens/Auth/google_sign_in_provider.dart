import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final googleSignInProvider = Provider<GoogleSignIn>((ref) {
  return GoogleSignIn();
});

final googleUserProvider = StateProvider<GoogleSignInAccount?>((ref) => null);

final signInControllerProvider = Provider((ref) {
  return () async {
    final googleSignIn = ref.read(googleSignInProvider);
    final user = await googleSignIn.signIn();
    ref.read(googleUserProvider.notifier).state = user;
  };
});
