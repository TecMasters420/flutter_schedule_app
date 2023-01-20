import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:schedulemanager/modules/auth/models/api_response_model.dart';

const String _base = 'https://scheduleappback-374905.wl.r.appspot.com/api/v1';

class RequestBase {
  Future<ApiResponseModel?> call(final String extraEndpoint,
      {String? token, Map<String, dynamic>? body}) async {
    const Map<String, String> headers = {
      "Content-Type": "application/json; charset=utf-8",
    };
    if (body != null) debugPrint(body.toString());
    try {
      final url = Uri.parse('$_base/$extraEndpoint');
      debugPrint('\nURL: $url');
      final http.Response res = body == null
          ? await http.get(url,
              headers:
                  token != null ? {'Authorization': 'Bearer $token'} : null)
          : await http.post(url, body: jsonEncode(body), headers: headers);
      debugPrint(res.body.toString());
      return ApiResponseModel(code: res.statusCode, body: res.body);
    } catch (e) {
      debugPrint('Error $e');
      return null;
    }
  }
}
