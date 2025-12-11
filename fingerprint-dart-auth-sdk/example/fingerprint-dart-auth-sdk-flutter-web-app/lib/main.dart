import 'package:fingerprint_dart_auth_sdk/fingerprint_dart_auth_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/ErrorPlainResponse_type.dart';
import 'package:flutter_application_1/screens/ErrorResponse.dart';
import 'package:flutter_application_1/screens/EventsFetchScreen.dart';
import 'package:flutter_application_1/screens/Options_interface_test.dart';
import 'package:flutter_application_1/screens/RelatedVisitorsFilter.dart';
import 'package:flutter_application_1/screens/RelatedVisitorsResponse.dart';
import 'package:flutter_application_1/screens/SearchEventsFilter_type.dart';
import 'package:flutter_application_1/screens/SearchEventsResponse_type.dart';
import 'package:flutter_application_1/screens/VisitorsResponseScreen.dart';
import 'package:flutter_application_1/screens/WebhookTestScreen.dart';
import 'package:flutter_application_1/screens/authentication_mode_screen.dart';
import 'package:flutter_application_1/screens/decryption_algorithm_screen.dart';
import 'package:flutter_application_1/screens/decryption_key.dart';
import 'package:flutter_application_1/screens/event_update_response.dart';
import 'package:flutter_application_1/screens/eventget_response.dart';
import 'package:flutter_application_1/screens/fingerprint_api_type.dart';
import 'package:flutter_application_1/screens/fingerprint_js_server_api_client.dart';
import 'package:flutter_application_1/screens/getIntegrationInfo.dart';
import 'package:flutter_application_1/screens/get_retry_after.dart';
import 'package:flutter_application_1/screens/isValidWebhookSignature_test.dart';
import 'package:flutter_application_1/screens/region_enum_screen.dart';
import 'package:flutter_application_1/screens/request_path_test_screen.dart';
import 'package:flutter_application_1/screens/server_request_error.dart';
import 'package:flutter_application_1/screens/server_sdk_error.dart';
import 'package:flutter_application_1/screens/toomany_ratelimit.dart';
import 'package:flutter_application_1/screens/unsealed_aggregator_error.dart';
import 'package:flutter_application_1/screens/unsealed_error.dart';
import 'package:flutter_application_1/screens/visitor_history_screen.dart';
import 'package:flutter_application_1/utils/globals.dart';

// Entry point
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fingerprint SDK Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

/// HomePage with navigation buttons for SDK Features
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String setupResponse = '';

  void setupTest() async {
    setState(() {
      setupResponse = 'Loading...';
    });
    try {
      final fingerprintAuth = FingerprintAuth(
        apiKey: SECRET_API_KEY,
        baseUrl: BASE_URL,
      );
      setupResponse =
          "Fingerprint SDK Initialized Successfully! $fingerprintAuth";
    } catch (e) {
      setupResponse = 'Error: $e';
    }
    setState(() {});
  }

  Widget buildButton(String label, Widget screen) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
        },
        child: Text(label),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fingerprint SDK Feature Tests')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: setupTest,
              child: const Text('Setup Fingerprint SDK'),
            ),
            Text(setupResponse, style: const TextStyle(color: Colors.green)),

            const SizedBox(height: 10),

            buildButton(
              'Test Server Request Methods',
              const FingerprintSDKerror(),
            ),
            buildButton(
              'AuthenticationMode Demo',
              const AuthenticationModeScreen(),
            ),
            buildButton(
              'DecryptionAlgorithm Enum',
              const DecryptionAlgorithmScreen(),
            ),
            buildButton('Region Enum Test', const RegionTestScreen()),
            buildButton(
              'FingerprintJS Server API Test',
              const FingerprintJSTestScreen(),
            ),
            buildButton(
              'SDK Error Handling Test',
              const FingerprintSdkTestScreen(),
            ),
            buildButton(
              'TooManyRequestsError',
              const FingerprintRateLimitTestScreen(),
            ),
            buildButton(
              'UnsealAggregateError',
              const UnsealAggregateTestScreen(),
            ),
            buildButton('UnsealError', const UnsealErrorTestScreen()),
            buildButton('Decryption Key Test', const DecryptionTestScreen()),
            buildButton(
              'Validate Webhook Signature',
              const WebhookSignatureTestScreen(),
            ),
            buildButton('Options Interface Test', const SdkFeatureTestScreen()),
            buildButton(
              'ErrorPlainResponse Test',
              const ErrorPlainResponseTestScreen(),
            ),
            buildButton('ErrorResponse Test', const ErrorResponseTestScreen()),
            buildButton('EventsGetResponse Test', const EventsTestScreen()),
            buildButton('Event Update Test', const EventsUpdateScreen()),
            buildButton('Fetch Events', const EventsFetchScreen()),
            buildButton(
              'FingerprintApi type',
              const FingerprintWebTestScreen(),
            ),
            buildButton(
              'Related Visitors Filter Test',
              const RelatedVisitorsFilterScreen(),
            ),
            buildButton(
              'Related Visitors Response',
              const RelatedVisitorsScreen(),
            ),
            buildButton(
              'Search Events with Filters',
              const SearchEventsScreen(),
            ),
            buildButton(
              'Search Events with Query String',
              const SearchEventsResponseScreen(),
            ),
            buildButton('Visitor History Test', const VisitorHistoryScreen()),
            buildButton(
              'Visitors Response Test',
              const VisitorsResponseScreen(),
            ),
            buildButton('Webhook Type', const WebhookTestScreen()),
            buildButton(
              'getintegration function',
              const IntegrationInfoScreen(),
            ),
            buildButton('getRetryAfter Test', const RetryAfterTestScreen()),
            buildButton(
              'getRequestPath Function Test',
              const RequestPathTestScreen(),
            ),
            buildButton(
              'isValidWebhookSignature Function Test',
              const WebhookTestScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
