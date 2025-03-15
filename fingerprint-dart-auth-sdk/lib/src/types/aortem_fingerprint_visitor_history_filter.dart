/// Represents the filtering criteria for querying visitor history
/// from the FingerprintJS Pro API.
class VisitorHistoryFilter {
  /// The start date or timestamp for filtering visitor history records (ISO 8601 format).
  final String? from;

  /// The end date or timestamp for filtering visitor history records (ISO 8601 format).
  final String? to;

  /// The maximum number of history records to return.
  final int? limit;

  /// The offset for pagination (for fetching paginated results).
  final int? offset;

  /// Optionally, a specific visitor identifier to filter by.
  final String? visitorId;

  VisitorHistoryFilter({
    this.from,
    this.to,
    this.limit,
    this.offset,
    this.visitorId,
  });

  /// Creates an instance of [VisitorHistoryFilter] from a JSON map.
  factory VisitorHistoryFilter.fromJson(Map<String, dynamic> json) {
    return VisitorHistoryFilter(
      from: json['from'] as String?,
      to: json['to'] as String?,
      limit: json['limit'] as int?,
      offset: json['offset'] as int?,
      visitorId: json['visitorId'] as String?,
    );
  }

  /// Converts this [VisitorHistoryFilter] instance into a JSON map.
  Map<String, dynamic> toJson() {
    return {
      if (from != null) 'from': from,
      if (to != null) 'to': to,
      if (limit != null) 'limit': limit,
      if (offset != null) 'offset': offset,
      if (visitorId != null) 'visitorId': visitorId,
    };
  }

  /// Converts the filter to a URL query string (for API requests).
  String toQueryString() {
    final queryParams = toJson().entries
        .map((entry) => '${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value.toString())}')
        .join('&');

    return queryParams.isNotEmpty ? '?$queryParams' : '';
  }

  @override
  String toString() {
    return 'VisitorHistoryFilter(from: $from, to: $to, limit: $limit, offset: $offset, visitorId: $visitorId)';
  }
}
