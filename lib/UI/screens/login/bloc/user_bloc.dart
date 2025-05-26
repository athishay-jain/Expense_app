import 'package:expance_app/Local/Database/Dbhelper.dart';
import 'package:expance_app/UI/screens/login/bloc/user_event.dart';
import 'package:expance_app/UI/screens/login/bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  Dbhelper dbhelper;

  UserBloc({required this.dbhelper}) : super(UserIntialState()) {
    on<RegisterUserEvent>((event, emit) async {
    //  emit(UserLoadingState());
      bool olduser =
          await dbhelper.checkIfUserExist(email: event.newUser.user_email);
      if (!olduser) {
        bool check = await dbhelper.createUser(user: event.newUser);
        if (check) {
          emit(UserSuccessState());
        } else {
          emit(UserFailureState(errorMesg: "Something went wrong"));
        }
      }
      else{
        emit(UserFailureState(errorMesg: "Email Already Exists !!"));
      }
    });
  }
}
