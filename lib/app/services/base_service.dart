export 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseService {
  Future<void> createData(Map<String, dynamic> data);
  Future<void> updateData(Map<String, dynamic> data);
  Future<void> deleteData(Map<String, dynamic> data);
  Future<void> getData();
}
