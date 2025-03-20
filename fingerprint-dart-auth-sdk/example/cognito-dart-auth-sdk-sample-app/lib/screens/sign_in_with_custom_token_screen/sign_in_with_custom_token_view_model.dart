import 'package:bot_toast/bot_toast.dart';
import 'package:fingerprint_dart_auth_sdk/fingerprint_dart_auth_sdk.dart';
import 'package:flutter/material.dart';

class SignInWithCustomTokenViewModel extends ChangeNotifier {
  bool loading = false;
  void setLoading(bool load) {
    loading = load;
    notifyListeners();
  }

  Future<void> signInWithCustomToken(String uid, VoidCallback onSuccess) async {
    try {
      setLoading(true);

      await fingerprintApp.fingerprintAuth?.signInWithCustomToken(uid);

      onSuccess();
    } catch (e) {
      BotToast.showText(text: e.toString());
    }
    setLoading(false);
  }
}
