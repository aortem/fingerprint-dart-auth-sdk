/// Represents the parameters required to validate a webhook signature.
abstract class IsValidWebhookSignatureParams {
  /// The raw body of the webhook request.
  String get payload;

  /// The signature provided with the webhook (typically from a request header).
  String get signature;

  /// The secret key used to compute the expected signature.
  String get secret;
}

/// A default implementation of [IsValidWebhookSignatureParams].
class DefaultWebhookSignatureParams implements IsValidWebhookSignatureParams {
  @override
  final String payload;
  @override
  final String signature;
  @override
  final String secret;

  /// Constructor that requires all necessary parameters.
  DefaultWebhookSignatureParams({
    required this.payload,
    required this.signature,
    required this.secret,
  }) {
    if (payload.isEmpty) {
      throw ArgumentError('Payload cannot be empty.');
    }
    if (signature.isEmpty) {
      throw ArgumentError('Signature cannot be empty.');
    }
    if (secret.isEmpty) {
      throw ArgumentError('Secret cannot be empty.');
    }
  }

  /// Converts the object into a JSON representation.
  Map<String, dynamic> toJson() {
    return {
      'payload': payload,
      'signature': signature,
      'secret': secret,
    };
  }
}
