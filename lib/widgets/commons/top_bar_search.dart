import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/styles/colors.dart';
import 'package:singh_architecture/styles/fonts.dart';

class TopBarSearch extends StatefulWidget {
  final Function(String q) onSearch;
  final Widget? prefixWidget;
  final Widget? postfixWidget;

  TopBarSearch({
    required this.onSearch,
    this.prefixWidget,
    this.postfixWidget,
  });

  @override
  State<StatefulWidget> createState() {
    return TopBarSearchState();
  }
}

class TopBarSearchState extends State<TopBarSearch> {
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
            Expanded(
              flex: 5,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      child: Icon(
                        Icons.search,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: TextField(
                          onChanged: widget.onSearch,
                          style: TextStyle(
                            fontSize: h6,
                          ),
                          decoration:
                          InputDecoration.collapsed(hintText: "ค้นหาสินค้า ..."),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                child: widget.postfixWidget ?? Container(),
              ),
            ),
          ],
        )
    );
  }
}
