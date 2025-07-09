import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expance_app/Online/Models/expense_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {


  CollectionReference collection = FirebaseFirestore.instance
      .collection("Users")
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection("transaction");

  Stream<List<ExpenseModel>> queryExpense() {
    print("the auth id is :${FirebaseAuth.instance.currentUser?.uid}");
    return collection.orderBy("date",descending: true).snapshots().map((snap) {
      return snap.docs.map((docs) {
        return ExpenseModel.fromMap(docs);
      }).toList();
    });
  }

Future<DocumentReference>addData({required ExpenseModel newExpense}){
    return collection.add(newExpense.toMap());
}
Future<void>updateData({required ExpenseModel updateExpense,required String uid}){
    return collection.doc(uid).update(updateExpense.toMap());
}
Future<void>deleteData({required String uid}){
    return collection.doc(uid).delete();
}
}
