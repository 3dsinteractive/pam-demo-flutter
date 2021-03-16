import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/models/cart_model.dart';
import 'package:singh_architecture/styles/colors.dart';
import 'package:singh_architecture/styles/fonts.dart';
import 'package:singh_architecture/widgets/common/cached_image.dart';
import 'package:singh_architecture/widgets/common/checkbox_circle.dart';

class CartItem extends StatefulWidget {
  final CartProductModel product;
  final void Function(String id) onSelected;
  final void Function(String id) onIncrease;
  final void Function(String id) onDecrease;

  CartItem({
    required this.product,
    required this.onSelected,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  State<StatefulWidget> createState() {
    return CartItemState();
  }
}

class CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 8,
      ),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(
              right: 16,
            ),
            child: CheckboxCircle(
              value: widget.product.isSelected,
              onChecked: (value) {
                widget.onSelected(widget.product.Id);
              },
            ),
          ),
          Container(
            color: Colors.white,
            height: 100,
            width: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedImage(
                image: widget.product.ThumbnailURL,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                left: 18,
                top: 8,
                bottom: 8,
              ),
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.product.Title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: h6,
                          fontWeight: fontWeightBold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  widget.onDecrease(widget.product.Id);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: colorGrayLight,
                                      )),
                                  child: Icon(
                                    Icons.remove,
                                    color: colorGrayLight,
                                    size: p,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  left: 14,
                                  right: 14,
                                ),
                                child: Text(
                                  widget.product.Quantity.toString(),
                                  style: TextStyle(
                                    fontSize: p,
                                    fontWeight: fontWeightBold,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  widget.onIncrease(widget.product.Id);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: colorPrimary,
                                      )),
                                  child: Icon(
                                    Icons.add,
                                    size: p,
                                    color: colorPrimary,
                                  ),
                                ),
                              ),
                            ],
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
                                  "฿ ${widget.product.Total.toString()}",
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
                          // child: Container(
                          //   alignment: Alignment.centerRight,
                          //   child: Text(
                          //     (widget.product.Quantity * widget.product.Price)
                          //         .toString(),
                          //     style: TextStyle(
                          //       fontSize: p,
                          //       fontWeight: fontWeightBold,
                          //       color: colorSecondary,
                          //     ),
                          //   ),
                          // ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
