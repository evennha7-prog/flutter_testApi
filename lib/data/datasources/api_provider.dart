import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_api/core/constants/url_manager.dart';
import 'package:ecommerce_api/core/errors/app_exceptions.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  static final ApiProvider _apiProvider = ApiProvider._internal();
  ApiProvider._internal();
  static ApiProvider get instance => _apiProvider;

  Map<String, String> _buildHeaders({bool authorized = false}) {
    return {
      'Content-Type': 'application/json',
      if (authorized && UrlManager.instance.token.isNotEmpty)
        'authorization': UrlManager.instance.token,
    };
  }

  Future<dynamic> get({
    required String endPoint,
    bool authorized = false,
  }) async {
    final String url = "${UrlManager.instance.baseUrl}$endPoint";
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: _buildHeaders(authorized: authorized),
      );
      return _processResponse(response);
    } on SocketException {
      throw const NetworkException();
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
    final String url = "${UrlManager.instance.baseUrl}$endPoint";
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: _buildHeaders(authorized: authorized),
        body: jsonEncode(params),
      );
      return _processResponse(response);
    } on SocketException {
      throw const NetworkException();
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
      return jsonDecode(response.body);
    } else {
      throw ServerException(
        message: 'Request failed with status ${response.statusCode}',
        statusCode: response.statusCode,
      );
    }
  }
}
