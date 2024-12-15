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
