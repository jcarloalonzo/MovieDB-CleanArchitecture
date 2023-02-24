import 'dart:io';

import 'package:http/http.dart';

import '../../domain/either/either.dart';

enum HttpMethod { get, post, patch, delete, put }

class HttpFailure {
  HttpFailure({this.statusCode, this.exception});

  final int? statusCode;
  final Object? exception;
}

class NetworkException {}

class Http {
  Http(this._baseUrl, this._apiKey, this._client);

// +SON INYECCIONES DE DEPENDECIA FACILMENTE TESTEABLES CON PRUEBAS UNITARIAS
  final String _baseUrl;
  final String _apiKey;
  final Client _client;

  Future<Either<HttpFailure, String>> request(
    String path, {
    HttpMethod method = HttpMethod.get,
    Map<String, String> headers = const {},
    Map<String, String> queryParameters = const {},
    bool userApiKey = true,
  }) async {
    try {
      if (userApiKey) {
        queryParameters = {
          ...queryParameters,
          'api_key': _apiKey,
        };
      }

      Uri url = Uri.parse(
        path.startsWith('http') ? path : '$_baseUrl$path',
      );

      if (queryParameters.isNotEmpty) {
        url = url.replace(queryParameters: queryParameters);
      }

      headers = {
        'Content-Type': 'application/json',
        ...headers,
      };

      late final Response response;

      switch (method) {
        case HttpMethod.get:
          response = await _client.get(url);
          break;
        case HttpMethod.post:
          response = await _client.post(
            url,
            headers: headers,
          );

          break;
        case HttpMethod.patch:
          response = await _client.patch(
            url,
            headers: headers,
          );

          break;
        case HttpMethod.delete:
          response = await _client.delete(url);

          break;
        case HttpMethod.put:
          await _client.put(url);

          break;
      }

      final statusCode = response.statusCode;

      if (statusCode >= 200 && statusCode < 300) {
        // SI SE CUMPLE ES PORQUE LA FUNCION SE CUMPLIO E
        return Either.right(response.body);
      }

      return Either.left(
        HttpFailure(
          statusCode: statusCode,
        ),
      );
    } catch (e) {
      // SocketException , pertenece al paquete dart:io lo que significa que no es compatible en web

      if (e is SocketException || e is ClientException) {
        Either.left(
          HttpFailure(
            exception: NetworkException(),
          ),
        );
      }

      return Either.left(
        HttpFailure(exception: e),
      );
    }
  }
}
