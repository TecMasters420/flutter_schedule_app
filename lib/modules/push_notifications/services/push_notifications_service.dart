import 'package:flutter/cupertino.dart';
import 'package:schedulemanager/app/services/base_repository.dart';

class PushNotificationsService {
  static const _collection = 'users';
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveToken(String fmcToken, String userUuid) async {
    debugPrint('Saving $fmcToken TOKEN of $userUuid');
    final collection = _db.collection(_collection);
    final Map<String, List<Map<String, dynamic>>> fmcTokens = {
      'tokens': [
        {
          'token': fmcToken,
          'lastUpdate': DateTime.now(),
        }
      ]
    };
    final res = await collection.doc(userUuid).get();
    final data = res.data();
    if (data != null || (data != null && data.isEmpty)) {
      final finalList =
          fmcTokens['tokens']!.where((e) => e['token'] != fmcToken);
      fmcTokens['tokens'] = [...fmcTokens['tokens']!, ...finalList];
      debugPrint('Tokens: $fmcTokens');
      await collection.doc(userUuid).set(fmcTokens, SetOptions(merge: true));
      return;
    }

    await collection.doc(userUuid).set(fmcTokens, SetOptions(merge: true));
  }

  Future<void> removeToken(String fmcToken, String userUuid) async {
    final collection = _db.collection(_collection);
    final res = await collection.doc(userUuid).get();
    final data = res.data();
    if (data == null) return;
    final List<Map<String, dynamic>> tempData = List.from(data['tokens']);
    final newData = tempData.where((e) => e['token'] != fmcToken).toList();
    await collection.doc(userUuid).set({'tokens': newData});
  }
}
