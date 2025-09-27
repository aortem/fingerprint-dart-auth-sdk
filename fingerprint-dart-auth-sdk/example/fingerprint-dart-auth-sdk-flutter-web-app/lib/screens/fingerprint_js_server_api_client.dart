import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fingerprint_dart_auth_sdk/fingerprint_dart_auth_sdk.dart';
import 'package:flutter_application_1/utils/globals.dart';

class FingerprintJSTestScreen extends StatefulWidget {
  const FingerprintJSTestScreen({super.key});

  @override
  State<FingerprintJSTestScreen> createState() =>
      _FingerprintJSTestScreenState();
}

class _FingerprintJSTestScreenState extends State<FingerprintJSTestScreen> {
  final TextEditingController _apiKeyController = TextEditingController(
    text: SECRET_API_KEY,
  );
  final TextEditingController _visitorIdController = TextEditingController(
    text: TEST_VISITOR,
  );

  Region _selectedRegion = Region.defaultRegion;
  String _output = "";
  bool _isLoading = false;

  Future<void> _performRequest(
    Future<Map<String, dynamic>> Function(FingerprintJsServerApiClient) action,
  ) async {
    setState(() {
      _isLoading = true;
      _output = "Loading...";
    });

    try {
      final client = FingerprintJsServerApiClient(
        apiKey: _apiKeyController.text.trim(),
        region: _selectedRegion,
      );

      final result = await action(client);
      setState(() {
        _output = const JsonEncoder.withIndent("  ").convert(result);
      });
    } catch (e) {
      setState(() {
        _output = "Error: $e";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("FingerprintJS Server API Test")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("API Key:"),
              TextField(
                controller: _apiKeyController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter API Key",
                ),
              ),
              const SizedBox(height: 16),

              const Text("Visitor ID:"),
              TextField(
                controller: _visitorIdController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Visitor ID",
                ),
              ),
              const SizedBox(height: 16),

              const Text("Select Region:"),
              DropdownButton<Region>(
                value: _selectedRegion,
                onChanged: (region) {
                  if (region != null) {
                    setState(() {
                      _selectedRegion = region;
                    });
                  }
                },
                items: Region.values.map((region) {
                  return DropdownMenuItem(
                    value: region,
                    child: Text(region.name.toUpperCase()),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              Wrap(
                spacing: 12,
                children: [
                  ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : () => _performRequest(
                            (c) => c.verifyFingerprint({
                              "visitorId": _visitorIdController.text.trim(),
                            }),
                          ),
                    child: const Text("Verify Fingerprint"),
                  ),
                  ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : () => _performRequest((c) async {
                            final response = await c.getVisitorData(
                              _visitorIdController.text.trim(),
                            );
                            return jsonDecode(jsonEncode(response));
                          }),
                    child: const Text("Get Visitor Data"),
                  ),
                  ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : () => _performRequest((c) async {
                            final info = await c.getIntegrationInfo();
                            return jsonDecode(jsonEncode(info));
                          }),
                    child: const Text("Integration Info"),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              const Text(
                "Response:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.black12,
                ),
                child: SelectableText(_output),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
