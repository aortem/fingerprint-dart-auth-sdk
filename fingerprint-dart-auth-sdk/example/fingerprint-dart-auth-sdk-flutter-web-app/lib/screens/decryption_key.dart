import 'package:flutter/material.dart';
import 'package:fingerprint_dart_auth_sdk/fingerprint_dart_auth_sdk.dart';

/// Example decrypter that uses [DecryptionKey].
class DataDecrypter {
  String decrypt(String encryptedData, DecryptionKey decryptionKey) {
    if (encryptedData.isEmpty) {
      throw ArgumentError('Encrypted data cannot be empty.');
    }
    // Demo logic only.
    return 'Decrypted($encryptedData) with key id: ${decryptionKey.id}';
  }
}

// ---- Flutter Web Screen ----

class DecryptionTestScreen extends StatefulWidget {
  const DecryptionTestScreen({super.key});

  @override
  State<DecryptionTestScreen> createState() => _DecryptionTestScreenState();
}

class _DecryptionTestScreenState extends State<DecryptionTestScreen> {
  final _encryptedController = TextEditingController();
  String? _decryptedResult;

  void _runDecryption() {
    try {
      final decryptionKey = DefaultDecryptionKey(
        id: 'key-123',
        key: 'secret-key-value',
      );
      final decrypter = DataDecrypter();
      final result = decrypter.decrypt(
        _encryptedController.text.trim(),
        decryptionKey,
      );

      setState(() {
        _decryptedResult = result;
      });
    } catch (e) {
      setState(() {
        _decryptedResult = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fingerprint SDK Decryption Test')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Enter Encrypted Payload:'),
            TextField(
              controller: _encryptedController,
              decoration: const InputDecoration(
                hintText: 'encrypted_payload_here',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _runDecryption,
              child: const Text('Decrypt'),
            ),
            const SizedBox(height: 24),
            if (_decryptedResult != null) ...[
              const Text(
                'Decryption Result:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(_decryptedResult!),
            ],
          ],
        ),
      ),
    );
  }
}
