import 'package:flutter/material.dart';

class TextSpanModel{
  final String text;
  final GestureTapCallback onTap;
  final Color color;

  TextSpanModel({@required this.text,this.onTap,this.color});
}