import 'package:expance_app/UI/CutomWidget/ExText.dart';
import 'package:flutter/material.dart';

class StatisticPage extends StatelessWidget {
  List<Map<String, dynamic>> mdata1 = [
    {
      "icon": Icons.shopping_bag_outlined,
      "title": "Shop",
      "expanse": "-₹2000",
    },
    {
      "icon": Icons.install_mobile_rounded,
      "title": "Electronic",
      "expanse": "-₹90000"
    },
    {
      "icon": Icons.emoji_food_beverage,
      "title": "Food",
      "expanse": "-₹500",
    },
    {
      "icon": Icons.car_rental_outlined,
      "title": "Transport",
      "expanse": "-₹2000"
    },
    {
      "icon": Icons.tv_rounded,
      "title": "Electronic",
      "expanse": "-₹14000"
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Extext(data: "Statistic", size: 26, fwight: FontWeight.w600),
            Spacer(),
            Container(
              width: 130,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0x15fd559e)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Extext(data: "This month", size: 15, fwight: FontWeight.w500),
                  Icon(Icons.arrow_downward_rounded),
                ],
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 140,
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
                      height: 15,
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Extext(
                            data: "₹3,734",
                            size: 25,
                            fwight: FontWeight.bold,
                            textColor: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 8),
                          child: Extext(
                            data: "/₹4,000 per month",
                            size: 16,
                            fwight: FontWeight.w500,
                            textColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          height: 9,
                          width: 290,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white.withAlpha(100)),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          height: 9,
                          width: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.yellow),
                        ),
                      ],
                    )
                  ],
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 20, bottom: 70),
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.white.withAlpha(80),
                    child: Icon(
                      Icons.more_horiz,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Extext(
                    data: "Expanse List", size: 26, fwight: FontWeight.w500),
              ),
              Spacer(),
              Container(
                margin: EdgeInsets.only(right: 20),
                height: 35,
                width: 90,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0x15fd559e)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Extext(data: "Week", size: 15, fwight: FontWeight.w500),
                    Icon(Icons.arrow_downward_rounded),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Extext(
                data: "Limit₹900 / week", size: 15, fwight: FontWeight.w400),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 200,
            decoration: BoxDecoration(
                color: Colors.purple, borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text(
                "Graph To be Added",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Extext(
                data: "Spending Details", size: 26, fwight: FontWeight.w500),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 22),
            child: Extext(
                data: "Your expenses are divided into 6 categories",
                size: 15,
                fwight: FontWeight.w400),
          ),
          SizedBox(
            height: 30,
          ),
          Stack(
            children: [
              Container(
                margin: EdgeInsets.only(left: 20),
                height: 9,
                width: 350,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.green),
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                height: 9,
                width: 320,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50), color: Colors.red),
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                height: 9,
                width: 290,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.blueAccent),
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                height: 9,
                width: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.yellow),
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                height: 9,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.pink),
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                height: 9,
                width: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.indigo),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 25,
              ),
              Extext(data: "40%", size: 15, fwight: FontWeight.normal),
              SizedBox(
                width: 90,
              ),
              Extext(data: "25%", size: 15, fwight: FontWeight.normal),
              SizedBox(
                width: 40,
              ),
              Extext(data: "15%", size: 15, fwight: FontWeight.normal),
              SizedBox(
                width: 29,
              ),
              Extext(data: "10%", size: 15, fwight: FontWeight.normal),
              SizedBox(
                width: 18,
              ),
              Extext(data: "5%", size: 15, fwight: FontWeight.normal),
              SizedBox(
                width: 5,
              ),
              Extext(data: "5%", size: 15, fwight: FontWeight.normal),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 16 / 8,
                crossAxisSpacing: 30,
                mainAxisSpacing: 20,
              ),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: mdata1.length,
              padding: EdgeInsets.only(left: 30, right: 30),
              itemBuilder: (_, index) {
                return Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        child: Icon(mdata1[index]["icon"]),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Column(
                        children: [
                          Extext(
                              data: mdata1[index]["title"],
                              size: 15,
                              fwight: FontWeight.normal),
                          Extext(
                            data: mdata1[index]["expanse"],
                            size: 15,
                            fwight: FontWeight.normal,
                            textColor: Colors.red.shade700,
                          ),
                        ],
                      )
                    ],
                  ),
                );
              })
        ],
      ),
    );
  }
}
