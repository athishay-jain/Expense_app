import 'package:expance_app/UI/CutomWidget/ExText.dart';
import 'package:flutter/material.dart';

import '../../CutomWidget/customSelecot.dart';

class AddExpense extends StatefulWidget{
  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  bool selector = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
appBar: AppBar(
 title: Extext(data: "Add Expense", size: 20, fwight: FontWeight.bold),
),
      body: ListView(
        shrinkWrap: true,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IntrinsicWidth(child: ToggleSelector(selector: selector,)),
            ],
          ),
          TextFormField(
            
          )
        ],
      ),
    );
  }
}