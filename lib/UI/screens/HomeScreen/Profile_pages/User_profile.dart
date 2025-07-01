import 'package:expance_app/UI/CutomWidget/ExText.dart';
import 'package:expance_app/UI/screens/login/bloc/user_bloc.dart';
import 'package:expance_app/UI/screens/login/bloc/user_event.dart';
import 'package:expance_app/UI/screens/login/bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfile extends StatefulWidget{
  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final RegExp emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();

  TextEditingController mobNumController = TextEditingController();

  TextEditingController emailController = TextEditingController();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<UserBloc>().add(GetIntialUserData());
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Extext(data: "User Profile", size: 18, fwight: FontWeight.w600),
        centerTitle: true,
      ),
      body:BlocBuilder<UserBloc, UserState>(builder: (_,state){
        if(state is UserLoadingState){
          return Center(child: CircularProgressIndicator(color: Colors.pink,),);
        }
        if(state is UserLoadedState){
          var userData = state.userData;
          nameController.text = userData[0].user_name;
          mobNumController.text = userData[0].user_mobile;
          emailController.text = userData[0].user_email;
          return Column(
            children: [
              SizedBox(
                height: 20,
              ),
              CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage("https://cdn.pixabay.com/photo/2023/02/18/11/00/icon-7797704_640.png"),
              ),
              SizedBox(height: 20,),
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
                height: 20,
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
                height: 20,
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
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                    return;
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
                  child: Extext(
                    data: "SAVE",
                    size: 20,
                    fwight: FontWeight.w600,
                    textColor: Colors.white,
                  )),
            ],
          );
        }
        return Container();
      })
    );
  }
}