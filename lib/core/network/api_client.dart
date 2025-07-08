import 'dart:convert';

import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  static const String baseUrl = "https://jsonplaceholder.typicode.com";

  final HttpWithMiddleware _client;

  ApiClient()
      : _client = HttpWithMiddleware.build(
    middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ],
  );

  // Properly joins base URL and path
  Uri _buildUri(String path) {
    // Prevent double slashes
    String sanitizedPath = path.startsWith('/') ? path : '/$path';
    return Uri.parse('$baseUrl$sanitizedPath');
  }

  Future<http.Response> get(String path) async {
    return await _client.get(
      Uri.parse('$baseUrl$path'),
      headers: {
        'Content-Type': 'application/json',
        'User-Agent': 'FlutterApp/1.0 (Dart)',
      },
    );
  }
  Future<http.Response> post(String path, Map<String, dynamic> body) async {
    final uri = _buildUri(path);
    return await _client.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
  }
}