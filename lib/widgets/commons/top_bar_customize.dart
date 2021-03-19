import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/styles/colors.dart';
import 'package:singh_architecture/styles/fonts.dart';

class TopBarCustomize extends StatefulWidget {
  final double height;
  final Widget? prefixWidget;
  final Widget? centerWidget;
  final Widget? postfixWidget;

  TopBarCustomize({
    required this.height,
    this.prefixWidget,
    this.centerWidget,
    this.postfixWidget,
  });

  @override
  State<StatefulWidget> createState() {
    return TopBarCustomizeState();
  }
}

class TopBarCustomizeState extends State<TopBarCustomize> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: widget.height + MediaQuery.of(context).padding.top,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      decoration: BoxDecoration(
        color: colorPrimary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.prefixWidget == null ? Container() : widget.prefixWidget!,
          widget.centerWidget == null ? Container() : widget.centerWidget!,
          widget.postfixWidget == null ? Container() : widget.postfixWidget!,
        ],
      ),
    );
  }
}
