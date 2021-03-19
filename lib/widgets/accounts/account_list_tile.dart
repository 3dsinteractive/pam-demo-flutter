import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/styles/colors.dart';
import 'package:singh_architecture/styles/fonts.dart';

class AccountListTile extends StatefulWidget {
  final String title;
  final Function onClick;
  final String? hintText;
  final IconData? icon;
  final EdgeInsets? margin;

  AccountListTile({
    required this.title,
    required this.onClick,
    this.hintText,
    this.icon,
    this.margin,
  });

  @override
  State<StatefulWidget> createState() {
    return AccountListTileState();
  }
}

class AccountListTileState extends State<AccountListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          widget.icon == null ? Container() : Container(
            margin: EdgeInsets.only(
              right: 12,
            ),
            child: Icon(widget.icon),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.title,
                style: TextStyle(
                  height: 1,
                  fontSize: s2,
                  fontWeight: fontWeightBold,
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 8,),
            child: Text(
              widget.hintText ?? "",
              style: TextStyle(
                color: colorGray,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Icon(
              Icons.arrow_forward_ios,
              color: colorGray,
              size: s,
            ),
          ),
        ],
      ),
    );
  }
}
