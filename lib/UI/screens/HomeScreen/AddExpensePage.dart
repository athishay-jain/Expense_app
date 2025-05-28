import 'package:expance_app/UI/CutomWidget/CustomDatepicker.dart';
import 'package:expance_app/UI/CutomWidget/ExText.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

import '../../CutomWidget/customSelecot.dart';

class AddExpense extends StatefulWidget {
  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  bool selector = true;
  String currentdate = "";

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void _handletoggle(bool value) {
    selector = value;
    setState(() {});
  }

  void _handelDate(String date) {
    currentdate = date;
  }

  int selectedCategory = 0;
  bool showCategory = false;
  List<Map<String, dynamic>> categoryItems = [
    {
      "icon": "Assets/Images/icons/bag.png",
      "title": "Shopping",
    },
    {
      "icon": "Assets/Images/icons/bill.png",
      "title": "Utilities",
    },
    {
      "icon": "Assets/Images/icons/spoon-and-fork.png",
      "title": "Dining Out",
    },
    {
      "icon": "Assets/Images/icons/vehicles.png",
      "title": "Transport",
    },
    {
      "icon": "Assets/Images/icons/application.png",
      "title": "Others",
    },
  ];

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
                    keyboardType: TextInputType.number,
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
                        padding:
                            const EdgeInsets.only(top: 8, bottom: 8, left: 20),
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
                            fontFamily: "poppies", fontWeight: FontWeight.bold),
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
                    keyboardType: TextInputType.name,
                    controller: descriptionController,
                    decoration: InputDecoration(
                      hintText: "Enter the Description ",
                      label: Text(
                        "Description",
                        style: TextStyle(
                            fontFamily: "poppies", fontWeight: FontWeight.bold),
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
                SizedBox(height: 20,),
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
                                      itemCount: categoryItems.length,
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
                                                  categoryItems[index]["icon"],
                                                  scale: 10,
                                                ),
                                                Extext(
                                                  data: categoryItems[index]
                                                      ["title"],
                                                  size: 13,
                                                  fwight: FontWeight.w600,
                                                  align: TextAlign.center,
                                                  textColor: Color(0xfffb56a2),
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
                      minimumSize: Size(120, 120),
                      maximumSize: Size(120, 120),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: showCategory
                      ? Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Image.asset(
                              categoryItems[selectedCategory]["icon"],
                              scale: 10,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Extext(
                              data: categoryItems[selectedCategory]["title"],
                              size: 14,
                              fwight: FontWeight.w600,
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
                              fwight: FontWeight.w600,
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
                          padding: EdgeInsets.symmetric(horizontal: 30,vertical: 8),
                          side: BorderSide(
                            color: Color(0xfffb56a2),
                          ),
                        ),
                        child: Extext(
                            data: "Cancel", size: 23, fwight: FontWeight.w600)),
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 40,vertical: 8),
                          backgroundColor: Color(0xfffb56a2),
                          foregroundColor: Colors.white,
                        ),
                        child: Extext(
                            data: "Save", size: 23, fwight: FontWeight.w600)),
                  ],
                )
              ],
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
