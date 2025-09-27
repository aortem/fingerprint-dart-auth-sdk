/// Represents the filtering criteria for searching events in the FingerprintJS Pro API.
class SearchEventsFilter {
  /// A search term to match against event properties.
  final String? query;

  /// The start timestamp or date for filtering events.
  final String? from;

  /// The end timestamp or date for filtering events.
  final String? to;

  /// The maximum number of events to return.
  final int? limit;

  /// The offset for pagination.
  final int? offset;

  /// The sort order or sort field (e.g., "asc", "desc", or a specific field name).
  final String? sort;

  /// Constructor
  SearchEventsFilter({
    this.query,
    this.from,
    this.to,
    this.limit,
    this.offset,
    this.sort,
  });

  /// Converts this instance into a JSON map.
  Map<String, dynamic> toJson() {
    return {
      if (query != null) 'query': query,
      if (from != null) 'from': from,
      if (to != null) 'to': to,
      if (limit != null) 'limit': limit,
      if (offset != null) 'offset': offset,
      if (sort != null) 'sort': sort,
    };
  }

  /// Creates an instance of [SearchEventsFilter] from a JSON map.
  factory SearchEventsFilter.fromJson(Map<String, dynamic> json) {
    return SearchEventsFilter(
      query: json['query'] as String?,
      from: json['from'] as String?,
      to: json['to'] as String?,
      limit: json['limit'] is int
          ? json['limit'] as int
          : int.tryParse(json['limit'].toString()),
      offset: json['offset'] is int
          ? json['offset'] as int
          : int.tryParse(json['offset'].toString()),
      sort: json['sort'] as String?,
    );
  }

  @override
  String toString() => toJson().toString();
}
