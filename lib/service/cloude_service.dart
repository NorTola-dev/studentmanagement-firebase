import 'package:cloud_firestore/cloud_firestore.dart';

class CloudeService {
  final service = FirebaseFirestore.instance.collection('students');

  Future<void> addStudent(
    String name,
    String gender,
    String phone,
    double gpa,
    int age,
  ) async {
    await service.add({
      "name": name,
      "gender": gender,
      "phone": phone,
      "gpa": gpa,
      "age": age,
    });
  }

  Stream<QuerySnapshot> getStudent() {
    return service.snapshots();
  }

  Future<void> updateStudent(
    String id,
    String name,
    String gender,
    String phone,
    double gpa,
    int age,
  ) async {
    await service.doc(id).update({
      "name": name,
      "gender": gender,
      "phone": phone,
      "gpa": gpa,
      "age": age,
    });
  }

  Future<void> deleteStudent(String id) async {
    await service.doc(id).delete();
  }
}
