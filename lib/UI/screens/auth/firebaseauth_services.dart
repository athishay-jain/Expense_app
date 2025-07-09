import 'package:expance_app/Online/Models/expense_model.dart';
import 'package:expance_app/Online/Models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  FirebaseAuth firebase = FirebaseAuth.instance;
  String docId = "";

  Future<UserCredential> fireSignUp(
      {required String email,
      required String password,
      required String phone,
      required String name}) async {
    UserCredential UserCred = await firebase.createUserWithEmailAndPassword(
        email: email, password: password);
    print("the user id is ${UserCred.user!.uid}");
    FirebaseFirestore.instance.collection("Users").doc(UserCred.user!.uid).set(
        UserModel(
                user_name: name,
                user_email: email,
                user_password: password,
                user_mobile: phone)
            .toMap());
    return UserCred;
  }

  Future<UserCredential> fireLogin(
      {required String email, required String password}) async {
    UserCredential userCreds = await firebase.signInWithEmailAndPassword(
        email: email, password: password);
    return userCreds;
  }

  Future<UserCredential> googleLogin() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser!.authentication;
    var cred = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    UserCredential credential = await firebase.signInWithCredential(cred);
    FirebaseFirestore.instance
        .collection("Users")
        .doc(credential.user!.uid)
        .set(UserModel(
                user_name: googleUser.displayName ?? "",
                user_email: googleUser.email,
                user_password: "null",
                user_mobile: credential.user?.phoneNumber ?? "")
            .toMap());
    return credential;
  }

  Stream<UserModel> loadData() {
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .snapshots()
        .map((snap) {
      final data = snap.data();
      if (data != null) {
        return UserModel.fromMap(data);
      } else {
        throw Exception("User data not found!");
      }
    });
  }
}
