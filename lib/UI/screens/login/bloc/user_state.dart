abstract class UserState{}
class  UserIntialState extends UserState{}
class  UserLoadingState extends UserState{}
class  UserSuccessState extends UserState{}
class  UserFailureState extends UserState{
  String errorMesg;
  UserFailureState({required this.errorMesg});
}


