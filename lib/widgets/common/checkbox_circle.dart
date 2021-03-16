import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/styles/colors.dart';

class CheckboxCircle extends StatefulWidget {
  final bool value;
  final void Function(bool value) onChecked;
  final EdgeInsets? margin;

  CheckboxCircle({
    required this.value,
    required this.onChecked,
    this.margin,
  });

  @override
  State<StatefulWidget> createState() {
    return CheckboxCircleState();
  }
}

class CheckboxCircleState extends State<CheckboxCircle> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChecked(widget.value);
      },
      child: Container(
        margin: widget.margin,
        padding: EdgeInsets.all(4),
        height: 25,
        width: 25,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: colorGrayLight),
          shape: BoxShape.circle,
        ),
        child: AnimatedContainer(
          duration: Duration(
            milliseconds: 100,
          ),
          decoration: BoxDecoration(
            color: widget.value ? colorSecondary : Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
