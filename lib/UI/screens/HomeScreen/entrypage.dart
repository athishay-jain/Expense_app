import 'package:expance_app/Local/Bloc/expense_bloc.dart';
import 'package:expance_app/Local/Bloc/expense_event.dart';
import 'package:expance_app/Local/Bloc/expense_state.dart';
import 'package:expance_app/Local/Models/filterExpenseModel.dart';
import 'package:expance_app/UI/CutomWidget/ExText.dart';
import 'package:expance_app/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EntryPage extends StatefulWidget {
  @override
  State<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
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

  List<String> selectType = ["Date wise", "Monthly", "Yearly"];

  String selectedDate = "Date wise";
  int selectedintType = 2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context
        .read<ExpenseBloc>()
        .add(GetIntialExpense(filtertype: selectedintType));
  }

  @override
  Widget build(BuildContext context) {
    context
        .read<ExpenseBloc>()
        .add(GetIntialExpense(filtertype: selectedintType));
    // TODO: implement build
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
      body: BlocBuilder<ExpenseBloc, ExpenseState>(
        builder: (_, state) {
          if (state is ExpenseLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: Color(0xfffb56a2),
              ),
            );
          }
          if (state is ExpenseErrorStete) {
            return Center(
              child: Extext(
                  data: state.errorMes, size: 25, fwight: FontWeight.bold),
            );
          }
          if (state is ExpenseLoadedlState) {
            var expenseData = state.mExpenses;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      title: Extext(
                          data: "Moring", size: 14, fwight: FontWeight.normal),
                      subtitle: Extext(
                          data: "Athishay", size: 18, fwight: FontWeight.w600),
                      trailing: DropdownMenu(
                          inputDecorationTheme: InputDecorationTheme(
                            filled: true,
                            fillColor: Color(0x15fd559e),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none),
                          ),
                          menuStyle: MenuStyle(
                            backgroundColor:
                                WidgetStateProperty.all(Colors.white),
                          ),
                          initialSelection: selectedDate,
                          onSelected: (value) {
                            selectedDate = value!;
                          },
                          dropdownMenuEntries: selectType.map(
                            (e) {
                              return DropdownMenuEntry(
                                value: e,
                                label: e,
                              );
                            },
                          ).toList())),
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
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: Extext(
                      data: "Expanse List", size: 27, fwight: FontWeight.w500),
                ),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: expenseData.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
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
                                      data: expenseData[index].title,
                                      size: 17,
                                      fwight: FontWeight.w500),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 18),
                                    child: expenseData[index].bal < 0
                                        ? Extext(
                                            data: expenseData[index]
                                                .bal
                                                .toString(),
                                            size: 17,
                                            fwight: FontWeight.w500,
                                            textColor: Colors.red.shade400,
                                          )
                                        : Extext(
                                            data: expenseData[index]
                                                .bal
                                                .toString(),
                                            size: 17,
                                            fwight: FontWeight.w500,
                                            textColor: Colors.green,
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
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount:
                                      expenseData[index].allExpense.length,
                                  itemBuilder: (_, cindex) {
                                    return ListTile(
                                      leading: expenseData[index]
                                                  .allExpense[cindex]
                                                  .expence_type ==
                                              1
                                          ? Image.asset(
                                              "${AppConstansts.expenseCategoryItems[expenseData[index].allExpense[cindex].expance_category]["icon"]}",
                                              scale: 10,
                                            )
                                          : Image.asset(
                                              "${AppConstansts.incomeCategoryItems[expenseData[index].allExpense[cindex].expance_category]["icon"]}",
                                              scale: 10,
                                            ),
                                      title: Text(expenseData[index]
                                          .allExpense[cindex]
                                          .expance_title),
                                      subtitle: Text(expenseData[index]
                                          .allExpense[cindex]
                                          .expance_description),
                                      trailing: expenseData[index]
                                                  .allExpense[cindex]
                                                  .expence_type ==
                                              1
                                          ? Text(
                                              expenseData[index]
                                                  .allExpense[cindex]
                                                  .expance_amount
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Color(0xfffb56a2)),
                                            )
                                          : Text(
                                              expenseData[index]
                                                  .allExpense[cindex]
                                                  .expance_amount
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.green),
                                            ),
                                    );
                                  })
                            ],
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: 20,
                ),
                /* Container(
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
                      height: 150,
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
                                style: TextStyle(
                                    fontSize: 15, color: Color(0xfffb56a2)),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),*/
              ],
            );
          }
          return Container(
            child: Center(
              child: CircularProgressIndicator(
                color: Color(0xfffb56a2),
              ),
            ),
          );
        },
      ),
    );
  }
}
