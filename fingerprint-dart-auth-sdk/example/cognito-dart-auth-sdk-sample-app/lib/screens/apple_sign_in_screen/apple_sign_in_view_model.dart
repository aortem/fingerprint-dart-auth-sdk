import 'package:fingerprint_dart_auth_sdk/fingerprint_dart_auth_sdk.dart';

class AppleSignInViewModel {
  final fingerprintAuth auth;

  AppleSignInViewModel({required this.auth});

  Future<UserCredential> signInWithApple(String idToken,
      {String? nonce}) async {
    if (idToken.isEmpty) {
      throw fingerprintAuthException(
        code: 'invalid-id-token',
        message: 'Apple ID Token must not be empty',
      );
    }

    return await auth.signInWithApple(idToken, nonce: nonce);
  }
}
