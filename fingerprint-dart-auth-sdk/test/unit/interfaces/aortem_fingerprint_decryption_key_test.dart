import 'package:ds_tools_testing/ds_tools_testing.dart';
import 'package:fingerprint_dart_auth_sdk/src/interfaces/aortem_fingerprint_decryption_key.dart';

void main() {
  group('DefaultDecryptionKey', () {
    test('should create a valid DefaultDecryptionKey instance', () {
      final key = DefaultDecryptionKey(id: '12345', key: 'my-secret-key');
      expect(key.id, equals('12345'));
      expect(key.key, equals('my-secret-key'));
    });

    test('should throw ArgumentError when id is empty', () {
      expect(
        () => DefaultDecryptionKey(id: '', key: 'my-secret-key'),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('should throw ArgumentError when key is empty', () {
      expect(
        () => DefaultDecryptionKey(id: '12345', key: ''),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('should convert to JSON correctly', () {
      final key = DefaultDecryptionKey(id: '12345', key: 'my-secret-key');
      final json = key.toJson();
      expect(json, {'id': '12345', 'key': 'my-secret-key'});
    });
  });
}
