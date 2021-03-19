import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/styles/colors.dart';
import 'package:singh_architecture/styles/fonts.dart';

class CurveButton extends StatefulWidget {
  final void Function() onClick;
  final String title;
  final Color? backgroundColor;
  final Color? textColor;

  CurveButton({
    required this.onClick,
    required this.title,
    this.backgroundColor,
    this.textColor,
  });

  @override
  State<StatefulWidget> createState() {
    return CurveButtonState();
  }
}

class CurveButtonState extends State<CurveButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: widget.backgroundColor ?? colorPrimary,
        ),
        child: Text(
          widget.title,
          style: TextStyle(
            height: 1,
            fontSize: p,
            color: widget.textColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
