import '../../domain/either/either.dart';
import '../../domain/failures/http_request/http_request_failure.dart';
import '../http/failure.dart';

Either<HttpRequestFailure, R> handleHttpFailure<R>(HttpFailure httpFailure) {
  print(httpFailure.exception);
  final failure = () {
    final statusCode = httpFailure.statusCode;

    switch (statusCode) {
      case 404:
        return HttpRequestFailure.notFound();
      case 401:
        return HttpRequestFailure.unauthorized();
    }

    if (httpFailure.exception is NetworkException) {
      return HttpRequestFailure.network();
    }
    return HttpRequestFailure.unknow();
  }();

  return Either.left(failure);
}
