
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatefulWidget {
  ValueChanged<String> onDatechanged;
  CustomDatePicker({required this.onDatechanged});
  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}
class _CustomDatePickerState extends State<CustomDatePicker> {

  DateTime selectedDate = DateTime.now(); // Default to current date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // show current date initially
      firstDate: DateTime(2000), // earliest date
      lastDate: DateTime(2100),  // latest date
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        widget.onDatechanged(DateFormat("dd/MM/yyyy").format(selectedDate));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    widget.onDatechanged(
        DateFormat("dd/MM/yyyy").format(selectedDate)

    );
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
        padding: const EdgeInsets.all(0),
        child: GestureDetector(

          onTap: () => _selectDate(context),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Date',
                style: TextStyle(color: Colors.grey.shade600),
              ),

              Row(

                children: [
                  Text(
                    DateFormat('dd/MM/yyyy').format(selectedDate),
                    style: TextStyle(color: Colors.black),
                  ),
                  Icon(Icons.arrow_drop_down, color: Colors.grey),
                ],
              ),

            ],
          ),
        ),
    );
  }
}
