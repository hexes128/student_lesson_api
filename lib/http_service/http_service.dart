import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpService {
  static String scheme = "http";
  static String host = "testHost.com";
  static String basicPath = "backend_api/";
  static String accessToken = "myAccessToken";
  static int port = 666;

  static Future<T> get<T>({required Map<String, dynamic> query, required String path, T Function(Map<String, dynamic>)? fromJson}) async {
    try {
      final response = await http.get(
        Uri(scheme: scheme, host: host, port: port, path: '$basicPath$path', queryParameters: query),
        headers: {"accessToken": accessToken},
      );
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (result["success"] == true) {
          if (fromJson != null) {
            return fromJson(result);
          } else {
            return result;
          }
        } else {
          throw (result["msg"]);
        }
      } else {
        throw (response.statusCode.toString());
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<T> post<T>({required Map<String, dynamic> body, required String path, T Function(Map<String, dynamic>)? fromJson}) async {
    try {
      var response = await http.post(Uri(scheme: scheme, host: host, port: port, path: "$basicPath$path"),
          headers: {"Content-Type": "application/json; charset=UTF-8", "accessToken": accessToken}, body: jsonEncode(body));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['success'] == true) {
          if (fromJson != null) {
            return fromJson(result);
          } else {
            return result;
          }
        } else {
          throw (result["msg"]);
        }
      } else {
        throw (response.statusCode.toString());
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> delete({required Map<String, dynamic> body, required String path}) async {
    var response = await http.delete(Uri(scheme: scheme, host: host, port: port, path: "$basicPath$path"),
        headers: {"Content-Type": "application/json; charset=UTF-8", "accessToken": accessToken}, body: json.encode(body));

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      if (result['success']) {
        return result;
      } else {
        throw (result['msg']);
      }
    } else {
      throw (response.statusCode.toString());
    }
  }
}
