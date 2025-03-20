import 'package:fingerprint_dart_auth_sdk/src/types/aortem_fingerprint_meta.dart';
import 'package:fingerprint_dart_auth_sdk/src/types/aortem_fingerprint_visitor.dart';

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

  @override
  String toString() {
    return 'VisitorsResponse(visitors: $visitors, meta: $meta)';
  }
}
