import 'package:fingerprint_dart_auth_sdk/src/types/fingerprint_meta.dart';
import 'package:fingerprint_dart_auth_sdk/src/types/fingerprint_visitor.dart';

/// Represents the response from the FingerprintJS Pro API when fetching visitors data.
class VisitorsResponse {
  /// A list of visitors returned by the API.
  final List<Visitor> visitors;

  /// Metadata about the response, such as pagination details.
  final Meta meta;

  /// Constructor to initialize the visitors response.
  ///
  /// Requires a list of [visitors] and metadata [meta].
  VisitorsResponse({required this.visitors, required this.meta});

  factory VisitorsResponse.fromJson(Map<String, dynamic> json) {
    return VisitorsResponse(
      visitors: (json['visitors'] as List<dynamic>)
          .map((v) => Visitor.fromJson(v as Map<String, dynamic>))
          .toList(),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'visitors': visitors.map((v) => v.toJson()).toList(),
      'meta': meta.toJson(),
    };
  }

  @override
  String toString() {
    return 'VisitorsResponse(visitors: $visitors, meta: $meta)';
  }
}
