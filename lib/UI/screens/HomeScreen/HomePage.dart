import 'package:expance_app/UI/screens/HomeScreen/AddExpensePage.dart';
import 'package:expance_app/UI/screens/HomeScreen/ProfilePage.dart';
import 'package:expance_app/UI/screens/HomeScreen/entrypage.dart';
import 'package:expance_app/UI/screens/HomeScreen/statisticPage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectednavigation = 0;
  late PageController _pageController;

  List<Widget> navigate = [
    EntryPage(),
    StatisticPage(),
    Center(
      child: Text(
        "Notification",
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    ),
    Profilepage(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectednavigation);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      selectednavigation = index;
    });
  }

  void _onNavTapped(int index) {
    // Handle jump over FAB slot (index 2 is dummy)
    if (index >= 2) index -= 1;
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: navigate.length,
        onPageChanged: _onPageChanged,
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              double value = 1.0;
              if (_pageController.position.haveDimensions) {
                value = (_pageController.page! - index).abs();
                value = (1 - (value * 0.3)).clamp(0.7, 1.0);
              }
              return Opacity(
                opacity: value,
                child: Transform.scale(
                  scale: value,
                  child: navigate[index],
                ),
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  AddExpense(isUpdate: false,),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                var begin = Offset(0, 1);
                var end = Offset.zero;
                var curve = Curves.easeInOutCubicEmphasized;
                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            ),
          );
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
            icon: Image.asset(
              "Assets/Images/interface_icons/ic_home_outlined.png",
              scale: 25,
              color: Colors.grey,
            ),
            activeIcon: Image.asset(
              "Assets/Images/interface_icons/ic_home_filed.png",
              scale: 25,
              color: Color(0xfffb56a2),
            ),
            label: "Home",
          ),
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
            label: "Profile",
          ),
        ],
        currentIndex:
        selectednavigation < 2 ? selectednavigation : selectednavigation + 1,
        onTap: _onNavTapped,
        selectedItemColor: Color(0xfffb56a2),
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: TextStyle(color: Colors.grey),
      ),
    );
  }
}
