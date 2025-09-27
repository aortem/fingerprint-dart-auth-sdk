/// Constructs a properly encoded request path with optional query parameters.
///
/// - [basePath]: The base endpoint path.
/// - [queryParams]: Optional map of query parameters.
///
/// Returns a URL-encoded request path.
String getRequestPath(String basePath, [Map<String, dynamic>? queryParams]) {
  if (basePath.isEmpty) {
    throw ArgumentError('Base path cannot be empty.');
  }

  if (queryParams == null || queryParams.isEmpty) {
    return basePath;
  }

  final encodedQueryParams = queryParams.entries
      .map(
        (e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value.toString())}',
      )
      .join('&');

  return '$basePath?$encodedQueryParams';
}
