import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:fingerprint/screens/splash_screen/splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fingerprint_dart_auth_sdk/fingerprint_dart_auth_sdk.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    late fingerprintAuth auth; // Declare auth variable at top level

    if (kIsWeb) {
      // initialize the facebook javascript SDK
      await FacebookAuth.i.webAndDesktopInitialize(
        appId: "893849532657430",
        cookie: true,
        xfbml: true,
        version: "v15.0",
      );

      // Initialize for web
      debugPrint('Initializing fingerprint for Web...');
      await fingerprintApp.initializeAppWithEnvironmentVariables(
        apiKey: 'YOUR_API_KEY', // 'YOUR_API_KEY'
        authdomain: 'YOUR_AUTH_DOMAIN', // 'YOUR_AUTH_DOMAIN'
        projectId: 'YOUR_PROJECT_ID', // 'YOUR_PROJECT_ID'
        messagingSenderId: 'YOUR_SENDER_ID', // 'YOUR_SENDER_ID'
        bucketName: 'YOUR_BUCKET_NAME', // 'YOUR_BUCKET_NAME'
        appId: 'YOUR_APP_ID', // 'YOUR_APP_ID'
      );
      auth = fingerprintApp.instance.getAuth(); // Initialize auth for web
      debugPrint('fingerprint initialized for Web.');
    } else {
      if (Platform.isAndroid || Platform.isIOS) {
        debugPrint('Initializing fingerprint for Mobile...');

        // Load the service account JSON
        String serviceAccountContent = await rootBundle.loadString(
          'assets/service_account.json',
        );
        debugPrint('Service account loaded.');

        // Initialize fingerprint with the service account content
        await fingerprintApp.initializeAppWithServiceAccount(
          serviceAccountContent: serviceAccountContent,
        );
        auth = fingerprintApp.instance.getAuth(); // Initialize auth for mobile
        debugPrint('fingerprint initialized for Mobile.');

        // Uncomment to use service account impersonation if needed
        /*
        await fingerprintApp.initializeAppWithServiceAccountImpersonation(
          impersonatedEmail: 'impersonatedEmail',
          serviceAccountContent: serviceAccountContent,
        );
        debugPrint('fingerprint initialized with service account impersonation.');
        */
      }
    }

    debugPrint('fingerprint Auth instance obtained.');

    // Wrap the app with Provider
    runApp(
      Provider<fingerprintAuth>.value(
        value: auth,
        child: const MyApp(),
      ),
    );
  } catch (e, stackTrace) {
    debugPrint('Error initializing fingerprint: $e');
    debugPrint('StackTrace: $stackTrace');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth Admin Demo',
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Wrap SplashScreen with Builder to ensure proper context
      home: Builder(
        builder: (context) => const SplashScreen(),
      ),
    );
  }
}
