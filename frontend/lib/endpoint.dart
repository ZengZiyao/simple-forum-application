import 'dart:core';

class Endpoint {
  // NOTE: not realistic! we'll configure environment-specific variables in a soon to be
  // upcoming lesson
  static const apiScheme = 'http';
  static const apiHost = '127.0.0.1:8000';
  static const prefix = '/api';

  static Uri uri(String path, {Map<String, dynamic> queryParameters}) {
    final uri =  Uri(
      scheme: apiScheme,
      host: apiHost,
      path: '$prefix$path',
      queryParameters: queryParameters,
    );
    return uri;
  }
}