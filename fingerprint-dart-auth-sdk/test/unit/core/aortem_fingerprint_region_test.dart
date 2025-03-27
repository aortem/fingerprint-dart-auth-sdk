import 'package:ds_tools_testing/ds_tools_testing.dart';
import 'package:fingerprint_dart_auth_sdk/src/core/aortem_fingerprint_region.dart';

void main() {
  group('Region Enum', () {
    test('should have correct enum values', () {
      expect(Region.us.toString(), 'Region.us');
      expect(Region.eu.toString(), 'Region.eu');
      expect(Region.asia.toString(), 'Region.asia');
    });

    test('should return default region as US', () {
      expect(Region.defaultRegion, Region.us);
    });

    test('should convert from string to enum', () {
      expect(Region.values.byName('us'), Region.us);
      expect(Region.values.byName('eu'), Region.eu);
      expect(Region.values.byName('asia'), Region.asia);
    });

    test('should throw an error for invalid name', () {
      expect(
          () => Region.values.byName('invalid'), throwsA(isA<ArgumentError>()));
    });
  });
}
