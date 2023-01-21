import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:schedulemanager/app/utils/alert_dialogs_util.dart';
import 'package:schedulemanager/modules/auth/models/api_response_model.dart';

const String _base = 'https://scheduleappback-374905.wl.r.appspot.com/api/v1';
// const String _base = 'http://192.168.1.29:8080/api/v1';

class RequestBase {
  Future<ApiResponseModel?> call(final String extraEndpoint,
      {String? token, Map<String, dynamic>? body}) async {
    const Map<String, String> headers = {
      "Content-Type": "application/json; charset=utf-8",
    };
    if (body != null) debugPrint(body.toString());
    if (token != null) debugPrint(token);
    try {
      final url = Uri.parse('$_base/$extraEndpoint');
      debugPrint('\nURL: $url');
      final http.Response res = body == null
          ? await http.get(url,
              headers:
                  token != null ? {'Authorization': 'Bearer $token'} : null)
          : await http.post(url, body: jsonEncode(body), headers: headers);
      debugPrint(res.body.toString());
      if (res.statusCode < 300 && res.statusCode >= 200) {
        return ApiResponseModel(code: res.statusCode, body: res.body);
      }
      final Map<String, dynamic> map = jsonDecode(res.body);
      final response = ApiResponseModel(
        code: res.statusCode,
        body: res.body,
        messages: map['messages'] == null
            ? map['message'] == null
                ? null
                : List.from(map['message']).map((e) => e.toString()).toList()
            : List.from(map['messages']).map((e) => e.toString()).toList(),
        status: map['status'],
        type: map['type'],
      );
      if (Get.isOverlaysOpen) {
        Get.back();
      }
      if (extraEndpoint != 'users/me') {
        AlertDialogsUtil.error(
          customBodyMessage: response.messages,
        );
      }
      return response;
    } catch (e) {
      debugPrint('Error $e');
      return null;
    }
  }
}
