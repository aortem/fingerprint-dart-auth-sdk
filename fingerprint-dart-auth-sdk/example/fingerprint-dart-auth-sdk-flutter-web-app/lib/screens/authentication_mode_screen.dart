import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fingerprint_dart_auth_sdk/fingerprint_dart_auth_sdk.dart';
// import 'package:flutter_application_1/utils/globals.dart';

/// Simple request model with AuthenticationMode integrated.
class FingerprintRequest {
  final String visitorId;
  final AuthenticationMode authenticationMode;

  FingerprintRequest({
    required this.visitorId,
    this.authenticationMode = AuthenticationMode.standard,
  });

  Map<String, dynamic> toJson() {
    return {
      'visitorId': visitorId,
      'authenticationMode': authenticationMode.toString().split('.').last,
    };
  }
}

/// A screen to test AuthenticationMode behavior.
class AuthenticationModeScreen extends StatefulWidget {
  const AuthenticationModeScreen({super.key});

  @override
  State<AuthenticationModeScreen> createState() =>
      _AuthenticationModeScreenState();
}

class _AuthenticationModeScreenState extends State<AuthenticationModeScreen> {
  AuthenticationMode _selectedMode = AuthenticationMode.standard;
  String _response = "";

  void _sendRequest() async {
    setState(() {
      _response = "Processing...";
    });

    try {
      // Initialize SDK client
      // final fingerprintAuth = FingerprintAuth(
      //   apiKey: SECRET_API_KEY,
      //   baseUrl: BASE_URL,
      // );

      // Build request with selected mode
      final request = FingerprintRequest(
        visitorId: "visitor-12345",
        authenticationMode: _selectedMode,
      );

      // Mock: send verification (replace with real API call)
      // final result = await fingerprintAuth.verify(request.toJson());
      final result = {
        "status": "ok",
        "mode": request.authenticationMode.toString().split('.').last,
        "visitorId": request.visitorId,
      };

      setState(() {
        _response =
            "Request JSON:\n${jsonEncode(request.toJson())}\n\nResponse:\n${jsonEncode(result)}";
      });
    } catch (e) {
      setState(() {
        _response = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AuthenticationMode Demo")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Authentication Mode:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: const Text("Standard (default, relaxed)"),
              leading: Radio<AuthenticationMode>(
                value: AuthenticationMode.standard,
                groupValue: _selectedMode,
                onChanged: (mode) {
                  setState(() {
                    _selectedMode = mode!;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text("Strict (enforces high security)"),
              leading: Radio<AuthenticationMode>(
                value: AuthenticationMode.strict,
                groupValue: _selectedMode,
                onChanged: (mode) {
                  setState(() {
                    _selectedMode = mode!;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendRequest,
              child: const Text("Send Fingerprint Request"),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _response,
                  style: const TextStyle(fontFamily: "monospace"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
