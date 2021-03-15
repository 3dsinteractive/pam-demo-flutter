import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/models/product_model.dart';
import 'package:singh_architecture/styles/colors.dart';
import 'package:singh_architecture/styles/fonts.dart';
import 'package:singh_architecture/widgets/common/cached_image.dart';

class ProductItem extends StatefulWidget {
  final ProductModel product;
  final Function(String id) onClick;

  ProductItem({
    required this.product,
    required this.onClick,
  });

  @override
  State<StatefulWidget> createState() {
    return ProductItemState();
  }
}

class ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onClick(widget.product.Id);
      },
      child: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                left: 8,
                right: 8,
                bottom: 8,
              ),
              height: 125,
              width: 125,
              child: CachedImage(
                fit: BoxFit.scaleDown,
                image: widget.product.ThumbnailURL,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                bottom: 8,
              ),
              height: 45,
              width: 125,
              child: Text(
                widget.product.Title,
                style: TextStyle(
                  fontSize: h6,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              width: 125,
              child: Text(
                widget.product.Price,
                style: TextStyle(
                  color: colorSecondary,
                  fontSize: p,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
