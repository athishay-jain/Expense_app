import 'package:flutter/material.dart';

/*
class ToggleSelector extends StatefulWidget{
  @override
  State<ToggleSelector> createState() => _ToggleSelectorState();
}

class _ToggleSelectorState extends State<ToggleSelector> {
  bool selector = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Container(
          height: 35,
          width: 140,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: Colors.grey.shade200),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: (){
                selector = true;
                setState(() {

                });

              },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: selector?Colors.white : Colors.black,
                    backgroundColor: selector?Colors.red : Colors.grey.shade200,
                    elevation: 0,
                    //maximumSize: Size(70, 20),
                    padding: EdgeInsets.symmetric(horizontal: 1,vertical: 1)
                  ),
                  child: Text("Expense",style: TextStyle(fontFamily: "poppies",fontWeight: FontWeight.bold),)),
              ElevatedButton(onPressed: (){
                selector = false;
                setState(() {
                });
              },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: selector?Colors.grey:Colors.white,
                      backgroundColor: selector?Colors.grey.shade200:Colors.green,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(horizontal: 1,vertical: 1)

                    //  maximumSize: Size(70, 20)
                  ),
                  child: Text("Income",style: TextStyle(fontFamily: "poppies",fontWeight: FontWeight.bold),),),
            ],
          ),
        )


        */
class ToggleSelector extends StatefulWidget{

  ToggleSelector({required this.selector});
   bool selector = true;
  @override
  State<ToggleSelector> createState() => _ToggleSelectorState();
}

class _ToggleSelectorState extends State<ToggleSelector> {
  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 35,
      width: 140,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: Colors.grey.shade200),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: (){
            widget.selector = true;
             setState(() {

              });

          },
              style: ElevatedButton.styleFrom(
                  foregroundColor: widget.selector?Colors.white : Colors.black,
                  backgroundColor: widget.selector?Colors.red : Colors.grey.shade200,
                  elevation: 0,
                  maximumSize: Size(65, 40),
                  padding: EdgeInsets.symmetric(horizontal: 1,vertical: 1)
              ),
              child: Text("Expense",style: TextStyle(fontFamily: "poppies",fontWeight: FontWeight.bold),)),
          ElevatedButton(onPressed: (){
            widget.selector = false;
             setState(() {
              });
          },
            style: ElevatedButton.styleFrom(
                foregroundColor: widget.selector?Colors.grey:Colors.white,
                backgroundColor: widget.selector?Colors.grey.shade200:Colors.green,
                elevation: 0,
                padding: EdgeInsets.symmetric(horizontal: 1,vertical: 1),

                maximumSize: Size(65, 40)
            ),
            child: Text("Income",style: TextStyle(fontFamily: "poppies",fontWeight: FontWeight.bold),),),
        ],
      ),

    );
  }
}