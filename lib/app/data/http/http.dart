import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../../domain/either/either.dart';

class Http {
  // client es publico asi que asignamops
  Http(
      {required Client client, required String baseUrl, required String apiKey})
      : _client = client,
        _apiKey = apiKey,
        _baseUrl = baseUrl;

// +SON INYECCIONES DE DEPENDECIA FACILMENTE TESTEABLES CON PRUEBAS UNITARIAS
  final String _baseUrl;
  final String _apiKey;
  final Client _client;

  Future<Either<HttpFailure, R>> request<R>(
    String path, {
    HttpMethod method = HttpMethod.get,
    Map<String, String> headers = const {},
    Map<String, String> queryParameters = const {},
    Map<String, dynamic> body = const {},
    required R Function(String responseBody) onSuccess,
    bool userApiKey = true,
  }) async {
    Map<String, dynamic> logs = {};
    StackTrace? stackTrace;

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
      final bodyString = jsonEncode(body);

      logs = {
        'url': url.toString(),
        'method': method.name,
        'body': body,
      };

      switch (method) {
        case HttpMethod.get:
          response = await _client.get(url);
          break;
        case HttpMethod.post:
          response = await _client.post(
            url,
            headers: headers,
            body: bodyString,
          );
          break;
        case HttpMethod.patch:
          response = await _client.patch(
            url,
            headers: headers,
            body: bodyString,
          );

          break;
        case HttpMethod.delete:
          response = await _client.delete(url);

          break;
        case HttpMethod.put:
          await _client.put(
            url,
            body: bodyString,
          );

          break;
      }

      final statusCode = response.statusCode;

      logs = {
        ...logs,
        'startTime': DateTime.now().toString(),
        'statusCode': statusCode,
        'responseBody': response.body,
      };

      if (statusCode >= 200 && statusCode < 300) {
        // SI SE CUMPLE ES PORQUE LA FUNCION SE CUMPLIO E
        return Either.right(onSuccess(response.body));
      }

      return Either.left(
        HttpFailure(
          statusCode: statusCode,
        ),
      );
    } catch (e, s) {
      stackTrace = s;

      // * EL STACKTRACE NOS PERMITE SABER EN QUE LINEA OCURRIO NUESTRO ERROR
      // SocketException , pertenece al paquete dart:io lo que significa que no es compatible en web
      logs = {
        ...logs,
        'exception': e.runtimeType,
      };
      if (e is SocketException || e is ClientException) {
        logs = {
          ...logs,
          'exception': 'NetworkException',
        };
        Either.left(
          HttpFailure(
            exception: NetworkException(),
          ),
        );
      }

      return Either.left(
        HttpFailure(exception: e),
      );
    } finally {
// el finnally siempre se ejecuta en un trycatch
      if (kDebugMode) {
        logs = {
          ...logs,
          'endTime': DateTime.now().toString(),
        };
        log('''
🔥
-----------------------------------------------------------------
${(const JsonEncoder.withIndent(' ').convert(logs))}
-----------------------------------------------------------------
🔥
''', stackTrace: stackTrace);
      }
    }
  }
}

enum HttpMethod { get, post, patch, delete, put }

class HttpFailure {
  HttpFailure({this.statusCode, this.exception});

  final int? statusCode;
  final Object? exception;
}

class NetworkException {}
