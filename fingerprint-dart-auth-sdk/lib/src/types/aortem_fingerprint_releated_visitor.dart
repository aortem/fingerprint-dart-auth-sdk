/// Represents a related visitor associated with an event in FingerprintJS Pro API.
class RelatedVisitor {
  /// The unique identifier of the related visitor.
  final String id;

  /// The name of the related visitor.
  final String name;

  /// Constructor to initialize a RelatedVisitor instance.
  RelatedVisitor({required this.id, required this.name});

  /// Factory constructor to create a RelatedVisitor instance from JSON.
  factory RelatedVisitor.fromJson(Map<String, dynamic> json) {
    return RelatedVisitor(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  /// Converts a RelatedVisitor instance to JSON.
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  @override
  String toString() => 'RelatedVisitor(id: $id, name: $name)';
}
