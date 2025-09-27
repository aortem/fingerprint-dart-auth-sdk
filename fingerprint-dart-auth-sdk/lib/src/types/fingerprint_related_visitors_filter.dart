/// Represents filtering criteria for retrieving related visitors.
class RelatedVisitorsFilter {
  /// A start date or timestamp filter (ISO 8601 format).
  final String? from;

  /// An end date or timestamp filter (ISO 8601 format).
  final String? to;

  /// The maximum number of related visitors to return.
  final int? limit;

  /// A specific visitor identifier to filter by.
  final String? visitorId;

  /// An alternative identifier (if applicable) to filter by.
  final String? distinctId;

  /// Constructor for [RelatedVisitorsFilter], all fields are optional.
  RelatedVisitorsFilter({
    this.from,
    this.to,
    this.limit,
    this.visitorId,
    this.distinctId,
  });

  /// Converts this object to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      if (from != null) 'from': from,
      if (to != null) 'to': to,
      if (limit != null) 'limit': limit,
      if (visitorId != null) 'visitorId': visitorId,
      if (distinctId != null) 'distinctId': distinctId,
    };
  }

  /// Creates an instance from a JSON map.
  factory RelatedVisitorsFilter.fromJson(Map<String, dynamic> json) {
    return RelatedVisitorsFilter(
      from: json['from'] as String?,
      to: json['to'] as String?,
      limit: json['limit'] as int?,
      visitorId: json['visitorId'] as String?,
      distinctId: json['distinctId'] as String?,
    );
  }

  /// Converts this filter to a URL query string.
  String toQueryString() {
    final params = toJson().entries
        .map(
          (e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value.toString())}',
        )
        .join('&');
    return params.isNotEmpty ? '?$params' : '';
  }
}
