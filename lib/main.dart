
import 'package:expance_app/Online/Firebase/firebase_services.dart';
import 'package:expance_app/UI/screens/auth/firebaseauth_services.dart';
import 'package:expance_app/UI/screens/spalsh_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Online/Bloc/expense_bloc.dart';
import 'UI/screens/auth/bloc/user_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiBlocProvider(providers: [
    BlocProvider<UserBloc>(
      create: (context) => UserBloc(
        authService: FirebaseAuthService()
      ),
    ),
    BlocProvider<ExpenseBloc>(
      create: (context) => ExpenseBloc(
firebase: FirebaseServices(),
      ),
    )
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SpashScreen(),
    );
  }
}
