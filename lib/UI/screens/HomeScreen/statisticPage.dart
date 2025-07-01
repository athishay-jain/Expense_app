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
  bool isLoading = false;

  TextEditingController expenseLimitController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();


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
            var expenseLimit = state.expenseLimit;
            var graphdata = state.mExpenses;
            double prefsLimit = state.prefsLimit!;
            double? spent = expenseLimit[0].expense?.toDouble();
            double ratio = (spent!.abs() / prefsLimit).clamp(0.0, 1.0);
            print("the ratio value is $ratio");
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
                                    data: "₹${expenseLimit[0].expense!.abs().toInt()}",
                                    size: 25,
                                    fwight: FontWeight.bold,
                                    textColor: Colors.white,
                                  )),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 8),
                                child: Extext(
                                  data: "/₹${prefsLimit.toInt().toString()} per month",
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
                          Container(
                            width: 300,
                            child: Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  height: 9,
                                  width: 290,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.white.withAlpha(100)),
                                ),
                                FractionallySizedBox(
                                  widthFactor: ratio,
                                  child: Container(
                                    margin: EdgeInsets.only(left: 20),
                                    height: 9,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.yellow),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, bottom: 70),
                        child: Material(
                          color: Colors.transparent,
                          shape: CircleBorder(),
                          child: InkWell(
                            radius: 16,

                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Form(
                                    key: formKey,
                                    child: AlertDialog(
                                      title: Center(
                                          child: Extext(
                                              data: "Expense Limit",
                                              size: 20,
                                              fwight: FontWeight.w500)),
                                      content: Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Extext(
                                            data: "Set the expense limit ",
                                            size: 14,
                                            fwight: FontWeight.w400),
                                      ),
                                      actionsAlignment: MainAxisAlignment.center,
                          
                                      actions: [
                                        Column(
                                          children: [
                                            TextFormField(
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return "Limit is required";
                                                }
                                                return null;
                                              },
                                              controller: expenseLimitController,
                                              keyboardType: TextInputType.number,
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.symmetric(vertical: 18,horizontal: 20),
                                                label: Text(
                                                  "Limit",
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
                                            SizedBox(
                                              height: 30,
                                            ),
                                           BlocListener<ExpenseBloc, ExpenseState>(listener: (ctx,state){
                                             if(state  is ExpenseLoadingState){
                                               isLoading = true;
                                               setState(() {
                          
                                               });
                                             }
                                             if(state is ExpenseLoadedlState){
                                               isLoading = false;
                                                setState(() {
                          
                                               });
                                               Future.microtask(() {
                                                 if (Navigator.canPop(context)) {
                                                   Navigator.pop(context);
                                                 }
                                               });
                          
                                             }
                                             if(state is ExpenseErrorState){
                                               isLoading = false;
                                               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("state.errorMes")));
                                               setState(() {
                                               });
                                             }
                                           },child: isLoading?Row(
                                             mainAxisAlignment: MainAxisAlignment.center,
                                             children: [
                                               CircularProgressIndicator(color: Colors.pink,),
                                               SizedBox(width: 5,),
                                               Extext(data: "Loading", size: 16, fwight: FontWeight.w600),
                                             ],
                                           ) : ElevatedButton(
                                             onPressed: () {
                                               if(formKey.currentState!.validate()){
                                                 context.read<ExpenseBloc>().add(Setexpenselimit(limit: double.parse(expenseLimitController.text)));
                                               expenseLimitController.clear();
                                               }
                                              // context.read<ExpenseBloc>().add(Setexpenselimit(limit: double.parse(expenseLimitController.text)));
                                             },
                                             style: ElevatedButton.styleFrom(
                                               backgroundColor: Color(0xfffb56a2),
                                               foregroundColor: Colors.white,
                                               shape: RoundedRectangleBorder(
                                                 borderRadius:
                                                 BorderRadius.circular(10),
                                               ),
                                               padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                                               minimumSize: Size(220, 40),
                                             ),
                                             child: Extext(
                                                 data: "SAVE",
                                                 size: 16,
                                                 fwight: FontWeight.w600),
                                           ),),
                                            SizedBox(height: 20,),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
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
                              tooltipBorder:
                                  BorderSide(width: 1, color: Colors.grey),
                              tooltipBorderRadius: BorderRadius.circular(6),
                              getTooltipColor: (group) {
                                return Color(0xfffef7ff);
                              })),
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
                            getTitlesWidget: (double value, TitleMeta meta) {
                              if (selectedintType == 1) {
                                print(graphdata[value.toInt()].title);
                                try {
                                  String inputDate =
                                      graphdata[value.toInt()].title.toString();
                                  DateFormat formet =
                                      DateFormat /*("EEE, MMM d,yyyy")*/
                                          .yMMMEd();

                                  DateTime actualdate = formet.parse(inputDate);

                                  String formatedDate =
                                      actualdate.day.toString();

                                  return Text(formatedDate);
                                } catch (e) {
                                  return Text("...");
                                }
                              } else {
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
                Row(
                  children: [
                    Spacer(),
                    CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.green,
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Extext(data: "Income", size: 14, fwight: FontWeight.w500),
                    SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.red,
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Extext(
                          data: "Expense", size: 14, fwight: FontWeight.w500),
                    ),
                  ],
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
    for (int a = 0; a < graphdatat.length; a++) {
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
    }
  }
}
