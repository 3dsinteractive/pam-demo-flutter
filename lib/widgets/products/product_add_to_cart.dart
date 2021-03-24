import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/models/product_model.dart';
import 'package:singh_architecture/repositories/cart_repository.dart';
import 'package:singh_architecture/styles/colors.dart';
import 'package:singh_architecture/styles/fonts.dart';
import 'package:singh_architecture/widgets/commons/cached_image.dart';
import 'package:singh_architecture/widgets/commons/curve_button.dart';

class ProductAddToCart extends StatefulWidget {
  final ProductModel? product;
  final CartRepository cartRepository;
  final void Function(String id, int quantity) onAddToCart;
  final void Function() dismiss;

  ProductAddToCart({
    required this.product,
    required this.cartRepository,
    required this.onAddToCart,
    required this.dismiss,
  });

  @override
  State<StatefulWidget> createState() {
    return ProductAddToCartState();
  }
}

class ProductAddToCartState extends State<ProductAddToCart> {
  late int quantity;
  late int mockColorSelected;
  late int mockSizeSelected;

  late List<String> colors;
  late List<String> sizes;

  @override
  void initState() {
    super.initState();

    this.quantity = 1;
    this.mockColorSelected = 0;
    this.mockSizeSelected = 0;

    colors = [
      "ดำ",
      "ขาว",
      "เทา",
      "แดง",
      "ฟ้า",
      "ส้ม",
    ];
    sizes = [
      "64GB",
      "128GB",
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (widget.product == null) {
      return Container();
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(
        bottom: 32,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
                color: colorGrayLight, blurRadius: 6, offset: Offset(0, -0.1))
          ]),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedImage(
                      image: widget.product!.ThumbnailURL,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 100,
                    padding: EdgeInsets.only(
                      top: 8,
                      bottom: 8,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            left: 24,
                          ),
                          child: Text(
                            widget.product!.Title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: h6,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.only(
                              left: 24,
                            ),
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
                              "฿ ${widget.product!.Price.toString()}",
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
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      widget.dismiss();
                    },
                    child: Icon(Icons.close),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 0,
          ),
          Container(
            margin: EdgeInsets.all(24),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    bottom: 8,
                  ),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "สี",
                    style: TextStyle(
                      fontSize: p,
                    ),
                  ),
                ),
                Container(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Wrap(
                      children: List.generate(this.colors.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            this.mockColorSelected = index;
                            widget.cartRepository.forceValueNotify();
                          },
                          child: Container(
                            width:
                                ((MediaQuery.of(context).size.width - 48) / 3) -
                                    8,
                            padding: EdgeInsets.only(
                              top: 6,
                              bottom: 6,
                            ),
                            margin: EdgeInsets.only(
                              bottom: 8,
                              left: 4,
                              right: 4,
                            ),
                            decoration: BoxDecoration(
                              color: this.mockColorSelected == index
                                  ? colorPrimaryLighter
                                  : colorGrayLighter,
                              border: Border.all(
                                color: this.mockColorSelected == index
                                    ? colorPrimaryLight
                                    : colorGrayLight,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              this.colors[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: this.mockColorSelected == index
                                    ? colorPrimary
                                    : Colors.black,
                                fontSize: s,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 0,
          ),
          Container(
            margin: EdgeInsets.all(24),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    bottom: 8,
                  ),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "ขนาด",
                    style: TextStyle(
                      fontSize: p,
                    ),
                  ),
                ),
                Container(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Wrap(
                      children: List.generate(this.sizes.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            this.mockSizeSelected = index;
                            widget.cartRepository.forceValueNotify();
                          },
                          child: Container(
                            width:
                                ((MediaQuery.of(context).size.width - 48) / 3) -
                                    8,
                            padding: EdgeInsets.only(
                              top: 6,
                              bottom: 6,
                            ),
                            margin: EdgeInsets.only(
                              bottom: 8,
                              left: 4,
                              right: 4,
                            ),
                            decoration: BoxDecoration(
                              color: this.mockSizeSelected == index
                                  ? colorPrimaryLighter
                                  : colorGrayLighter,
                              border: Border.all(
                                color: this.mockSizeSelected == index
                                    ? colorPrimaryLight
                                    : colorGrayLight,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              this.sizes[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: this.mockSizeSelected == index
                                    ? colorPrimary
                                    : Colors.black,
                                fontSize: s,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 0,
          ),
          Container(
            margin: EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    "จำนวน",
                    style: TextStyle(
                      fontSize: p,
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (this.quantity > 1) {
                            this.quantity--;
                            widget.cartRepository.forceValueNotify();
                          }
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
                          quantity.toString(),
                          style: TextStyle(
                            fontSize: p,
                            fontWeight: fontWeightBold,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          this.quantity++;
                          widget.cartRepository.forceValueNotify();
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
              ],
            ),
          ),
          CurveButton(
            margin: EdgeInsets.only(
              top: 24,
              left: 24,
              right: 24,
            ),
            onClick: () {
              widget.onAddToCart(
                widget.product!.Id,
                this.quantity,
              );
            },
            icon: Icons.add_shopping_cart_outlined,
            title: "เพิ่มลงรถเข็น",
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}
