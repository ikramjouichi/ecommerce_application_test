
import 'package:ecommerce_application_test/consts/colors.dart';
import 'package:flutter/material.dart';
import 'normal_text.dart';

Widget ourButton({title,color=blueColor , onPress}){
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: color,
      padding: const EdgeInsets.all(12),
      //maximumSize:Size.fromWidth(30),
    ),
    onPressed:onPress,
     child: normalText(
      text:title,
      size: 16.0,
      ),
     );
}