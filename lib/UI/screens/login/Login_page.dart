import 'package:expance_app/UI/CutomWidget/ExText.dart';
import 'package:expance_app/UI/screens/HomeScreen/HomePage.dart';
import 'package:expance_app/UI/screens/HomeScreen/statisticPage.dart';
import 'package:expance_app/UI/screens/login/singUp.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool ObscureText = true;

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
                  "password",
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
          ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
              },
              style: ElevatedButton.styleFrom(
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
          SizedBox(
            height: 30,
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
          )
        ],
      ),
    );
  }
}
