import 'package:expance_app/Local/Database/Dbhelper.dart';

class UserModel {
  String? user_id;
  String user_name;
  String user_email;
  String user_password;
  String user_mobile;

  UserModel(
      { this.user_id,
      required this.user_name,
      required this.user_email,
      required this.user_password,
      required this.user_mobile});

  factory UserModel.frommap(Map<String, dynamic> map) => UserModel(
        user_id: map[Dbhelper.user_id],
        user_name: map[Dbhelper.user_name],
        user_email: map[Dbhelper.user_email],
        user_password: map[Dbhelper.user_password],
        user_mobile: map[Dbhelper.user_mobile],
      );

  Map<String, dynamic> tomap() => {
        Dbhelper.user_name: user_name,
        Dbhelper.user_email: user_email,
        Dbhelper.user_mobile: user_mobile,
        Dbhelper.user_password: user_password,
  };
}
