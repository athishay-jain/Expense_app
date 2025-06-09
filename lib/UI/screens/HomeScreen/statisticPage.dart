import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:expance_app/Local/Bloc/expense_bloc.dart';
import 'package:expance_app/Local/Bloc/expense_event.dart';
import 'package:expance_app/Local/Bloc/expense_state.dart';
import 'package:expance_app/UI/CutomWidget/ExText.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class StatisticPage extends StatefulWidget {
  @override
  State<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
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
    {"icon": Icons.tv_rounded, "title": "Electronic", "expanse": "-₹14000"},
  ];
  Map<String, int> selectType = {
    "Date wise": 1,
    "Monthly": 2,
    "Yearly": 3,
  };

  String selectedDate = "Date wise";
  int? selectedintType = 1;

  @override
  Widget build(BuildContext context) {
    context
        .read<ExpenseBloc>()
        .add(GetIntialExpense(filtertype: selectedintType!));
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
      body: BlocBuilder<ExpenseBloc, ExpenseState>(
        builder: (_, state) {
          if (state is ExpenseLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.pink,
              ),
            );
          }
          if (state is ExpenseLoadedlState) {
            late List<BarChartGroupData> bardata = [];
            var graphdata = state.mExpenses;
            BarCharGroup(graphdata, bardata);
            return ListView(
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
                                  data: "₹${graphdata[0].expense!.abs()}",
                                  size: 25,
                                  fwight: FontWeight.bold,
                                  textColor: Colors.white,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 8),
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
                        child: InkWell(
                          autofocus: true,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Popup Sheet'),
                                  content: Text(
                                      'This is a popup dialog in Flutter!'),
                                  actionsAlignment: MainAxisAlignment.center,
                                  actions: [
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 50,
                                          width: 200,
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            OutlinedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              style: OutlinedButton.styleFrom(
                                                  side: BorderSide(
                                                    color: Color(0xfffb56a2),
                                                    width: 1,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  )),
                                              child: Text(
                                                'Close',
                                                style: TextStyle(
                                                  color: Color(0xfffb56a2),
                                                ),
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Color(0xfffb56a2),
                                                  foregroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10))),
                                              child: Text("Save"),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                );
                              },
                            );
                            setState(() {});
                          },
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: Colors.white.withAlpha(80),
                            child: Icon(
                              Icons.more_horiz,
                              color: Colors.white,
                            ),
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
                          data: "Graph", size: 26, fwight: FontWeight.w500),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<int>(
                          isDense: true,
                          items: selectType.entries.map((e) {
                            return DropdownMenuItem(
                              value: e.value,
                              child: Extext(
                                  data: e.key,
                                  size: 16,
                                  fwight: FontWeight.w500),
                            );
                          }).toList(),
                          value: selectedintType,
                          onChanged: (value) {
                            selectedintType = value;
                            setState(() {});
                          },
                          iconStyleData: IconStyleData(
                              icon: Icon(Icons.keyboard_arrow_down_rounded)),
                          buttonStyleData: ButtonStyleData(
                            height: 40,
                            decoration: BoxDecoration(
                                color: Color(0xffFFEDFA),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 3,
                                    offset: Offset(0, 2),
                                  )
                                ]),
                            padding: EdgeInsets.symmetric(horizontal: 5),
                          ),
                          dropdownStyleData: DropdownStyleData(
                            offset: Offset(0, -5),
                            decoration: BoxDecoration(
                                color: Color(0xffFFEDFA),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                    topRight: Radius.circular(5),
                                    topLeft: Radius.circular(5))),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                /* SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Extext(
                      data: "Limit₹900 / week",
                      size: 15,
                      fwight: FontWeight.w400),
                ),*/
                SizedBox(
                  height: 25,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: 200,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: BarChart(
                    BarChartData(
                      barTouchData: BarTouchData(
                        enabled: true,
                        touchTooltipData: BarTouchTooltipData(
                          tooltipBorder: BorderSide(width: 1,color: Colors.grey),
                          tooltipBorderRadius: BorderRadius.circular(6),
                          getTooltipColor:(group){
                            return Color(0xfffef7ff);
                          }
                        )
                      ),
                      barGroups: bardata,
                      titlesData: FlTitlesData(
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false,
                          ),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false,
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            getTitlesWidget: (double value, TitleMeta meta)  {
                              if (selectedintType == 1) {
                                print(graphdata[value.toInt()].title);

                                String inputDate =
                                    graphdata[value.toInt()].title.toString();
                                DateFormat formet = DateFormat/*("EEE, MMM d,yyyy")*/.yMMMEd();
                                DateTime actualdate = formet.parse(inputDate);

                                String formatedDate = actualdate.day.toString();

                               return Text(formatedDate);
                              }
                              else {
                                return Text(graphdata[value.toInt()].title);
                              }
                            },
                            showTitles: true,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Extext(
                      data: "Spending Details",
                      size: 26,
                      fwight: FontWeight.w500),
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
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.red),
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
            );
          }
          if (state is ExpenseErrorState) {
            return Center(
              child: Extext(
                  data: state.errorMes, size: 25, fwight: FontWeight.bold),
            );
          }
          return Container();
        },
      ),
    );
  }

  void BarCharGroup(var graphdatat, List bardata) {
    print("the lenth of the grphdata is ${graphdatat.length}");
    for (int a = 0; a < graphdatat.length; a++) {
      int index = 0;
      print("the index before loop $a");
      bardata.add(BarChartGroupData(
        x: a,
        barRods: [
          BarChartRodData(
            toY: graphdatat[a].expense!.toDouble().abs(),
            color: Colors.red,
            width: 20,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          BarChartRodData(
            toY: graphdatat[a].income!.toDouble(),
            color: Colors.green,
            width: 20,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
        ],
      ));
      index++;
      print("the index after loop $a");
    }
  }
}
