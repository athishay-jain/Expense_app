import 'package:expance_app/Local/Models/user_model.dart';
import 'package:expance_app/UI/CutomWidget/ExText.dart';
import 'package:expance_app/UI/screens/login/bloc/user_bloc.dart';
import 'package:expance_app/UI/screens/login/bloc/user_event.dart';
import 'package:expance_app/UI/screens/login/bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool ObscureText = true;
  bool isLoading = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController mobNumController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final RegExp emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "Assets/Images/logo_horizontal.png",
          scale: 7,
        ),
      ),
      body: Form(
        key: formkey,
        child: Column(
          children: [
            Image.asset(
              "Assets/Images/Ic_signup.png",
              scale: 8,
            ),
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [Color(0xffb646b5), Color(0xfffb56a2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
              child: Extext(
                data: "Get Started",
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
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Name is Required";
                  } else {
                    return null;
                  }
                },
                controller: nameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: "Enter Your Name ",
                  label: Text(
                    "Name",
                    style: TextStyle(
                        fontFamily: "poppies", fontWeight: FontWeight.bold),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide(color: Colors.red.shade700),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide(color: Color(0xfffd559e), width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide:
                          BorderSide(color: Color(0xfffd559e), width: 2)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 8),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Mobile No is Required";
                  } else if (value.length != 10) {
                    return " Please enter the valid mobile number";
                  } else {
                    return null;
                  }
                },
                controller: mobNumController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter Your Mobile Number ",
                  label: Text(
                    "Mobile Number",
                    style: TextStyle(
                        fontFamily: "poppies", fontWeight: FontWeight.bold),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide(color: Colors.red.shade700),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide(
                      color: Color(0xfffd559e),
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide:
                          BorderSide(color: Color(0xfffd559e), width: 2)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 8),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email is Required";
                  } else if (!emailRegex.hasMatch(value)) {
                    return " Please enter the valid email";
                  } else {
                    return null;
                  }
                },
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Enter Your Email ",
                  label: Text(
                    "Email",
                    style: TextStyle(
                        fontFamily: "poppies", fontWeight: FontWeight.bold),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide(color: Colors.red.shade700),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide(
                      color: Color(0xfffd559e),
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide:
                          BorderSide(color: Color(0xfffd559e), width: 2)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 8),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password is Required";
                  } else if (value.length <= 6) {
                    return " Password must be greater then six characters";
                  } else {
                    return null;
                  }
                },
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
                    "password",
                    style: TextStyle(
                        fontFamily: "poppies", fontWeight: FontWeight.bold),
                  ),
                  hintText: "Enter the password",
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide(
                      color: Colors.red.shade700,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide(
                      color: Color(0xfffd559e),
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide:
                          BorderSide(color: Color(0xfffd559e), width: 2)),
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
                if (state is UserLoadingState) {
                  isLoading = true;
                  setState(() {});
                }
                if (state is UserSuccessState) {
                  isLoading = false;
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                    "User registered successfully !!",
                    style: TextStyle(fontFamily: "poppies"),
                  )));
                  Navigator.pop(context);
                }
                if (state is UserFailureState) {
                  isLoading = false;
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                    state.errorMesg,
                    style: TextStyle(fontFamily: "poppies"),
                  )));
                  setState(() {});
                }
              },
              child: ElevatedButton(
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      context.read<UserBloc>().add(RegisterUserEvent(
                          newUser: UserModel(
                              user_name: nameController.text,
                              user_email: emailController.text,
                              user_password: passwordController.text,
                              user_mobile: mobNumController.text)));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    maximumSize: Size(355, 60),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    padding:
                        EdgeInsets.symmetric(horizontal: 135, vertical: 12),
                    backgroundColor: Color(0xfffb56a2),
                  ),
                  child: isLoading
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: 15,
                                width: 15,
                                child: CircularProgressIndicator(color: Colors.white,)),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Loading",style: TextStyle(color: Colors.white),),
                          ],
                        )
                      : Extext(
                          data: "SIGN UP",
                          size: 20,
                          fwight: FontWeight.w600,
                          textColor: Colors.white,
                        )),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Extext(
                    data: "Already have an account?",
                    size: 15,
                    fwight: FontWeight.normal),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Extext(
                      data: "Login",
                      size: 16,
                      fwight: FontWeight.w600,
                      textColor: Color(0xfffb56a2),
                      underline: TextDecoration.underline,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
