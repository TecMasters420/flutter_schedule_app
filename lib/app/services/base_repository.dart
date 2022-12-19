import '../../common/request_base.dart';

export 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseRepository {
  final RequestBase base = RequestBase();
}
