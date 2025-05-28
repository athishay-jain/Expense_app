import 'package:expance_app/UI/CutomWidget/ExText.dart';
import 'package:expance_app/UI/screens/HomeScreen/AddExpensePage.dart';
import 'package:expance_app/UI/screens/HomeScreen/ProfilePage.dart';
import 'package:expance_app/UI/screens/HomeScreen/entrypage.dart';
import 'package:expance_app/UI/screens/HomeScreen/statisticPage.dart';
import 'package:expance_app/UI/screens/login/Login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectednavigation = 0;
List<Widget>navigate =[
  EntryPage(),
  StatisticPage(),
  Center(
    child: Text("Notification",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
  ),
  Profilepage(),
];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigate[selectednavigation],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddExpense(),
              ));
        },
        elevation: 4,
        backgroundColor: Color(0xfffb56a2),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            activeIcon: Icon(Icons.analytics),
            label: "Analytics",
          ),
          BottomNavigationBarItem(
            icon: SizedBox(width: 48), // Space for FAB
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notification_add_outlined),
            activeIcon: Icon(Icons.notification_add),
            label: "Notification",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_identity_rounded),
            activeIcon: Icon(Icons.person),
            label: "profile",
          ),
        ],
        currentIndex: selectednavigation < 2
            ? selectednavigation
            : selectednavigation + 1,
        onTap: (index) {
          if (index < 2) {
            selectednavigation = index;
            setState(() {});
          } else {
            selectednavigation = index - 1;
            setState(() {});
          }
        },
        selectedItemColor: Color(0xfffb56a2),
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: TextStyle(color: Colors.grey),
      ),
    );
  }
}
