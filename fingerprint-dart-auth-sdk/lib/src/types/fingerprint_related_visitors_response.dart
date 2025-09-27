import 'fingerprint_meta.dart';
import 'fingerprint_releated_visitor.dart';

/// Represents the response from the FingerprintJS Pro API when querying for related visitors.
class RelatedVisitorsResponse {
  /// The list of related visitor objects.
  final List<RelatedVisitor> visitors;

  /// Metadata about the response (e.g., pagination details).
  final Meta meta;

  /// Constructor to initialize the  relaeted visitors response.
  RelatedVisitorsResponse({required this.visitors, required this.meta});

  /// Creates an instance of [RelatedVisitorsResponse] from a JSON map.
  factory RelatedVisitorsResponse.fromJson(Map<String, dynamic> json) {
    if (json['visitors'] == null) {
      throw ArgumentError('Missing required field "visitors" in JSON.');
    }
    if (json['meta'] == null) {
      throw ArgumentError('Missing required field "meta" in JSON.');
    }

    return RelatedVisitorsResponse(
      visitors: (json['visitors'] as List<dynamic>)
          .map((e) => RelatedVisitor.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );
  }

  /// Converts this [RelatedVisitorsResponse] instance into a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'visitors': visitors.map((v) => v.toJson()).toList(),
      'meta': meta.toJson(),
    };
  }

  @override
  String toString() =>
      'RelatedVisitorsResponse(visitors: $visitors, meta: $meta)';
}
