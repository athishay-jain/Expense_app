
import 'package:expance_app/Local/Bloc/expense_bloc.dart';
import 'package:expance_app/Local/Bloc/expense_event.dart';
import 'package:expance_app/Local/Bloc/expense_state.dart';
import 'package:expance_app/Local/Models/expense_model.dart';
import 'package:expance_app/UI/CutomWidget/CustomDatepicker.dart';
import 'package:expance_app/UI/CutomWidget/ExText.dart';
import 'package:expance_app/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../CutomWidget/customSelecot.dart';

class AddExpense extends StatefulWidget {
  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  bool selector = true;
  DateTime? currentdate;
  TextEditingController amountController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void _handletoggle(bool value) {
    selector = value;
    if (selectedCategory > 0) {
      selectedCategory = -1;
    }
    setState(() {});
  }

  void _handelDate(DateTime date) {
    currentdate = date;
  }

  int selectedCategory = -1;
  bool showCategory = false;

  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    print("Curremt date form Datepicker is :$currentdate");
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 190,
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
            child: Center(
              child: Extext(
                data: "Add the Transaction",
                size: 30,
                fwight: FontWeight.bold,
                textColor: Colors.white,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 150),
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
                    blurRadius: 20,
                    offset: Offset(0, -2),
                  ),
                ],
                borderRadius: BorderRadius.circular(30)),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 60,
                    width: 380,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1, color: Colors.grey)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 3,
                        ),
                        ToggleSelector(
                          selector: selector,
                          onToggle: _handletoggle,
                        ),
                        Container(
                          height: 50,
                          width: 1,
                          color: Colors.grey,
                        ),
                        CustomDatePicker(onDatechanged: _handelDate),
                        SizedBox(
                          width: 12,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  SizedBox(
                    width: 360,
                    child: TextFormField(
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return "Amount is required";
                        }
                        else{
                          return null;
                        }
                      },
                      keyboardType: TextInputType.number,
                      controller: amountController,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                          color: selector ? Colors.red : Colors.green),
                      decoration: InputDecoration(
                        label: Extext(
                          data: "Amount",
                          size: 25,
                          fwight: FontWeight.w600,
                          textColor: selector ? Colors.red : Colors.green,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(
                              top: 8, bottom: 8, left: 20),
                          child: Text(
                            "\u{20B9}",
                            style: TextStyle(fontSize: 40, color: Colors.grey),
                          ),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Color(0xfffb56a2),
                            width: 2,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Color(0xfffb56a2),
                            width: 2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.red.shade700)
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Title is Required";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.name,
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: "Enter the title ",
                        label: Text(
                          "Title",
                          style: TextStyle(
                              fontFamily: "poppies",
                              fontWeight: FontWeight.bold),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(color: Colors.red.shade700),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide:
                              BorderSide(color: Color(0xfffd559e), width: 2),
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
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                    child: TextFormField(
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return "Description is required";
                        }else{
                          return null;
                        }
                      },
                      keyboardType: TextInputType.name,
                      controller: descriptionController,
                      decoration: InputDecoration(
                        hintText: "Enter the Description ",
                        label: Text(
                          "Description",
                          style: TextStyle(
                              fontFamily: "poppies",
                              fontWeight: FontWeight.bold),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(color: Colors.red.shade700),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide:
                              BorderSide(color: Color(0xfffd559e), width: 2),
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
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            height: double.infinity,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 30, left: 10, right: 10),
                              child: Column(
                                children: [
                                  Extext(
                                      data: "Select the category",
                                      size: 20,
                                      fwight: FontWeight.w500),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Expanded(
                                    child: GridView.builder(
                                        itemCount: selector
                                            ? AppConstansts
                                                .expenseCategoryItems.length
                                            : AppConstansts
                                                .incomeCategoryItems.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          mainAxisSpacing: 20,
                                          crossAxisSpacing: 20,
                                          childAspectRatio: 1 / 1,
                                        ),
                                        itemBuilder: (_, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(0),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                selectedCategory = index;
                                                showCategory = true;
                                                Navigator.pop(context);
                                                setState(() {});
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  elevation: 2,
                                                  backgroundColor: Colors.white,
                                                  overlayColor: Colors.pink,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15))),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Image.asset(
                                                    selector
                                                        ? AppConstansts
                                                                .expenseCategoryItems[
                                                            index]["icon"]
                                                        : AppConstansts
                                                                .incomeCategoryItems[
                                                            index]["icon"],
                                                    scale: 10,
                                                  ),
                                                  Extext(
                                                    data: selector
                                                        ? AppConstansts
                                                                .expenseCategoryItems[
                                                            index]["title"]
                                                        : AppConstansts
                                                                .incomeCategoryItems[
                                                            index]["title"],
                                                    size: 13,
                                                    fwight: FontWeight.w600,
                                                    align: TextAlign.center,
                                                    textColor:
                                                        Color(0xfffb56a2),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Color(0xfffb56a2),
                        elevation: 3,
                        backgroundColor: Colors.grey.shade50,
                        minimumSize: Size(220, 120),
                        maximumSize: Size(220, 120),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: selectedCategory >= 0
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Image.asset(
                                selector
                                    ? AppConstansts.expenseCategoryItems[
                                        selectedCategory]["icon"]
                                    : AppConstansts.incomeCategoryItems[
                                        selectedCategory]["icon"],
                                scale: 10,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Extext(
                                data: selector
                                    ? AppConstansts.expenseCategoryItems[
                                        selectedCategory]["title"]
                                    : AppConstansts.incomeCategoryItems[
                                        selectedCategory]["title"],
                                size: 14,
                                fwight: FontWeight.bold,
                                align: TextAlign.center,
                              )
                            ],
                          )
                        : Column(
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Icon(
                                Icons.add,
                                size: 50,
                                color: Color(0xfffb56a2),
                              ),
                              Extext(
                                data: "Select Category",
                                size: 14,
                                fwight: FontWeight.bold,
                                align: TextAlign.center,
                              )
                            ],
                          ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Color(0xfffb56a2),
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 5),
                            side: BorderSide(
                              color: Color(0xfffb56a2),
                            ),
                          ),
                          child: Extext(
                              data: "Cancel",
                              size: 20,
                              fwight: FontWeight.w600)),
                      BlocListener<ExpenseBloc , ExpenseState>(
                        listener: (context, state) {
                          if (state is ExpenseLoadingState) {
                            isloading = true;
                            setState(() {});
                          }
                          if (state is ExpenseLoadedlState) {
                           isloading = false;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Transaction added"),
                              ),
                            );
                            Navigator.pop(context);
                          }
                          if (state is ExpenseErrorStete) {
                            isloading = false;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.errorMes),
                              ),
                            );
                            setState(() {});
                          }

                        },
                        child: ElevatedButton(
                            onPressed: () async{
                              /// get last balance from prefs and set to Expense model
                              SharedPreferences Prefs = await SharedPreferences.getInstance();
                              double lastBalance = await Prefs.getDouble(AppConstansts.lastBalance) ?? 0;

                             /// check if expense or income
                              if(selector){
                                lastBalance = lastBalance - double.parse(amountController.text);
                              }else{
                                lastBalance += double.parse(amountController.text);
                              }

                              if (formKey.currentState!.validate()) {
                                context.read<ExpenseBloc>().add(AddExpenseEvent(
                                    newExpense: ExpenseModel(
                                      expance_balance: lastBalance,
                                        expance_title: titleController.text,
                                        expance_description:
                                            descriptionController.text,
                                        expance_amount: double.parse(amountController.text),
                                        expance_category: selector
                                            ? AppConstansts
                                                    .expenseCategoryItems[
                                                selectedCategory]["id"]
                                            : AppConstansts.incomeCategoryItems[
                                                selectedCategory]["id"],
                                        expance_date: (currentdate ?? DateTime.now()).millisecondsSinceEpoch.toString(),
                                        expence_type: selector ? 1 : 0)));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 5),
                              backgroundColor: Color(0xfffb56a2),
                              foregroundColor: Colors.white,
                            ),
                            child: Extext(
                                data: "Save",
                                size: 20,
                                fwight: FontWeight.w600)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Visibility(
            visible: isloading,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.black.withAlpha(120),
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*ListView(
        shrinkWrap: true,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IntrinsicWidth(child: ToggleSelector(selector: selector,)),
            ],
          ),
        ],
      ),*/
