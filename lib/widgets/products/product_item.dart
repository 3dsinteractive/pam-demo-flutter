import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/models/product_model.dart';
import 'package:singh_architecture/styles/colors.dart';
import 'package:singh_architecture/styles/fonts.dart';

class ProductItem extends StatefulWidget {
  final ProductModel product;

  ProductItem({
    required this.product,
  });

  @override
  State<StatefulWidget> createState() {
    return ProductItemState();
  }
}

class ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              left: 8,
              right: 8,
            ),
            height: 125,
            width: 125,
            child: CachedNetworkImage(
                imageUrl: widget.product.ThumbnailURL,
                imageBuilder: (context, image) {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: image,
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
                progressIndicatorBuilder:
                    (context, url, downloadProgress) {
                  return Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                        value: downloadProgress.progress),
                  );
                },
                errorWidget: (context, url, error) =>
                    Icon(Icons.error)),
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
    );
  }
}
