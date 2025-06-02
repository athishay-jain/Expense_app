import 'package:expance_app/UI/CutomWidget/ExText.dart';
import 'package:expance_app/UI/screens/HomeScreen/HomePage.dart';
import 'package:expance_app/UI/screens/login/bloc/user_bloc.dart';
import 'package:expance_app/UI/screens/login/bloc/user_event.dart';
import 'package:expance_app/UI/screens/login/bloc/user_state.dart';
import 'package:expance_app/UI/screens/login/singUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool ObscureText = true;
  bool isloading = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "Assets/Images/logo_horizontal.png",
          scale: 7,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Image.asset(
              "Assets/Images/Ic_login.png",
              scale: 5,
            ),
          ),
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [Color(0xffb646b5), Color(0xfffb56a2)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
            child: Extext(
              data: "Welcome Back",
              size: 45,
              fwight: FontWeight.bold,
              textColor: Colors.white,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // Extext(data: "Login", size: 25, fwight: FontWeight.w600,align: TextAlign.start,textColor: Color(0xfffb56a2),),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 8),
            child: TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Enter Your Email ",
                label: Text(
                  "Email",
                  style: TextStyle(
                      fontFamily: "poppies", fontWeight: FontWeight.bold),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide(color: Color(0xfffd559e), width: 2)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 8),
            child: TextField(
              controller: passwordController,
              keyboardType: TextInputType.emailAddress,
              obscureText: ObscureText,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      ObscureText = !ObscureText;
                      setState(() {});
                    },
                    icon: ObscureText
                        ? Icon(
                            Icons.visibility,
                            color: Color(0xfffb56a2),
                          )
                        : Icon(
                            Icons.visibility_off_rounded,
                            color: Color(0xfffb56a2),
                          )),
                label: Text(
                  "Password",
                  style: TextStyle(
                      fontFamily: "poppies", fontWeight: FontWeight.bold),
                ),
                hintText: "Enter the password",
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide(color: Color(0xfffd559e), width: 2)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          BlocListener<UserBloc, UserState>(
            listener: (context, state) {
         /*     if (state is UserLoadingState) {
                isloading = true;
                setState(() {

                });
              }*/
              if (state is UserSuccessState) {
                isloading = false;
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text("User Login Successful !!")));
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ));
              }
              if (state is UserFailureState) {
                isloading = false;
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.errorMesg)));
                setState(() {

                });
              }

            },
            child:isloading ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: Color(0xfffb56a2),),
                SizedBox(width: 15,),
                Text("Loading",style: TextStyle(fontSize:18,color: Colors.black,fontFamily: "Poppins",fontWeight: FontWeight.w500),),
              ],
            ): ElevatedButton(
                onPressed: () {
                  context.read<UserBloc>().add(AuthenticateUserEvent(
                      email: emailController.text,
                      password: passwordController.text));
                },
                style: ElevatedButton.styleFrom(
                  maximumSize: Size(355, 60),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                  padding: EdgeInsets.symmetric(horizontal: 140, vertical: 12),
                  backgroundColor: Color(0xfffb56a2),
                ),
                child: Extext(
                  data: "LOGIN",
                  size: 20,
                  fwight: FontWeight.w600,
                  textColor: Colors.white,
                )),
          ),

          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Extext(data: "New to Expo?", size: 15, fwight: FontWeight.normal),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignupPage(),
                        ));
                  },
                  child: Extext(
                    data: "SignUp",
                    size: 15,
                    fwight: FontWeight.w600,
                    textColor: Color(0xfffb56a2),
                    underline: TextDecoration.underline,
                  ))
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left: 50, right: 5),
                width: 140,
                height: 2,
                color: Colors.grey,
              ),
              Extext(
                data: "OR",
                size: 14,
                fwight: FontWeight.w500,
                textColor: Color(0xfffb56a2),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 5,
                ),
                width: 140,
                height: 2,
                color: Colors.grey,
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                "Assets/Images/google-color-icon.png",
                scale: 12,
              ),
              Image.asset(
                "Assets/Images/facebook-round-color-icon.png",
                scale: 12,
              ),
              Image.asset(
                "Assets/Images/apple-icon.png",
                scale: 11,
              ),
            ],
          )
        ],
      ),
    );
  }
}
