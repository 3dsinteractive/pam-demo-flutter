import 'package:http/http.dart' as http;

class Requester {
  static Map<String, String> _getRequesterHeader() {
    return {
      "x-timestamp": "2021-03-10 12:22:12",
    };
  }

  static Future<http.Response> get(
      String url, Map<String, dynamic> params) async {
    return await http.get(Uri.parse(url).replace(queryParameters: params),
        headers: _getRequesterHeader());
  }

  static Future<http.Response> post(
      String url, Map<String, dynamic> payload) async {
    return await http.post(Uri.parse(url),
        body: payload, headers: _getRequesterHeader());
  }

  static Future<http.Response> put(
      String url, Map<String, dynamic> payload) async {
    return await http.put(Uri.parse(url),
        body: payload, headers: _getRequesterHeader());
  }

  static Future<http.Response> delete(
      String url, Map<String, dynamic> payload) async {
    return await http.delete(Uri.parse(url),
        body: payload, headers: _getRequesterHeader());
  }
}
