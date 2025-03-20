import 'package:bot_toast/bot_toast.dart';
import 'package:fingerprint_dart_auth_sdk/fingerprint_dart_auth_sdk.dart';
import 'package:flutter/material.dart';

class SetLanguageCodeScreenViewModel extends ChangeNotifier {
  bool loading = false;

  void setLoading(bool load) {
    loading = load;
    notifyListeners();
  }

  Future<void> setLanguageCode(String languageCode) async {
    try {
      setLoading(true);

      await fingerprintApp.fingerprintAuth?.setLanguageCode(languageCode);

      BotToast.showText(text: 'Success');
    } catch (e) {
      BotToast.showText(text: e.toString());
    } finally {
      setLoading(false);
    }
  }
}
