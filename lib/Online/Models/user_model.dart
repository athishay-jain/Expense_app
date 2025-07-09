import 'package:cloud_firestore/cloud_firestore.dart';

import '../../app_constants.dart';

class UserModel {

  String user_name;
  String user_email;
  String user_password;
  String user_mobile;

  UserModel(
      {
      required this.user_name,
      required this.user_email,
      required this.user_password,
      required this.user_mobile});

  factory UserModel.fromMap(Map<String,dynamic> map) => UserModel(
        user_name: map[AppConstansts.user_name],
        user_email: map[AppConstansts.user_email],
        user_password: map[AppConstansts.user_password],
        user_mobile: map[AppConstansts.user_mobile],
      );

  Map<String, dynamic> toMap() => {
        AppConstansts.user_name: user_name,
        AppConstansts.user_email: user_email,
        AppConstansts.user_mobile: user_mobile,
        AppConstansts.user_password: user_password,
      };
}
