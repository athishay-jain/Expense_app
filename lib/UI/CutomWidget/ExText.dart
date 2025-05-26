import 'package:flutter/material.dart';

class Extext extends StatelessWidget{
  String data;
  double size;
  FontWeight fwight;
  TextAlign? align;
  Color? textColor;
  TextDecoration? underline;
  Extext({required this.data,required this.size , required this.fwight , this.align,this.textColor,this.underline});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(data ,textAlign: align, style: TextStyle(decorationColor: Color(0xfffb56a2), decoration: underline , color: textColor, fontSize: size,fontWeight:fwight,fontFamily: "Poppins"),);
  }
}