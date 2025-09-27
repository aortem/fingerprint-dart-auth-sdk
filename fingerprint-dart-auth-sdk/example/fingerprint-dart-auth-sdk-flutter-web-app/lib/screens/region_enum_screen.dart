import 'package:flutter/material.dart';
import 'package:fingerprint_dart_auth_sdk/fingerprint_dart_auth_sdk.dart';

class RegionTestScreen extends StatefulWidget {
  const RegionTestScreen({super.key});

  @override
  State<RegionTestScreen> createState() => _RegionTestScreenState();
}

class _RegionTestScreenState extends State<RegionTestScreen> {
  final TextEditingController _visitorIdController = TextEditingController(
    text: 'test-visitor-123',
  );

  Region _selectedRegion = Region.defaultRegion;
  String _output = '';

  void _simulateRequest() {
    final request = FingerprintRequest(
      visitorId: _visitorIdController.text,
      region: _selectedRegion,
    );

    setState(() {
      _output = request.toJson().toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fingerprint Region Test")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Enter Visitor ID:"),
            TextField(
              controller: _visitorIdController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter unique visitor ID',
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
                  child: Text(region.name),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _simulateRequest,
              child: const Text("Simulate Request"),
            ),
            const SizedBox(height: 16),
            const Text(
              "Generated JSON:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SelectableText(_output),
          ],
        ),
      ),
    );
  }
}

class FingerprintRequest {
  final String visitorId;
  final Region region;

  FingerprintRequest({
    required this.visitorId,
    this.region = Region.defaultRegion,
  });

  Map<String, dynamic> toJson() {
    return {'visitorId': visitorId, 'region': region.name};
  }
}
