# Fingerprint Dart Auth SDK

Backend-oriented FingerprintJS helper SDK for Dart.

This package focuses on server-side verification and FingerprintJS Pro API integration. It exposes:

- `FingerprintJsServerApiClient` for integration metadata, verification, and visitor lookups
- `FingerprintAuth` for simple verification requests
- webhook signature validation via `isValidWebhookSignature(...)`
- typed response and filter models for events, visitors, and webhook payloads

## Installation

```yaml
dependencies:
  fingerprint_dart_auth_sdk: ^0.0.5
```

Then run:

```bash
dart pub get
```

## Preferred Initialization

```dart
import 'package:fingerprint_dart_auth_sdk/fingerprint_dart_auth_sdk.dart';

Future<void> main() async {
  final client = FingerprintJsServerApiClient(
    apiKey: 'your-fingerprint-secret-key',
    region: Region.us,
  );

  final integration = await client.getIntegrationInfo();
  print(integration);
}
```

## Common Operations

### Verify a payload

```dart
final auth = FingerprintAuth(apiKey: 'your-fingerprint-secret-key');

final response = await auth.verify('{"requestId":"req_123"}');
print(response);
```

### Fetch visitor data

```dart
final client = FingerprintJsServerApiClient(
  apiKey: 'your-fingerprint-secret-key',
);

final visitor = await client.getVisitorData('visitor_id');
print(visitor);
```

### Validate webhook signatures

```dart
final isValid = isValidWebhookSignature(
  payload: rawBody,
  signature: webhookSignature,
  secret: webhookSecret,
);

print(isValid);
```

## Package Layout

- `lib/src/api/` contains the FingerprintJS API clients and SDK error types
- `lib/src/types/` contains typed event, visitor, filter, and error models
- `lib/src/utils/` contains webhook, retry, path, and integration helpers
- `example/` contains sample integrations for Flutter and web consumers

## Security Guidance

- Keep Fingerprint secret API keys and webhook secrets on trusted backends.
- Validate webhook signatures before processing payloads.
- Treat visitor/event data as sensitive operational data and log it sparingly.

## Examples

See the `example/` directory for maintained sample projects and integration references.
