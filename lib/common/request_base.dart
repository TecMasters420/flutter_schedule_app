import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

const String _base = 'https://scheduleappback-374905.wl.r.appspot.com/api/v1';

class RequestBase {
  Future<String?> call(final String extraEndpoint,
      {String? token, Map<String, String>? body}) async {
    try {
      final url = Uri.parse('$_base/$extraEndpoint');
      debugPrint('\nURL: $url');
      final http.Response res = body == null
          ? await http.get(url,
              headers:
                  token != null ? {'Authorization': 'Bearer $token'} : null)
          : await http.post(url, body: body);
      debugPrint(res.body.toString());
      if (res.statusCode >= 400 && res.statusCode <= 500) return null;
      return res.body;
    } catch (e) {
      debugPrint('Error $e');
      return null;
    }
  }
}
