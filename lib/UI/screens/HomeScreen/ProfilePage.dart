import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login/Login_page.dart';

class Profilepage extends StatelessWidget {
  const Profilepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
                backgroundColor: Color(0xfff5d7e5),
                child: IconButton(onPressed: ()async{
              SharedPreferences Prefs = await SharedPreferences.getInstance();
              Prefs.remove("user");
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
            }, icon: Icon(Icons.logout,color: Color(0xfffb56a2),))),
            SizedBox(width: 10,),
            Text("Logout",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
          ],
        ),
      ),
      body: Center(child: Text("Profile",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)),
    );
  }
}
