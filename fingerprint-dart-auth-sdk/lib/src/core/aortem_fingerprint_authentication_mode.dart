/// Represents the strictness level for fingerprint authentication.
enum AuthenticationMode {
  /// Enforces high security with strict verification criteria.
  strict,

  /// Allows a more relaxed verification approach with some tolerance for variation.
  standard,
}
