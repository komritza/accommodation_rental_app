enum ApiFailureType { network, http, invalidResponse, unexpected }

class ApiFailure {
  const ApiFailure({
    required this.type,
    this.statusCode,
    this.messageCode,
    this.message,
  });

  final ApiFailureType type;
  final int? statusCode;

  /// The API's stable error code, such as `error.badRequest`. The wording a
  /// user reads is mapped from this, never taken from [message].
  final String? messageCode;
  final String? message;
}
