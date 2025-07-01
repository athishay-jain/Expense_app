import 'package:expance_app/UI/CutomWidget/ExText.dart';
import 'package:expance_app/UI/screens/HomeScreen/Profile_pages/User_profile.dart';
import 'package:expance_app/UI/screens/login/bloc/user_bloc.dart';
import 'package:expance_app/UI/screens/login/bloc/user_event.dart';
import 'package:expance_app/UI/screens/login/bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login/Login_page.dart';

class Profilepage extends StatefulWidget {
  @override
  State<Profilepage> createState() => _ProfilepageState();
}
class _ProfilepageState extends State<Profilepage> {
  List<Map<String, dynamic>> mData = [
    {
      "icon": Icons.account_circle_outlined,
      "title": " User Profile",
      "trailing": Icons.arrow_forward_ios_rounded,
    },
    {
      "icon": Icons.lock_outline_rounded,
      "title": "Change Password",
      "trailing": Icons.arrow_forward_ios_rounded,
    },
    {
      "icon": Icons.question_mark,
      "title": "FAQs",
      "trailing": Icons.arrow_forward_ios_rounded,
    },
    {
      "icon": Icons.notifications_active_outlined,
      "title": "Push Notification",
      "trailing": Icons.arrow_forward_ios_rounded,
    },
  ];
@override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(GetIntialUserData());
  }
  bool value = true;
  bool ObscureText = true;

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Extext(data: "Profile", size: 25, fwight: FontWeight.bold),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            BlocBuilder<UserBloc,UserState>(builder: (_,state){
              if(state is UserLoadingState){
                return Center(child: CircularProgressIndicator(),);
              }
              if(state is UserLoadedState){
               var userData = state.userData;
               print("email is ${userData[0].user_email}");
               print("password is ${userData[0].user_password}");
               return ListTile(
                 leading: CircleAvatar(
                   backgroundImage: NetworkImage(
                       "https://cdn.pixabay.com/photo/2023/02/18/11/00/icon-7797704_640.png"),
                   radius: 25,
                 ),
                 title: Extext(
                   data: "Welcome",
                   size: 14,
                   fwight: FontWeight.w500,
                   textColor: Colors.grey,
                 ),
                 subtitle: Extext(
                     data: userData[0].user_name, size: 18, fwight: FontWeight.w600),
                 trailing: IconButton(
                   onPressed: () async {
                     SharedPreferences Prefs =
                     await SharedPreferences.getInstance();
                     Prefs.remove("user");
                     Navigator.pushReplacement(
                         context,
                         MaterialPageRoute(
                           builder: (context) => LoginPage(),
                         ));
                   },
                   icon: Icon(
                     Icons.logout,
                     color: Color(0xfffb56a2),
                   ),
                 ),
               );
              }
              return Text("");
            }),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: mData.length,
                itemBuilder: (_, index) {
                  return InkWell(
                    onTap: ()async{
                      if(index==0){
                        await Future.delayed(Duration(milliseconds: 280));
                        Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfile(),));
                      }
                      if(index==1){
                        showModalBottomSheet(context: context, builder: ( BuildContext context){
                          return Container(
                            height: 500,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 20,),
                              Extext(data: "Change Password", size: 18, fwight: FontWeight.w600),
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
                                      "Old Password",
                                      style: TextStyle(
                                          fontFamily: "poppies", fontWeight: FontWeight.bold),
                                    ),
                                    hintText: "Enter the Old password",
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
                                      "New Password",
                                      style: TextStyle(
                                          fontFamily: "poppies", fontWeight: FontWeight.bold),
                                    ),
                                    hintText: "Enter the New password",
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(18),
                                        borderSide: BorderSide(color: Color(0xfffd559e), width: 2)),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20,),
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
                              SizedBox(height: 40,),
                            ],
                          ),
                          );
                        });
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 15, bottom: 15),
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 0.8,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(),

                        leading: Icon(
                          mData[index]["icon"],
                          color: Colors.grey,
                          size: 28,
                        ),
                        title: Extext(
                            data: mData[index]["title"],
                            size: 18,
                            fwight: FontWeight.w500),
                        trailing: index == 3
                            ? Switch(
                          inactiveThumbColor:Color(0xfffb56a2),
                                inactiveTrackColor: Colors.white,
                                value: value,
                                activeTrackColor: Color(0xfffb56a2),
                                onChanged: (bool light) {
                                  value = light;
                                  setState(() {});
                                })
                            : Icon(mData[index]["trailing"],
                                size: 18, color: Color(0xfffb56a2)),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ));
  }
}
/*
CircleAvatar(
backgroundColor: Color(0xfff5d7e5),
child: IconButton(onPressed: ()async{
SharedPreferences Prefs = await SharedPreferences.getInstance();
Prefs.remove("user");
Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
}, icon: Icon(Icons.logout,color: Color(0xfffb56a2),))),*/
