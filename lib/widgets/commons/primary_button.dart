import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/styles/colors.dart';
import 'package:singh_architecture/styles/fonts.dart';

// ignore: must_be_immutable
class PrimaryButton extends StatefulWidget {
  final void Function() onClick;
  final String title;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  EdgeInsets? margin;
  EdgeInsets? padding;
  double? width;

  PrimaryButton({
    required this.onClick,
    required this.title,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.margin,
    this.padding,
    this.width,
  }) {
    if (this.width == null) {
      this.width = 150;
    }
    if (this.padding == null) {
      this.padding = EdgeInsets.only(
        top: 16,
        bottom: 16,
      );
    }
  }

  @override
  State<StatefulWidget> createState() {
    return PrimaryButtonState();
  }
}

class PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        width: widget.width,
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
        ),
        margin: widget.margin,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: widget.borderColor ?? colorPrimary,
          ),
          color: widget.backgroundColor ?? colorPrimary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.icon == null
                ? Container()
                : Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                      right: 10,
                    ),
                    child: Icon(
                      widget.icon,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
            Container(
              padding: widget.padding,
              alignment: Alignment.center,
              child: Text(
                widget.title,
                style: TextStyle(
                  fontSize: p,
                  fontWeight: fontWeightBold,
                  color: widget.textColor ?? Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
