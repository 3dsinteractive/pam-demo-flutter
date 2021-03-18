import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/styles/colors.dart';
import 'package:singh_architecture/styles/fonts.dart';

class TopBar extends StatefulWidget {
  final String? title;
  final Widget? prefixWidget;
  final Widget? postfixWidget;

  TopBar({
    this.title,
    this.prefixWidget,
    this.postfixWidget,
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
      height: 85 + MediaQuery.of(context).padding.top,
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
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: widget.prefixWidget ?? Container(),
            ),
          ),
          widget.title != null
              ? Expanded(
                  flex: 5,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      widget.title!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: h6,
                      ),
                    ),
                  ),
                )
              : Expanded(
                  flex: 5,
                  child: Container(),
                ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: widget.postfixWidget ?? Container(),
            ),
          ),
        ],
      ),
    );
  }
}
