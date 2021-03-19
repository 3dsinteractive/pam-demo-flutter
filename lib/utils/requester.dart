import 'dart:convert';
import 'package:http/http.dart' as http;

class Requester {
  static Map<String, String> _getRequesterHeader() {
    return {
      "x-timestamp": "2021-03-10 12:22:12",
    };
  }

  static Future<http.Response> get(
      String url, Map<String, dynamic> params) async {
    try {
      http.Response response = await http.get(
          Uri.parse(url).replace(queryParameters: params),
          headers: _getRequesterHeader());
      if (response.statusCode >= 400 && response.statusCode <= 599) {
        throw (json.decode(response.body));
      }
      return response;
    } catch (e) {
      throw (e);
    }
  }

  static Future<http.Response> post(
      String url, Map<String, dynamic> payload) async {
    try {
      http.Response response = await http.post(Uri.parse(url),
          body: payload, headers: _getRequesterHeader());
      if (response.statusCode > 400 && response.statusCode < 599) {
        throw (json.decode(response.body));
      }
      return response;
    } catch (e) {
      throw (e);
    }
  }

  static Future<http.Response> put(
      String url, Map<String, dynamic> payload) async {
    try {
      http.Response response = await http.put(Uri.parse(url),
          body: payload, headers: _getRequesterHeader());
      if (response.statusCode > 400 && response.statusCode < 599) {
        throw (json.decode(response.body));
      }
      return response;
    } catch (e) {
      throw (e);
    }
  }

  static Future<http.Response> delete(
      String url, Map<String, dynamic> payload) async {
    try {
      http.Response response = await http.delete(Uri.parse(url),
          body: payload, headers: _getRequesterHeader());
      if (response.statusCode > 400 && response.statusCode < 599) {
        throw (json.decode(response.body));
      }
      return response;
    } catch (e) {
      throw (e);
    }
  }
}
