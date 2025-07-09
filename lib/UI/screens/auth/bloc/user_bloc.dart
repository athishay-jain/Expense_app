import 'package:expance_app/UI/screens/auth/bloc/user_event.dart';
import 'package:expance_app/UI/screens/auth/bloc/user_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../firebaseauth_services.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  FirebaseAuthService authService;

  UserBloc({required this.authService}) : super(UserIntialState()) {
    on<RegisterUserEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        UserCredential userCred = await authService.fireSignUp(
            email: event.newUser.user_email,
            password: event.newUser.user_password,
            phone: event.newUser.user_mobile,
            name: event.newUser.user_name);
        if (userCred.user != null) {
          emit(UserSuccessState());
        }
      } on FirebaseAuthException catch (e) {
        emit(UserFailureState(errorMesg: e.message ?? ""));
      } catch (e) {
        emit(UserFailureState(errorMesg: e.toString()));
      }
    });
    on<AuthenticateUserEvent>((event, emit) async {
      emit(UserLoadingState());
      UserCredential userCred = await authService.fireLogin(
          email: event.email, password: event.password);
      if (userCred.user != null) {
        emit(UserSuccessState());
      }
      try {} on FirebaseAuthException catch (e) {
        emit(UserFailureState(errorMesg: e.message ?? ""));
      } catch (e) {
        emit(UserFailureState(errorMesg: e.toString()));
      }
    });
    on<GoogleAuthenticateUser>((event, emit) async {
      emit(UserLoadingState());
      try {
        UserCredential userCred = await authService.googleLogin();
        if (userCred.user != null) {
          emit(UserSuccessState());
        }
      } on FirebaseAuthException catch (e) {
        emit(UserFailureState(errorMesg: e.message ?? ""));
      } catch (e) {
        emit(UserFailureState(errorMesg: e.toString()));
      }
    });
    on<GetInitialUserData>((event, emit) async{
      print("getInitialUserDatacalled");
      emit(UserLoadingState());
     await emit.forEach(
        authService.loadData(),
        onData: (data) => UserLoadedState(userData: data),
        onError: (error, stackTrace) =>
            UserFailureState(errorMesg: error.toString()),
      );
    });
  }
}
