import 'package:ds_tools_testing/ds_tools_testing.dart';
import 'package:mockito/mockito.dart';
import '../../mocks/fingerprint_auth_mock.dart';

void main() {
  group('fingerprintAuth Tests', () {
    late MockfingerprintAuth mockfingerprintAuth;

    setUp(() {
      mockfingerprintAuth = MockfingerprintAuth();
    });

    test('performRequest handles typed arguments correctly', () async {
      // Arrange
      const endpoint = 'update';
      const body = {'key': 'value'};
      final expectedResponse = HttpResponse(
        statusCode: 200,
        body: {'message': 'Success'},
      );

      when(mockfingerprintAuth.performRequest(endpoint, body))
          .thenAnswer((_) async => expectedResponse);

      // Act
      final result = await mockfingerprintAuth.performRequest(endpoint, body);

      // Assert
      expect(result.statusCode, equals(200));
      expect(result.body, containsPair('message', 'Success'));

      verify(mockfingerprintAuth.performRequest(endpoint, body)).called(1);
    });
  });
}
