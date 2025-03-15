class Meta {
  /// The total number of items.
  final int count;

  /// The current page number.
  final int page;

  /// The number of items per page.
  final int limit;

  /// Constructor for [Meta].
  const Meta({
    required this.count,
    required this.page,
    required this.limit,
  });

  /// Factory constructor to create an instance from a JSON object.
  factory Meta.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('count') ||
        !json.containsKey('page') ||
        !json.containsKey('limit')) {
      throw ArgumentError('Missing required Meta fields.');
    }

    return Meta(
      count: json['count'] is int
          ? json['count'] as int
          : int.tryParse(json['count'].toString()) ?? 0,
      page: json['page'] is int
          ? json['page'] as int
          : int.tryParse(json['page'].toString()) ?? 0,
      limit: json['limit'] is int
          ? json['limit'] as int
          : int.tryParse(json['limit'].toString()) ?? 0,
    );
  }

  /// Converts an instance to a JSON representation.
  Map<String, dynamic> toJson() => {
        'count': count,
        'page': page,
        'limit': limit,
      };

  @override
  String toString() => 'Meta(count: $count, page: $page, limit: $limit)';
}
