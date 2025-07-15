import 'dart:convert';

import 'package:fingerprint_dart_auth_sdk/fingerprint_dart_auth_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/server_request_tests.dart';
import 'package:flutter_application_1/utils/globals.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  //Setup Fingerprint Method

  String setupResponse = '';

  void setupTest() async {
    setState(() {
      setupResponse = 'Loading...';
    });
    try {
      //Constructor-based usage
      final fingerprintAuth = AortemFingerprintAuth(
        apiKey: SECRET_API_KEY,
        baseUrl: BASE_URL,
      );

      setupResponse =
          "Fingerprint SDK Initialized Successfully! $fingerprintAuth";
    } catch (e) {
      setupResponse = '$e';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test Authentication Methods')),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // setup widgets
              TextButton(
                onPressed: () {
                  setupTest();
                },
                child: const Text('Setup Fingerprint SDK'),
              ),
              Text(setupResponse),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const ServerTestScreen(),
                    ),
                  );
                },
                child: const Text('Test Server Request Methods'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
