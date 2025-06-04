import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:expance_app/Local/Bloc/expense_bloc.dart';
import 'package:expance_app/Local/Bloc/expense_event.dart';
import 'package:expance_app/Local/Bloc/expense_state.dart';
import 'package:expance_app/Local/Models/filterExpenseModel.dart';
import 'package:expance_app/UI/CutomWidget/ExText.dart';
import 'package:expance_app/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EntryPage extends StatefulWidget {
  @override
  State<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  Map<String, int> selectType = {
    "Date wise": 1,
    "Monthly": 2,
    "Yearly": 3,
    "Category" : 4,
  };

  String selectedDate = "Date wise";
  int? selectedintType = 1;
  double? lastBalance = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context
        .read<ExpenseBloc>()
        .add(GetIntialExpense(filtertype: selectedintType??1));
    getBalance();
  }
void getBalance()async{
    SharedPreferences Prefs = await SharedPreferences.getInstance();
    lastBalance = await Prefs.getDouble(AppConstansts.lastBalance);
}
  @override
  Widget build(BuildContext context) {

    context
        .read<ExpenseBloc>()
        .add(GetIntialExpense(filtertype: selectedintType??1));
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
          if (state is ExpenseErrorStete) {
            return Center(
              child: Extext(
                  data: state.errorMes, size: 25, fwight: FontWeight.bold),
            );
          }
          if (state is ExpenseLoadedlState) {
            var expenseData = state.mExpenses;

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
                                  boxShadow: [BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 3,
                                    offset: Offset(0, 2),
                                  )]
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 5),
                              ),
                              dropdownStyleData: DropdownStyleData(
                                offset: Offset(0, -5),

                                decoration: BoxDecoration(
                                    color:Color(0xffFFEDFA),
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
                                    data: "₹${lastBalance??0}",
                                    size: 40,
                                    fwight: FontWeight.bold,
                                    textColor: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              /*  Row(
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
                                )*/
                              ],
                            ),
                           Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 30),
                              child: Image.asset(
                                "Assets/Images/ic_budget.png",
                                scale: 4,
                              ),
                            )
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
                                            fwight: FontWeight.w500),
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
                                                  fwight: FontWeight.w500,
                                                  textColor:
                                                      Colors.red.shade400,
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
                                        itemCount: expenseData[index]
                                            .allExpense
                                            .length,
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
                                                        color:
                                                            Color(0xfffb56a2)),
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
}
