import 'package:flutter/material.dart';
import 'package:fingerprint_dart_auth_sdk/fingerprint_dart_auth_sdk.dart';

class RequestPathTestScreen extends StatefulWidget {
  const RequestPathTestScreen({super.key});

  @override
  State<RequestPathTestScreen> createState() => _RequestPathTestScreenState();
}

class _RequestPathTestScreenState extends State<RequestPathTestScreen> {
  final _basePathController = TextEditingController(text: "/events/search");
  final _queryParamsController = TextEditingController(
    text: "query=login failure&page=1&limit=10",
  );

  String? _result;
  String? _error;

  void _buildRequestPath() {
    setState(() {
      _result = null;
      _error = null;
    });

    try {
      final basePath = _basePathController.text.trim();
      final queryParamsInput = _queryParamsController.text.trim();

      Map<String, dynamic>? queryParams;
      if (queryParamsInput.isNotEmpty) {
        queryParams = {
          for (var part in queryParamsInput.split("&"))
            part.split("=")[0]: part.split("=")[1],
        };
      }

      final path = getRequestPath(basePath, queryParams);
      setState(() {
        _result = path;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Test getRequestPath")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _basePathController,
              decoration: const InputDecoration(
                labelText: "Base Path",
                hintText: "/events/search",
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _queryParamsController,
              decoration: const InputDecoration(
                labelText: "Query Parameters",
                hintText: "key1=value1&key2=value2",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _buildRequestPath,
              child: const Text("Build Request Path"),
            ),
            const SizedBox(height: 20),
            if (_error != null)
              Text("Error: $_error", style: const TextStyle(color: Colors.red)),
            if (_result != null)
              SelectableText(
                "Result: $_result",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
