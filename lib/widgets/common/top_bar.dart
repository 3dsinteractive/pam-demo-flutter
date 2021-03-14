import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/styles/colors.dart';
import 'package:singh_architecture/styles/fonts.dart';

class TopBar extends StatefulWidget {
  final Widget prefixWidget;
  final Widget postfixWidget;

  TopBar({
    required this.prefixWidget,
    required this.postfixWidget,
  });

  @override
  State<StatefulWidget> createState() {
    return TopBarState();
  }
}

class TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 85,
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
          widget.prefixWidget,
          widget.postfixWidget,
        ],
      ),
    );
  }
}
