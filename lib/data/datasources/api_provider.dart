import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_api/core/constants/url_manager.dart';
import 'package:ecommerce_api/core/errors/app_exceptions.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  static final ApiProvider _apiProvider = ApiProvider._internal();
  ApiProvider._internal();
  static ApiProvider get instance => _apiProvider;

  static const Duration _timeout = Duration(seconds: 20);

  Map<String, String> _buildHeaders({bool authorized = false}) {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (authorized && UrlManager.instance.token.isNotEmpty)
        'Authorization': UrlManager.instance.token.startsWith('Bearer ')
            ? UrlManager.instance.token
            : 'Bearer ${UrlManager.instance.token}',
    };
  }

  String _formatUrl(String endPoint) {
    final baseUrl = UrlManager.instance.baseUrl;
    final normalizedBase = baseUrl.endsWith('/') ? baseUrl : '$baseUrl/';
    final normalizedEndpoint =
        endPoint.startsWith('/') ? endPoint.substring(1) : endPoint;
    return '$normalizedBase$normalizedEndpoint';
  }

  Future<dynamic> get({
    required String endPoint,
    bool authorized = false,
  }) async {
    final String url = _formatUrl(endPoint);
    try {
      final response = await http
          .get(
            Uri.parse(url),
            headers: _buildHeaders(authorized: authorized),
          )
          .timeout(_timeout);
      return _processResponse(response);
    } on SocketException {
      throw const NetworkException();
    } on TimeoutException {
      throw const NetworkException(
        'Connection timed out. Please check your internet connection.',
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<dynamic> post({
    required String endPoint,
    required Map<String, dynamic> params,
    bool authorized = false,
  }) async {
    final String url = _formatUrl(endPoint);
    try {
      final response = await http
          .post(
            Uri.parse(url),
            headers: _buildHeaders(authorized: authorized),
            body: jsonEncode(params),
          )
          .timeout(_timeout);
      return _processResponse(response);
    } on SocketException {
      throw const NetworkException();
    } on TimeoutException {
      throw const NetworkException(
        'Connection timed out. Please check your internet connection.',
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<dynamic> getRequest({required String endPoint}) =>
      get(endPoint: endPoint, authorized: true);

  Future<dynamic> postRequest({
    required String endPoint,
    required Map<String, dynamic> params,
  }) =>
      post(endPoint: endPoint, params: params, authorized: true);

  dynamic _processResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return null;
      return jsonDecode(response.body);
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      throw ServerException(
        message: 'Unauthorized access. Please login again.',
        statusCode: response.statusCode,
      );
    } else if (response.statusCode == 404) {
      throw ServerException(
        message: 'The requested resource was not found.',
        statusCode: response.statusCode,
      );
    } else {
      throw ServerException(
        message: 'Server error with status code ${response.statusCode}',
        statusCode: response.statusCode,
      );
    }
  }
}

