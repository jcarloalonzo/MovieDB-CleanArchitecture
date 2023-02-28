import 'package:freezed_annotation/freezed_annotation.dart';

part 'http_request_failure.freezed.dart';
part 'http_request_failure.g.dart';

@freezed
class HttpRequestFailure with _$HttpRequestFailure {
  factory HttpRequestFailure() = _HttpRequestFailure;

  factory HttpRequestFailure.fromJson(Map<String, dynamic> json) =>
      _$HttpRequestFailureFromJson(json);
}
