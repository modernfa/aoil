import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class TextFieldWidget extends StatelessWidget {
  final String labelText;
  final icon;
  final bool obscureText;
  final bool en;
  final suffixIcon;
  final Color? fillColor;
  FormFieldValidator<String> validator;
  FormFieldValidator<String> onSaved;
  TextFieldWidget({required this.labelText,@required this.icon,this.obscureText=false,required this.en,this.suffixIcon, required this.fillColor, required this.validator, required this.onSaved});
  @override
  Widget build(BuildContext context) {
    return Container(
      child:  TextFormField(
        validator: validator,
        onSaved: onSaved,
        enabled: en,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly , LengthLimitingTextInputFormatter(11)],
        // textAlign: TextAlign.right,
        // maxLength: 11,
        style: new TextStyle(
          fontSize: 14,
          color: Colors.green,
        ),
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: new TextStyle(
            color: Colors.green,
          ),
          filled: true,
          fillColor: fillColor,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.green,
            ),
          ),
          prefixIcon: Icon(icon,size: 16,color: Colors.green,),
          suffixIcon: Icon(suffixIcon,size: 16,color: Colors.green,),
        ),
      ),
    );
  }
}