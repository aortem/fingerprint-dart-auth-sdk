# Magic Dart Auth SDK

Magic Dart Auth SDK provides seamless authentication with Transmit Security for Dart applications. It offers an intuitive setup process with API key management, environment switching, and secure configuration handling.

## Features
- Easy authentication with Transmit Security
- API key-based and configurable setup
- Secure environment management
- Token generation and validation
- Support for multiple authentication flows

## Installation

Add `magic_dart_auth_sdk` to your Dart project's dependencies:

```sh
flutter pub add magic_dart_auth_sdk
```

or manually add it to `pubspec.yaml`:

```yaml
dependencies:
  magic_dart_auth_sdk: latest_version
```

## Usage

### Import the package

```dart
import 'package:magic_dart_auth_sdk/magic_dart_auth_sdk.dart';
```

### Initialize the SDK

```dart
final auth = MagicAuth(
  apiKey: 'your-api-key',
  environment: AuthEnvironment.production,
);
```

### Authenticate User

```dart
final authResponse = await auth.authenticate(username: 'user@example.com', password: 'password123');

if (authResponse.isSuccess) {
  print('User authenticated: ${authResponse.token}');
} else {
  print('Authentication failed: ${authResponse.error}');
}
```

### Token Validation

```dart
bool isValid = auth.validateToken('your-jwt-token');
print(isValid ? 'Token is valid' : 'Token is invalid');
```

## Configuration
You can also configure the SDK using environment variables:

```dart
final auth = MagicAuth.fromEnv();
```

Set up environment variables:

```sh
export MAGIC_AUTH_API_KEY='your-api-key'
export MAGIC_AUTH_ENV='production'
```

## License
This project is licensed under the MIT License.

---

For more details, check the official documentation or reach out for support.

