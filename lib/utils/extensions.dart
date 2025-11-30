import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext{
  Size get devcieSize => MediaQuery.sizeOf(this);
  
}