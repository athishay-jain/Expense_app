import 'package:expance_app/Local/Models/user_model.dart';

abstract class UserEvent{}
class RegisterUserEvent extends UserEvent{
  UserModel newUser;
  RegisterUserEvent({required this.newUser});
}