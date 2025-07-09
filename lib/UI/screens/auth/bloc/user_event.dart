
import '../../../../Online/Models/user_model.dart';

abstract class UserEvent{}
class RegisterUserEvent extends UserEvent{
  UserModel newUser;
  RegisterUserEvent({required this.newUser});
}
class AuthenticateUserEvent extends UserEvent{
  String email;
  String password;
  AuthenticateUserEvent({required this.email, required this.password});
}
class GoogleAuthenticateUser extends UserEvent{

}
class GetInitialUserData extends UserEvent{

}