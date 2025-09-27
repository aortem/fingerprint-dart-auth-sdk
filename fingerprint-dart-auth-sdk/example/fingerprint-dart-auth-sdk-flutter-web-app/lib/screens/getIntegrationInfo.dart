import 'package:flutter/material.dart';
import 'package:fingerprint_dart_auth_sdk/fingerprint_dart_auth_sdk.dart';
import 'package:flutter_application_1/utils/globals.dart';

class IntegrationInfoScreen extends StatefulWidget {
  const IntegrationInfoScreen({super.key});

  @override
  State<IntegrationInfoScreen> createState() => _IntegrationInfoScreenState();
}

class _IntegrationInfoScreenState extends State<IntegrationInfoScreen> {
  IntegrationInfo? _integrationInfo;
  String? _error;
  bool _loading = false;

  final _client = FingerprintJsServerApiClient(apiKey: SECRET_API_KEY);

  Future<void> _fetchIntegrationInfo() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final info = await _client.getIntegrationInfo();
      setState(() {
        _integrationInfo = info;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Integration Info Test")),
      body: Center(
        child: _loading
            ? const CircularProgressIndicator()
            : _error != null
            ? Text("Error: $_error", style: const TextStyle(color: Colors.red))
            : _integrationInfo != null
            ? Card(
                elevation: 4,
                margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name: ${_integrationInfo!.name}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text("Type: ${_integrationInfo!.type}"),
                      Text("Version: ${_integrationInfo!.version}"),
                      Text("Public Key: ${_integrationInfo!.publicKey}"),
                    ],
                  ),
                ),
              )
            : ElevatedButton(
                onPressed: _fetchIntegrationInfo,
                child: const Text("Fetch Integration Info"),
              ),
      ),
    );
  }
}
