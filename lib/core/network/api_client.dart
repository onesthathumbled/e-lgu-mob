import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../constants/app_constants.dart';
import '../errors/exceptions.dart';

/// HTTP client for API communication
class ApiClient {
  const ApiClient(this._client);
  
  final http.Client _client;
  
  /// Base headers for all requests
  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  
  /// Headers with authentication token
  Map<String, String> _headersWithAuth(String token) => {
    ..._headers,
    'Authorization': 'Bearer $token',
  };
  
  /// GET request
  Future<Map<String, dynamic>> get(
    String endpoint, {
    String? token,
    Map<String, String>? queryParams,
  }) async {
    try {
      final uri = _buildUri(endpoint, queryParams);
      final response = await _client
          .get(
            uri,
            headers: token != null ? _headersWithAuth(token) : _headers,
          )
          .timeout(AppConstants.apiTimeout);
      
      return _handleResponse(response);
    } on SocketException {
      throw const NetworkException('No internet connection');
    } on HttpException {
      throw const NetworkException('HTTP error occurred');
    } catch (e) {
      throw NetworkException('Network error: $e');
    }
  }
  
  /// POST request
  Future<Map<String, dynamic>> post(
    String endpoint, {
    String? token,
    Map<String, dynamic>? body,
  }) async {
    try {
      final uri = _buildUri(endpoint);
      final response = await _client
          .post(
            uri,
            headers: token != null ? _headersWithAuth(token) : _headers,
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(AppConstants.apiTimeout);
      
      return _handleResponse(response);
    } on SocketException {
      throw const NetworkException('No internet connection');
    } on HttpException {
      throw const NetworkException('HTTP error occurred');
    } catch (e) {
      throw NetworkException('Network error: $e');
    }
  }
  
  /// PUT request
  Future<Map<String, dynamic>> put(
    String endpoint, {
    String? token,
    Map<String, dynamic>? body,
  }) async {
    try {
      final uri = _buildUri(endpoint);
      final response = await _client
          .put(
            uri,
            headers: token != null ? _headersWithAuth(token) : _headers,
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(AppConstants.apiTimeout);
      
      return _handleResponse(response);
    } on SocketException {
      throw const NetworkException('No internet connection');
    } on HttpException {
      throw const NetworkException('HTTP error occurred');
    } catch (e) {
      throw NetworkException('Network error: $e');
    }
  }
  
  /// DELETE request
  Future<Map<String, dynamic>> delete(
    String endpoint, {
    String? token,
  }) async {
    try {
      final uri = _buildUri(endpoint);
      final response = await _client
          .delete(
            uri,
            headers: token != null ? _headersWithAuth(token) : _headers,
          )
          .timeout(AppConstants.apiTimeout);
      
      return _handleResponse(response);
    } on SocketException {
      throw const NetworkException('No internet connection');
    } on HttpException {
      throw const NetworkException('HTTP error occurred');
    } catch (e) {
      throw NetworkException('Network error: $e');
    }
  }
  
  /// Build URI with base URL and query parameters
  Uri _buildUri(String endpoint, [Map<String, String>? queryParams]) {
    final uri = Uri.parse('${AppConstants.baseUrl}$endpoint');
    if (queryParams != null && queryParams.isNotEmpty) {
      return uri.replace(queryParameters: queryParams);
    }
    return uri;
  }
  
  /// Handle HTTP response
  Map<String, dynamic> _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return jsonDecode(response.body) as Map<String, dynamic>;
      case 400:
        throw const ValidationException('Bad request');
      case 401:
        throw const AuthException('Unauthorized');
      case 403:
        throw const AuthException('Forbidden');
      case 404:
        throw const ServerException('Not found');
      case 422:
        throw const ValidationException('Validation error');
      case 500:
        throw const ServerException('Internal server error');
      default:
        throw ServerException('Server error: ${response.statusCode}');
    }
  }
}
