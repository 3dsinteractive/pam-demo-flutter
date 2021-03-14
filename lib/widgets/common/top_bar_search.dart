import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/styles/colors.dart';
import 'package:singh_architecture/styles/fonts.dart';

class TopBarSearch extends StatefulWidget {
  final Function(String q) onSearch;

  TopBarSearch({
    required this.onSearch,
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
      height: 85,
      padding: EdgeInsets.only(
        left: 32,
        right: 32,
      ),
      decoration: BoxDecoration(
        color: colorPrimary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
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
    );
  }
}
