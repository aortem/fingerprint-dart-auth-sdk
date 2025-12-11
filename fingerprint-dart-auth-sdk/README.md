# Fingerprint Dart Auth SDK

## Overview

The **Fingerprint Dart Auth SDK** provides a unified API for biometric (fingerprint/face) authentication across Flutter mobile, desktop, and server-side Dart environments. With this SDK you can:

* Prompt the user for biometric verification (fingerprint, face ID)  
* Fall back to PIN or passcode if biometrics aren’t available or fail  
* Securely cache and verify session tokens post-authentication  
* Integrate with platform keystores (Android Keystore, iOS Keychain, Windows Hello)  
* Customize prompts, timeouts, and retry logic  

Whether you’re building a Flutter mobile app, a desktop client, or a Dart server that needs to verify device possession, this SDK makes adding biometric security seamless.

---

## Features

* **Cross-Platform Biometric API**  
  - Fingerprint, Touch ID, Face ID on mobile/desktop  
  - Automatic detection of available modalities  

* **PIN/Passcode Fallback**  
  - Configurable fallback to a numeric PIN or device passcode  
  - Pluggable storage for PIN verification  

* **Secure Token Handling**  
  - Encrypt and cache session tokens in platform keystores  
  - Automatic expiry checks and forced re-authentication  

* **Customizable UX**  
  - Override default prompt titles, subtitles, and error messages  
  - Control timeout, maximum retries, and UI styling  

* **Server-Side Verification**  
  - Challenge/response flows for headless Dart services  
  - Validate client-provided biometric proof via signed tokens  

* **Extensible Storage**  
  - Default implementations for file, in-memory, and keystore backends  
  - Implement your own `SecureStorage` for database or cloud caching  

---

## Getting Started

### 1. Prerequisites

* Flutter ≥ 2.10 (with `local_auth` plugin) or Dart ≥ 2.14  
* An Android or iOS device/emulator with biometrics enabled (for mobile)  
* Windows 10+ with Windows Hello (for desktop)  

### 2. Configure Your App

#### Flutter

1. Add the `local_auth` plugin and enable biometrics in your `AndroidManifest.xml` and `Info.plist`.  
2. Ensure your app has the appropriate entitlements for Face ID / Touch ID on iOS.

#### Dart Server

- No special platform setup; you’ll issue and verify signed tokens based on client assertions.

---

## Installation

Add the SDK to your project:

```bash
# Dart:
dart pub add fingerprint_dart_auth_sdk

# Flutter:
flutter pub add fingerprint_dart_auth_sdk
````

Or manually in your `pubspec.yaml`:

```yaml
dependencies:
  fingerprint_dart_auth_sdk: ^0.0.2
```

Then fetch:

```bash
dart pub get
```

---

## Usage

### Initialize the SDK

```dart
import 'package:fingerprint_dart_auth_sdk/fingerprint_dart_auth_sdk.dart';

void main() async {
  final auth = FingerprintAuth(
    storage: SecureKeychainStorage(),   // or FileStorage(), MemoryStorage()
    promptConfig: PromptConfig(
      title: 'Verify your identity',
      subtitle: 'Use fingerprint or passcode',
      timeoutSeconds: 30,
      maxRetries: 3,
    ),
  );
}
```

### Authenticate with Biometrics

```dart
final result = await auth.authenticate();

// result.isSuccess == true if fingerprint (or face) verified
if (result.isSuccess) {
  // Issue your session token
  final token = await auth.issueSessionToken(userId: 'alice');
} else {
  print('Authentication failed or cancelled: ${result.errorMessage}');
}
```

### PIN/Passcode Fallback

```dart
// If biometrics unavailable, fallback to PIN
final pinResult = await auth.authenticateWithPin(
  pinValidator: (pin) => pin == '1234',
);

if (pinResult.isSuccess) {
  // PIN accepted
}
```

### Silent Token Refresh

```dart
// Checks stored session token, re-authenticates if expired
final session = await auth.getSession();
if (!session.isValid) {
  await auth.authenticate(); // triggers biometric or PIN again
}
```

---

## Advanced

* **Custom Storage**

  ```dart
  class MySecureDbStorage implements SecureStorage {
    // implement saveToken, loadToken, clearToken
  }

  auth.setStorage(MySecureDbStorage());
  ```

* **Server-Side Verification**

  ```dart
  // Verify a client’s signed biometric assertion
  final isValid = await auth.verifyBiometricProof(
    assertionJwt: clientJwt,
    publicKey: myPublicKey,
  );
  ```

* **UI Styling**

  ```dart
  auth.promptConfig = auth.promptConfig.copyWith(
    subtitle: 'Touch the sensor or enter your PIN',
    analyticsEnabled: true,
  );
  ```

---

## Documentation

For full API reference, examples, and troubleshooting, see our GitBook:

👉 [Fingerprint Dart Auth SDK Docs](https://aortem.gitbook.io/fingerprint-dart-auth-sdk/)

```
