
import 'package:expance_app/UI/CutomWidget/ExText.dart';
import 'package:expance_app/UI/screens/HomeScreen/statisticPage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  List<Map<String, dynamic>> mdata1 = [
    {
      "icon": Icons.shopping_bag_outlined,
      "title": "Shop",
      "subtitle": "Buy new cloths",
      "expanse": "-₹2000"
    },
    {
      "icon": Icons.install_mobile_rounded,
      "title": "Electronic",
      "subtitle": "buy new iphone 14",
      "expanse": "-₹90000"
    },
    {
      "icon": Icons.emoji_food_beverage,
      "title": "Food",
      "subtitle": "had lunch outside",
      "expanse": "-₹500"
    },
  ];
  List<Map<String, dynamic>> mdata2 = [
    {
      "icon": Icons.car_rental_outlined,
      "title": "Transport",
      "subtitle": "Trip to Malanga",
      "expanse": "-₹2000"
    },
    {
      "icon": Icons.tv_rounded,
      "title": "Electronic",
      "subtitle": "Buy new Tv",
      "expanse": "-₹14000"
    },
    {
      "icon": Icons.emoji_food_beverage,
      "title": "Food",
      "subtitle": "had lunch outside",
      "expanse": "-₹500"
    },
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Image.asset("Assets/Images/logo_horizontal.png"),
        ),
        leadingWidth: 100,
        title: Padding(
          padding: const EdgeInsets.only(left: 240),
          child: Icon(
            Icons.search,
            size: 30,
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 70,
            width: double.infinity,
            child: ListTile(
              leading: CircleAvatar(
                radius: 22,
                child: Image.network(
                    "https://e7.pngegg.com/pngimages/799/987/png-clipart-computer-icons-avatar-icon-design-avatar-heroes-computer-wallpaper-thumbnail.png"),
              ),
              title:
                  Extext(data: "Moring", size: 14, fwight: FontWeight.normal),
              subtitle:
                  Extext(data: "Athishay", size: 18, fwight: FontWeight.w600),
              trailing: Container(
                width: 130,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0x15fd559e)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Extext(
                        data: "This month", size: 15, fwight: FontWeight.w500),
                    Icon(Icons.arrow_downward_rounded),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 170,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xffb646b5), Color(0xfffb56a2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Extext(
                        data: "Expanse Total",
                        size: 18,
                        fwight: FontWeight.w500,
                        textColor: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Extext(
                        data: "₹3,734",
                        size: 40,
                        fwight: FontWeight.bold,
                        textColor: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Card(
                          color: Colors.orange.shade500,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Extext(
                              data: "+₹240",
                              size: 16,
                              fwight: FontWeight.w500,
                              textColor: Colors.white,
                            ),
                          ),
                        ),
                        Extext(
                          data: "Then last Month",
                          size: 15,
                          fwight: FontWeight.w500,
                          textColor: Colors.white,
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Image.asset(
                  "Assets/Images/ic_budget.png",
                  scale: 4,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 15),
            child:
                Extext(data: "Expanse List", size: 27, fwight: FontWeight.w500),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            height: 200,
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey, width: 1),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Extext(
                        data: "Tuseday,14", size: 17, fwight: FontWeight.w500),
                  Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 18),
                      child: Extext(
                        data: "-₹1380",
                        size: 17,
                        fwight: FontWeight.w500,
                        textColor: Colors.red.shade400,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 340,
                  height: 1,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 152,
                  width: double.infinity,
                  child: ListView.builder(
                      itemCount: mdata1.length,
                      itemBuilder: (_, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            child: Icon(mdata1[index]["icon"]),
                          ),
                          title: Text(mdata1[index]["title"]),
                          subtitle: Text(mdata1[index]["subtitle"]),
                          trailing: Text(
                            mdata1[index]["expanse"],
                            style: TextStyle(fontSize: 15, color: Colors.red),
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 140,
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey, width: 1),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Extext(
                        data: "Monday,13", size: 17, fwight: FontWeight.w500),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 18),
                      child: Extext(
                        data: "-₹6000",
                        size: 17,
                        fwight: FontWeight.w500,
                        textColor: Colors.red.shade400,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 340,
                  height: 1,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 90,
                  width: double.infinity,
                  child: ListView.builder(
                      itemCount: mdata2.length,
                      itemBuilder: (_, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            child: Icon(mdata2[index]["icon"]),
                          ),
                          title: Text(mdata2[index]["title"]),
                          subtitle: Text(mdata2[index]["subtitle"]),
                          trailing: Text(
                            mdata2[index]["expanse"],
                            style: TextStyle(fontSize: 15, color: Colors.red),
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 160),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => StatisticPage(),));
          },
          elevation: 4,
          backgroundColor: Color(0xfffb56a2),
          child: Icon(
            Icons.analytics_outlined,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
