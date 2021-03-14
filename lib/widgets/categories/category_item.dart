import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/styles/fonts.dart';

class CategoryItem extends StatefulWidget {
  final dynamic category;

  CategoryItem({
    required this.category,
  });

  @override
  State<StatefulWidget> createState() {
    return CategoryItemState();
  }
}

class CategoryItemState extends State<CategoryItem> {
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
              color: Colors.white,
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.scaleDown,
                  image: CachedNetworkImageProvider(
                    widget.category.ImageURL,
                  )
              ),
            ),
          ),
          Container(
            child: Text(
              widget.category.Title,
              style: TextStyle(fontSize: s3),
              textAlign: TextAlign.center,
              overflow: TextOverflow.clip,
            ),
          ),
        ],
      ),
    );
  }
}
