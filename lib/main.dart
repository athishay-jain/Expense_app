import 'package:expance_app/Local/Database/Dbhelper.dart';
import 'package:expance_app/UI/screens/login/bloc/user_bloc.dart';
import 'package:expance_app/UI/screens/spalsh_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(BlocProvider(create: (context) => UserBloc(dbhelper: Dbhelper.GetIntances(),),child: MyApp(),));
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
