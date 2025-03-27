import 'dart:io';

/// Extracts the retry duration from the HTTP response headers when a rate limit (429) error occurs.
///
/// - If the `Retry-After` header contains a number, it is interpreted as seconds.
/// - If the header contains a valid date string, the function computes the duration from now to that time.
/// - If the header is missing or invalid, returns `null`.
Duration? getRetryAfter(Map<String, String> headers) {
  final retryAfterValue = headers[HttpHeaders.retryAfterHeader];

  if (retryAfterValue == null) {
    return null; // No Retry-After header present
  }

  // Check if the value is a number (seconds)
  final seconds = int.tryParse(retryAfterValue);
  if (seconds != null) {
    return Duration(seconds: seconds);
  }

  // Check if the value is a valid HTTP date
  try {
    final retryAfterDate = HttpDate.parse(retryAfterValue);
    final now = DateTime.now().toUtc();
    
    if (retryAfterDate.isAfter(now)) {
      return retryAfterDate.difference(now);
    }
  } catch (_) {
    // Ignore parsing errors and return null
  }

  return null; // Invalid Retry-After value
}
