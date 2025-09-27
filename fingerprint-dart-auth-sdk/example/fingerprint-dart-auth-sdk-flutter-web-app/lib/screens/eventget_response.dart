import 'package:flutter/material.dart';
import 'package:fingerprint_dart_auth_sdk/fingerprint_dart_auth_sdk.dart';
import 'dart:convert';

class EventsTestScreen extends StatefulWidget {
  const EventsTestScreen({super.key});

  @override
  State<EventsTestScreen> createState() => _EventsTestScreenState();
}

class _EventsTestScreenState extends State<EventsTestScreen> {
  String _output = "";

  void _testValidJson() {
    final jsonMap = {
      'events': [
        {
          'id': 'event1',
          'timestamp': '2023-01-01T12:00:00Z',
          'details': {'action': 'login', 'user': 'john_doe'},
        },
        {
          'id': 'event2',
          'timestamp': '2023-01-01T12:30:00Z',
          'details': {'action': 'logout', 'user': 'john_doe'},
        },
      ],
      'meta': {
        'page': 1,
        'limit': 20,
        'total': 2,
      }.map((k, v) => MapEntry(k, v is int ? v : int.parse(v.toString()))),
    };

    final response = EventsGetResponse.fromJson(jsonMap);

    setState(() {
      _output =
          "✅ Parsed Successfully\n\n"
          "Total Events: ${response.events.length}\n"
          "Meta: ${jsonEncode(response.meta.toJson())}\n\n"
          "Events:\n${response.events.map((e) => jsonEncode(e.toJson())).join("\n")}";
    });
  }

  void _testInvalidJson() {
    final badJson = {
      // missing "meta"
      'events': [
        {
          'id': 'event1',
          'timestamp': '2023-01-01T12:00:00Z',
          'details': {'action': 'login'},
        },
      ],
    };

    try {
      EventsGetResponse.fromJson(badJson);
    } catch (e) {
      setState(() {
        _output = "❌ Parsing Failed\n\nException: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("EventsGetResponse SDK Test")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _testValidJson,
              child: const Text("Test Valid JSON"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _testInvalidJson,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text("Test Invalid JSON"),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _output,
                  style: const TextStyle(fontSize: 14, fontFamily: "monospace"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
