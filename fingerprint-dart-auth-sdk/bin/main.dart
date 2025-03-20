//import 'package:fingerprint_dart_auth_sdk/src/fingerprint_auth.dart';

void main() async {
  final auth =
      fingerprintAuth(apiKey: 'YOUR_API_KEY', projectId: 'YOUR_PROJECT_ID');

  try {
    // Sign up a new user
    final newUser = await auth.createUserWithEmailAndPassword(
        'newuser@aortem.com', 'password123');
    print('User created: ${newUser.user.displayName}');
    print('User created: ${newUser.user.email}');

    // Sign in with the new user
    final userCredential = await auth.signInWithEmailAndPassword(
        'newuser@aortem.com', 'password123');
    print('Signed in: ${userCredential?.user.email}');
  } catch (e) {
    print('Error: $e');
  }
}
