import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:expance_app/UI/CutomWidget/ExText.dart';
import 'package:expance_app/UI/screens/HomeScreen/AddExpensePage.dart';
import 'package:expance_app/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Online/Bloc/expense_bloc.dart';
import '../../../Online/Bloc/expense_event.dart';
import '../../../Online/Bloc/expense_state.dart';

class EntryPage extends StatefulWidget {
  @override
  State<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  Map<String, int> selectType = {
    "Date wise": 1,
    "Monthly": 2,
    "Yearly": 3,
    "Category": 4,
  };

  String selectedDate = "Date wise";
  int? selectedintType = 1;
  double lastBalance = 0;
  bool showlastexp = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context
        .read<ExpenseBloc>()
        .add(GetIntialExpense(filtertype: selectedintType ?? 1));
    getBalance();
  }

  void getBalance() async {
    SharedPreferences Prefs = await SharedPreferences.getInstance();
    lastBalance = await Prefs.getDouble(AppConstansts.lastBalance) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    context
        .read<ExpenseBloc>()
        .add(GetIntialExpense(filtertype: selectedintType ?? 1));
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
          getBalance();
          if (state is ExpenseLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: Color(0xfffb56a2),
              ),
            );
          }
          if (state is ExpenseErrorState) {
            return Center(
              child: Extext(
                  data: state.errorMes, size: 25, fwight: FontWeight.bold),
            );
          }
          if (state is ExpenseLoadedlState) {
            var expenseData = state.mExpenses;
            var expLastIndex = expenseData.length - 1;
            return expenseData.isNotEmpty
                ? Column(
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
                              data: "Moring",
                              size: 14,
                              fwight: FontWeight.normal),
                          subtitle: Extext(
                              data: "Athishay",
                              size: 18,
                              fwight: FontWeight.w600),
                          trailing: DropdownButtonHideUnderline(
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
                                  icon:
                                      Icon(Icons.keyboard_arrow_down_rounded)),
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            selectedintType == 4
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 25,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Extext(
                                              data: "Total Transaction",
                                              size: 18,
                                              fwight: FontWeight.w500,
                                              textColor: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Extext(
                                              data: /*"₹${expenseData[expLastIndex].bal}"*/
                                                  "₹${TotalExpense(
                                                lastbla: lastBalance,
                                                expensedata: expenseData,
                                              )}",
                                              size: 40,
                                              fwight: FontWeight.bold,
                                              textColor: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Visibility(
                                              visible: showlastexp,
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Card(
                                                    color:
                                                        Colors.orange.shade500,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6)),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 8,
                                                          vertical: 2),
                                                      child: Extext(
                                                        data: lastmonthEx(
                                                            expensedata:
                                                                expenseData),
                                                        size: 16,
                                                        fwight: FontWeight.w500,
                                                        textColor: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  Extext(
                                                    data: "Then Last",
                                                    size: 13,
                                                    fwight: FontWeight.w500,
                                                    textColor: Colors.white,
                                                  ),
                                                ],
                                              ))
                                        ],
                                      ),
                                      Image.asset(
                                        "Assets/Images/ic_budget.png",
                                        scale: 4,
                                      ),
                                    ],
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 25,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Extext(
                                          data: "Total Expense",
                                          size: 18,
                                          fwight: FontWeight.w500,
                                          textColor: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Extext(
                                          data: /*"₹${expenseData[expLastIndex].bal}"*/
                                              "₹${TotalExpense(
                                            lastbla: lastBalance,
                                            expensedata: expenseData,
                                          )}",
                                          size: 30,
                                          fwight: FontWeight.bold,
                                          textColor: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Visibility(
                                          visible: showlastexp,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Card(
                                                color: Colors.orange.shade500,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6)),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8,
                                                      vertical: 2),
                                                  child: Extext(
                                                    data: lastmonthEx(
                                                        expensedata:
                                                            expenseData),
                                                    size: 16,
                                                    fwight: FontWeight.w500,
                                                    textColor: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Extext(
                                                data: "Then Last",
                                                size: 13,
                                                fwight: FontWeight.w500,
                                                textColor: Colors.white,
                                              ),
                                            ],
                                          ))
                                    ],
                                  ),
                            Visibility(
                              visible: selectedintType! < 4,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Extext(
                                        data: "Total Income",
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
                                        data: /*"₹${expenseData[expLastIndex].bal}"*/
                                            "₹${TotalIncome(
                                          lastbla: lastBalance,
                                          expensedata: expenseData,
                                        )}",
                                        size: 30,
                                        fwight: FontWeight.bold,
                                        textColor: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Visibility(
                                      visible: showlastexp,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Card(
                                            color: Colors.orange.shade500,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 2),
                                              child: Extext(
                                                data: lastmonthIn(
                                                    expensedata: expenseData),
                                                size: 16,
                                                fwight: FontWeight.w500,
                                                textColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Extext(
                                            data: "Then Last",
                                            size: 13,
                                            fwight: FontWeight.w500,
                                            textColor: Colors.white,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 20),
                        child: Extext(
                            data: "Expanse List",
                            size: 27,
                            fwight: FontWeight.w500),
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
                                  border:
                                      Border.all(color: Colors.grey, width: 1),
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
                                            fwight: FontWeight.w600),
                                        Spacer(),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 18),
                                          child: expenseData[index].bal < 0
                                              ? Extext(
                                                  data: expenseData[index]
                                                      .bal
                                                      .toString(),
                                                  size: 17,
                                                  fwight: FontWeight.w600,
                                                  textColor:
                                                      Colors.red.shade400,
                                                )
                                              : Extext(
                                                  data: expenseData[index]
                                                      .bal
                                                      .toString(),
                                                  size: 17,
                                                  fwight: FontWeight.w600,
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
                                        itemCount: expenseData[index]
                                            .allExpense
                                            .length,
                                        itemBuilder: (_, cindex) {
                                          return ListTile(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  PageRouteBuilder(
                                                    pageBuilder: (context,
                                                            animation,
                                                            secondaryAnimation) =>
                                                        AddExpense(
                                                      isUpdate: true,
                                                      expense: expenseData[
                                                              index]
                                                          .allExpense[cindex],
                                                    ),
                                                    transitionsBuilder:
                                                        (context,
                                                            animation,
                                                            secondaryAnimation,
                                                            child) {
                                                      var begin = Offset(0, 1);
                                                      var end = Offset.zero;
                                                      var curve = Curves
                                                          .easeInOutCubicEmphasized;
                                                      var tween = Tween(
                                                              begin: begin,
                                                              end: end)
                                                          .chain(CurveTween(
                                                              curve: curve));

                                                      return SlideTransition(
                                                        position: animation
                                                            .drive(tween),
                                                        child: child,
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
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
                                              title: Extext(
                                                data: expenseData[index]
                                                    .allExpense[cindex]
                                                    .expance_title,
                                                size: 16,
                                                fwight: FontWeight.w500,
                                              ),
                                              subtitle: Extext(
                                                data: expenseData[index]
                                                    .allExpense[cindex]
                                                    .expance_description,
                                                size: 14,
                                                fwight: FontWeight.w400,
                                              ),
                                              trailing: expenseData[index]
                                                          .allExpense[cindex]
                                                          .expence_type ==
                                                      1
                                                  ? Extext(
                                                      data: expenseData[index]
                                                          .allExpense[cindex]
                                                          .expance_amount
                                                          .toInt()
                                                          .toString(),
                                                      size: 16,
                                                      fwight: FontWeight.w500,
                                                      textColor:
                                                          Color(0xfffb56a2),
                                                    )
                                                  : Extext(
                                                      data: expenseData[index]
                                                          .allExpense[cindex]
                                                          .expance_amount
                                                          .toInt()
                                                          .toString(),
                                                      size: 16,
                                                      fwight: FontWeight.w500,
                                                      textColor: Colors.green,
                                                    ));
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
                  )
                : Center(
                    child: Extext(
                        data: "No Translation Found",
                        size: 25,
                        fwight: FontWeight.w600),
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

  String TotalExpense({
    required double lastbla,
    required var expensedata,
  }) {
    var expLastIndex = 0;
    if (selectedintType == 4) {
      return lastbla.toString();
    } else {
      num result = expensedata[expLastIndex].expense;
      return result.abs().toInt().toString();
    }
  }

  String TotalIncome({
    required double lastbla,
    required var expensedata,
  }) {
    var expLastIndex = 0;
    if (selectedintType == 4) {
      return lastbla.toString();
    } else {
      num result = expensedata[expLastIndex].income;
      return result.abs().toInt().toString();
    }
  }

  String lastmonthEx({required var expensedata}) {
    var expLastIndex = 0;
    var explIndex = 1;
    if (selectedintType == 4) {
      showlastexp = false;
      return "";
    } else if (expensedata.length == 1) {
      showlastexp = false;
      return "No data";
    } else {
      showlastexp = true;
      num lastExp = expensedata[explIndex].expense;
      num Exp = expensedata[expLastIndex].expense;
      num result = (Exp.abs() - lastExp.abs());
      // return "$result";
      return result < 0
          ? result.toInt().toString()
          : "+${result.toInt().toString()}";
    }
  }

  String lastmonthIn({required var expensedata}) {
    var expLastIndex = 0;
    var explIndex = 1;
    if (selectedintType == 4) {
      showlastexp = false;
      return "";
    } else if (expensedata.length == 1) {
      showlastexp = false;
      return "No data";
    } else {
      showlastexp = true;
      num lastExp = expensedata[explIndex].income;
      num Exp = expensedata[expLastIndex].income;
      num result = (Exp.abs() - lastExp.abs());
      // return "$result";
      return result < 0
          ? result.toInt().toString()
          : "+${result.toInt().toString()}";
    }
  }
}
