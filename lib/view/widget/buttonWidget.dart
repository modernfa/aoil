import 'package:flutter/material.dart';


class ButtonWidget extends StatelessWidget {
  final String title;
  final bool hasBorder;
  ButtonWidget({required this.title,required this.hasBorder});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: new BoxDecoration(
          color: hasBorder?Colors.green:Colors.red,
          borderRadius: BorderRadius.circular(10),
          border: hasBorder?Border.all(color: Colors.green):Border.fromBorderSide(BorderSide.none)
      ),
      child: Container(
        alignment: Alignment.center,
        child: new Text(title,style: new TextStyle(color: hasBorder?Colors.white:Colors.white),),
      ),
    );
  }
}