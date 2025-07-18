import 'package:fingerprint_dart_auth_sdk/fingerprint_dart_auth_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/globals.dart';

class ServerTestScreen extends StatefulWidget {
  const ServerTestScreen({super.key});

  @override
  State<ServerTestScreen> createState() => _ServerTestScreenState();
}

class _ServerTestScreenState extends State<ServerTestScreen> {
  late FingerprintJsServerApiClient jsClient;

  @override
  void initState() {
    super.initState();

    try {
      jsClient = FingerprintJsServerApiClient(
        apiKey: SECRET_API_KEY,
        baseUrl: BASE_URL,
      );
    } on SdkError catch (e) {
      getVisitsResponse = 'RequestError caught: ${e.toString()}';
    }
  }

  //Setup Fingerprint Method

  String getVisitsResponse = '';

  void getVisitsTest() async {
    setState(() {
      getVisitsResponse = 'Loading...';
    });
    try {
      final response = await jsClient.getVisitorData(TEST_VISITOR);

      getVisitsResponse = "Visitor Data Fetched Successfully: ${response}";
    } on RequestError catch (e) {
      getVisitsResponse = 'RequestError caught: ${e.toString()}';

      // Additional error handling can be implemented here.
    } catch (e) {
      getVisitsResponse = 'An unexpected error occurred: $e';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test Server Methods')),
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
                  getVisitsTest();
                },
                child: const Text('Get Visits By Visitor ID Test'),
              ),
              Text(getVisitsResponse),
            ],
          ),
        ),
      ),
    );
  }
}
