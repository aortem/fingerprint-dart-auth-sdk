class RelatedVisitor {
  final String id;
  final String name;

  RelatedVisitor({required this.id, required this.name});

  factory RelatedVisitor.fromJson(Map<String, dynamic> json) {
    return RelatedVisitor(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  String toString() => 'RelatedVisitor(id: $id, name: $name)';
}
