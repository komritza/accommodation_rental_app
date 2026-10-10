enum ApiFailureType { network, http, invalidResponse, unexpected }

class ApiFailure {
  const ApiFailure({required this.type, this.statusCode, this.message});

  final ApiFailureType type;
  final int? statusCode;
  final String? message;
}
