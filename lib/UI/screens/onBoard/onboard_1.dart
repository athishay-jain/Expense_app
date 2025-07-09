import 'package:expance_app/UI/CutomWidget/ExText.dart';
import 'package:expance_app/UI/screens/HomeScreen/HomePage.dart';
import 'package:flutter/material.dart';

import '../auth/Login_page.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController = PageController();
  int page = 0;

  List<Map<String, String>> onboardingData = [
    {
      "image": "Assets/Images/on_track.png",
      "title": "Stay on Top of Your Spending",
      "desc": "Monitor your daily, weekly, and monthly expenses effortlessly. Get insights into where your money goes."
    },
    {
      "image": "Assets/Images/on_set.png",
      "title": "Set Budgets & Save More",
      "desc": "Set custom budgets, receive alerts, and save smarter with Expo’s built-in financial tools"
    },
    {
      "image": "Assets/Images/on_Synk.png",
      "title": "Sync & Access Anytime",
      "desc": "Securely sync across devices and access your financial data whenever you need it — safe, fast, and reliable"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            page = index;
          });
        },
        itemCount: onboardingData.length,
        itemBuilder: (context, index) {
          return screen(
            image: onboardingData[index]["image"]!,
            title: onboardingData[index]["title"]!,
            desc: onboardingData[index]["desc"]!,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xfffd559e),
        foregroundColor: Colors.white,
        onPressed: () {
          if (page < onboardingData.length - 1) {
            _pageController.nextPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut);
          } else {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
          }
        },
        child: Icon(Icons.arrow_forward_rounded),
      ),
    );
  }

  Widget screen(
      {required String image, required String title, required String desc}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 40),
        Image.asset(image, scale: 2.5),
        Extext(
          data: title,
          size: 35,
          fwight: FontWeight.bold,
          align: TextAlign.center,
        ),
        SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Extext(
            data: desc,
            size: 18,
            fwight: FontWeight.normal,
            align: TextAlign.center,
          ),
        ),
        SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            onboardingData.length,
                (index) => Padding(
              padding: const EdgeInsets.all(6),
              child: CircleAvatar(
                backgroundColor:
                page == index ? Color(0xfffd559e) : Colors.grey,
                radius: 5,
              ),
            ),
          ),
        )
      ],
    );
  }
}
