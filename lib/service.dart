import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseMethos{
  Future addStudents(Map<String, dynamic> studentInfoMap, String id) async{
    return await FirebaseFirestore.instance
        .collection("students")
        .doc(id)
        .set(studentInfoMap);
  }

  Stream<QuerySnapshot> getStudentsDtails() {
    return  FirebaseFirestore
        .instance
        .collection("students")
        .snapshots();

  }
  
  updateAttendance(String attendanceCase, String id) async{
    return await FirebaseFirestore
        .instance
        .collection("students")
        .doc(id)
        .update({attendanceCase : true});
  }

  deleteStudent(String id) async{
    return await FirebaseFirestore
        .instance
        .collection("students")
        .doc(id)
        .delete();
  }
}