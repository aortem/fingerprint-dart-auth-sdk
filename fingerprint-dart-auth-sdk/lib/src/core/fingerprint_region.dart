// lib/src/core/region.dart
/// Represents the geographic region for processing fingerprint requests.
enum Region {
  /// United States region (default).
  us,

  /// European region.
  eu,

  /// Asia-Pacific region.
  asia;

  /// Returns the default region if none is specified.
  static const Region defaultRegion = Region.us;
}
