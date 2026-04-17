import 'dart:async';

import 'package:ds_standard_features/ds_standard_features.dart' as http;

typedef ResponseHandler = Future<http.Response> Function(http.BaseRequest request);

class FakeHttpClient extends http.BaseClient {
  FakeHttpClient(this._handler);

  final ResponseHandler _handler;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final response = await _handler(request);
    return http.StreamedResponse(
      Stream<List<int>>.value(response.bodyBytes),
      response.statusCode,
      headers: response.headers,
      reasonPhrase: response.reasonPhrase,
      request: request,
    );
  }
}
