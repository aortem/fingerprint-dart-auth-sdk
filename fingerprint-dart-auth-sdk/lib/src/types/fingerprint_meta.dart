/// Represents metadata information related to API responses, such as pagination details.
class Meta {
  /// The total number of items available.
  final int count;

  /// The current page number in the paginated response.
  final int page;

  /// The number of items returned per page.
  final int limit;

  /// Constructor for initializing [Meta] with required parameters.
  ///
  /// Ensures that [count], [page], and [limit] are properly assigned.
  const Meta({required this.count, required this.page, required this.limit});

  /// Factory constructor to create an instance of [Meta] from a JSON object.
  ///
  /// Throws an [ArgumentError] if any of the required fields (`count`, `page`, or `limit`) are missing.
  factory Meta.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('count') ||
        !json.containsKey('page') ||
        !json.containsKey('limit')) {
      throw ArgumentError('Missing required Meta fields.');
    }

    return Meta(
      count:
          json['count'] is int
              ? json['count'] as int
              : int.tryParse(json['count'].toString()) ?? 0,
      page:
          json['page'] is int
              ? json['page'] as int
              : int.tryParse(json['page'].toString()) ?? 0,
      limit:
          json['limit'] is int
              ? json['limit'] as int
              : int.tryParse(json['limit'].toString()) ?? 0,
    );
  }

  /// Converts the [Meta] instance to a JSON representation.
  Map<String, dynamic> toJson() => {
    'count': count,
    'page': page,
    'limit': limit,
  };

  @override
  String toString() => 'Meta(count: $count, page: $page, limit: $limit)';
}
