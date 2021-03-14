import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/styles/colors.dart';
import 'package:singh_architecture/styles/fonts.dart';

class CategoryItemLoading extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CategoryItemLoadingState();
  }
}

class CategoryItemLoadingState extends State<CategoryItemLoading> {
  @override
  Widget build(BuildContext context) {
    final double categoryWidth = ((MediaQuery.of(context).size.width) - 32) / 5;

    return Container(
      width: categoryWidth - 8,
      margin: EdgeInsets.all(4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: categoryWidth - 8,
            width: categoryWidth - 8,
            margin: EdgeInsets.only(
              bottom: 4,
            ),
            decoration: BoxDecoration(
              color: colorPrimaryLighter,
              shape: BoxShape.circle,
            ),
          ),
          Container(
            child: Text(
              "กำลังโหลด",
              style: TextStyle(
                fontSize: s3,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.clip,
            ),
          ),
        ],
      ),
    );
  }
}
