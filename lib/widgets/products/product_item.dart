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
  final Function(String id)? onFavorite;
  final double? height;
  final double? width;

  ProductItem({
    required this.product,
    required this.onClick,
    this.onFavorite,
    this.height,
    this.width,
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
        color: Colors.white,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                left: 8,
                right: 8,
                bottom: 8,
              ),
              height: widget.width,
              width: widget.width,
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
              width: widget.width,
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
              width: widget.width,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (widget.onFavorite == null) {
                        widget.onClick(widget.product.Id);
                      } else {
                        widget.onFavorite?.call(widget.product.Id);
                      }
                    },
                    child: Container(
                      child: Icon(
                        Icons.favorite_outline,
                        color: Colors.redAccent,
                        size: p,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 2,
                          bottom: 2,
                          left: 6,
                          right: 6,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: colorSecondary,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          "฿ ${widget.product.Price.toString()}",
                          style: TextStyle(
                            height: 1,
                            color: colorSecondary,
                            fontSize: s,
                            fontWeight: fontWeightBold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
