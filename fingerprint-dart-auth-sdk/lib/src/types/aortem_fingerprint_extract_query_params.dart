/// Represents query parameters for API requests in a structured format.
class ExtractQueryParams {
  /// A map containing query parameters.
  final Map<String, dynamic> params;

  /// Constructor for creating an ExtractQueryParams instance.
  ExtractQueryParams({required this.params}) {
    if (params.isEmpty) {
      throw ArgumentError('params cannot be empty.');
    }
  }

  /// Converts the parameters to a URL-encoded query string.
  String toQueryString() {
    return params.entries
        .map(
          (entry) =>
              '${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value.toString())}',
        )
        .join('&');
  }

  /// Factory constructor to create an instance from a query string.
  factory ExtractQueryParams.fromQueryString(String queryString) {
    if (queryString.isEmpty) {
      throw ArgumentError('queryString cannot be empty.');
    }

    final Map<String, dynamic> parsedParams = {};
    final pairs = queryString.split('&');

    for (var pair in pairs) {
      final keyValue = pair.split('=');
      if (keyValue.length != 2) {
        throw FormatException('Invalid query string format.');
      }
      parsedParams[Uri.decodeComponent(keyValue[0])] = Uri.decodeComponent(
        keyValue[1],
      );
    }

    return ExtractQueryParams(params: parsedParams);
  }

  /// Converts the query parameters to a JSON representation.
  Map<String, dynamic> toJson() => params;
}
