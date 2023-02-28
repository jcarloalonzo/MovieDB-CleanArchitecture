//
//

enum HttpMethod { get, post, patch, delete, put }

class HttpFailure {
  HttpFailure({this.statusCode, this.exception, this.data});

  final int? statusCode;
  final Object? exception;
  final Object? data;
}

class NetworkException {}



//
