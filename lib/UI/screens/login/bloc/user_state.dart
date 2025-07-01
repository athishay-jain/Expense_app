import 'package:expance_app/Local/Models/user_model.dart';

abstract class UserState{}
class  UserIntialState extends UserState{}
class  UserLoadingState extends UserState{}
class  UserSuccessState extends UserState{

}
class UserLoadedState extends UserState{
  List<UserModel>userData;
  UserLoadedState({required this.userData});
}
class  UserFailureState extends UserState{
  String errorMesg;
  UserFailureState({required this.errorMesg});
}


