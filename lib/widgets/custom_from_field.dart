 import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  CustomFormField({required this.maxLines , required this.controller});
  int maxLines;
  TextEditingController controller; 
  @override
  Widget build(BuildContext context) {
  return TextFormField(
            controller: controller,
            maxLines: maxLines,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20)
              )
            ),
          );
  }
   
 } 