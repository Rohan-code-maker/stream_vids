class AppExceptions implements Exception {
  final dynamic _message;
  final dynamic _prefix;

  AppExceptions([this._message, this._prefix]);

  @override
  String toString() {
    return "$_message$_prefix";
  }
}

class InternetException extends AppExceptions {
  InternetException([String? message])
      : super(message, "No Internet connection");
}

class RequestTimeout extends AppExceptions {
  RequestTimeout([String? message]) : super(message, "Request timeout");
}

class ServerException extends AppExceptions {
  ServerException([String? message]) : super(message, "Server error");
}

class InvalidUrlException extends AppExceptions {
  InvalidUrlException([String? message]) : super(message, "Invalid URL");
}

class FetchDataException extends AppExceptions {
  FetchDataException([String? message]) : super(message, "");
}

class BadRequestException extends AppExceptions {
  BadRequestException([String? message]) : super(message, "Bad request");
}

class UnauthorizedException extends AppExceptions {
  UnauthorizedException([String? message]) : super(message, "Unauthorized");
}

class ForbiddenException extends AppExceptions {
  ForbiddenException([String? message]) : super(message, "Forbidden");
}

class MethodNotAllowedException extends AppExceptions {
  MethodNotAllowedException([String? message])
      : super(message, "Method not allowed");
}

class RequestTimeoutException extends AppExceptions {
  RequestTimeoutException([String? message])
      : super(message, "Request timeout");
}

class ConflictException extends AppExceptions {
  ConflictException([String? message]) : super(message, "Conflict");
}

class UnprocessableEntityException extends AppExceptions {
  UnprocessableEntityException([String? message])
      : super(message, "Unprocessable entity");
}

class NotImplementedException extends AppExceptions {
  NotImplementedException([String? message]) : super(message, "Not implemented");
}

class BadGatewayException extends AppExceptions {
  BadGatewayException([String? message]) : super(message, "Bad gateway");
}

class ServiceUnavailableException extends AppExceptions {
  ServiceUnavailableException([String? message])
      : super(message, "Service unavailable");
}

class GatewayTimeoutException extends AppExceptions {
  GatewayTimeoutException([String? message])
      : super(message, "Gateway timeout");
}