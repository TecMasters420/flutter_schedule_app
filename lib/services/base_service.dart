export 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseService {
  Future<void> create(Map<String, dynamic> data);
  Future<void> update(Map<String, dynamic> data);
  Future<void> delete(Map<String, dynamic> data);
  Future<void> getData();
}
