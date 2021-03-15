import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/cores/constants.dart';
import 'package:singh_architecture/cores/context.dart';
import 'package:singh_architecture/models/cart_model.dart';
import 'package:singh_architecture/styles/colors.dart';
import 'package:singh_architecture/styles/fonts.dart';
import 'package:singh_architecture/widgets/common/cached_image.dart';
import 'package:singh_architecture/widgets/common/checkbox_circle.dart';
import 'package:singh_architecture/widgets/common/curve_button.dart';
import 'package:singh_architecture/widgets/common/loading_stack.dart';
import 'package:singh_architecture/widgets/common/top_bar.dart';

class CartPage extends StatefulWidget {
  final IContext context;
  final IConfig config;
  final EdgeInsets? padding;
  final void Function()? onBack;

  CartPage({
    required this.context,
    required this.config,
    this.padding,
    this.onBack,
  });

  @override
  State<StatefulWidget> createState() {
    return CartPageState();
  }
}

class CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return LoadingStack(
      isLoadingSCs: [
        widget.context.repositories().cartRepository().isLoadingSC
      ],
      children: () => [
        Container(
          padding: widget.padding,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(4),
                  child: StreamBuilder<CartModel?>(
                      stream: widget.context
                          .repositories()
                          .cartRepository()
                          .dataSC
                          .stream,
                      builder: (context, snapshot) {
                        return Container(
                          padding: EdgeInsets.all(4),
                          margin: EdgeInsets.only(
                            top: 110,
                          ),
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: widget.context
                                        .repositories()
                                        .cartRepository()
                                        .data
                                        ?.Products
                                        .length ==
                                    0
                                ? 1
                                : widget.context
                                    .repositories()
                                    .cartRepository()
                                    .data
                                    ?.Products
                                    .length,
                            itemBuilder: (context, index) {
                              if (widget.context
                                      .repositories()
                                      .cartRepository()
                                      .data
                                      ?.Products
                                      .length ==
                                  0) {
                                return Container(
                                  height: 300,
                                  alignment: Alignment.center,
                                  child: Text("No Product In Cart"),
                                );
                              }

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
                                      child: CheckboxCircle(),
                                    ),
                                    Container(
                                      color: Colors.white,
                                      height: 100,
                                      width: 100,
                                      child: CachedImage(
                                        image: widget.context
                                                .repositories()
                                                .cartRepository()
                                                .data
                                                ?.Products[index]
                                                .ThumbnailURL ??
                                            "",
                                        fit: BoxFit.scaleDown,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  widget.context
                                                          .repositories()
                                                          .cartRepository()
                                                          .data
                                                          ?.Products[index]
                                                          .Title ??
                                                      "",
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            widget.context
                                                                .repositories()
                                                                .cartRepository()
                                                                .mockRemoveToCart(widget
                                                                        .context
                                                                        .repositories()
                                                                        .cartRepository()
                                                                        .data
                                                                        ?.Products[
                                                                            index]
                                                                        .Id ??
                                                                    "");
                                                          },
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    2),
                                                            decoration:
                                                                BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color:
                                                                          colorGrayLight,
                                                                    )),
                                                            child: Icon(
                                                              Icons.remove,
                                                              color:
                                                                  colorGrayLight,
                                                              size: p,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                            left: 14,
                                                            right: 14,
                                                          ),
                                                          child: Text(
                                                            (widget.context
                                                                        .repositories()
                                                                        .cartRepository()
                                                                        .data
                                                                        ?.Products[
                                                                            index]
                                                                        .Quantity ??
                                                                    1)
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontSize: p,
                                                              fontWeight:
                                                                  fontWeightBold,
                                                            ),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            widget.context
                                                                .repositories()
                                                                .cartRepository()
                                                                .mockAddToCart(widget
                                                                        .context
                                                                        .repositories()
                                                                        .cartRepository()
                                                                        .data
                                                                        ?.Products[
                                                                            index]
                                                                        .Id ??
                                                                    "");
                                                          },
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    2),
                                                            decoration:
                                                                BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color:
                                                                          colorPrimary,
                                                                    )),
                                                            child: Icon(
                                                              Icons.add,
                                                              size: p,
                                                              color:
                                                                  colorPrimary,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Text(
                                                        ((widget.context
                                                                        .repositories()
                                                                        .cartRepository()
                                                                        .data
                                                                        ?.Products[
                                                                            index]
                                                                        .Quantity ??
                                                                    1) *
                                                                (widget.context
                                                                        .repositories()
                                                                        .cartRepository()
                                                                        .data
                                                                        ?.Products[
                                                                            index]
                                                                        .Price ??
                                                                    0))
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: p,
                                                          fontWeight:
                                                              fontWeightBold,
                                                          color: colorSecondary,
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
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      }),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 16,
                  bottom: 16,
                  left: 24,
                  right: 24,
                ),
                color: Colors.white,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        right: 48,
                      ),
                      child: Row(
                        children: [
                          CheckboxCircle(
                            margin: EdgeInsets.only(
                              right: 14,
                            ),
                          ),
                          Container(
                            child: Text("ทั้งหมด"),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                              right: 4,
                                            ),
                                            child: Text(
                                              "ยอดรวม :",
                                              style: TextStyle(
                                                fontWeight: fontWeightBold,
                                              ),
                                            ),
                                          ),
                                          StreamBuilder<bool>(
                                              stream: widget.context
                                                  .repositories()
                                                  .cartRepository()
                                                  .isLoadingSC
                                                  .stream,
                                              builder: (context, snapshot) {
                                                return Container(
                                                  child: Text(
                                                    widget.context
                                                            .repositories()
                                                            .cartRepository()
                                                            .data
                                                            ?.Total
                                                            .toString() ??
                                                        "",
                                                    style: TextStyle(
                                                      color: colorSecondary,
                                                      fontWeight:
                                                          fontWeightBold,
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                              right: 4,
                                            ),
                                            child: Text(
                                              "ค่าจัดส่ง :",
                                              style: TextStyle(
                                                fontWeight: fontWeightBold,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              "฿ 40",
                                              style: TextStyle(
                                                color: colorSecondary,
                                                fontWeight: fontWeightBold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              child: CurveButton(
                                backgroundColor: colorSecondary,
                                onClick: () {
                                  widget.context.repositories().cartRepository().mockCheckout();
                                },
                                title: "ชำระเงิน",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        TopBar(
          prefixWidget: GestureDetector(
            onTap: () {
              if (widget.onBack == null) {
                Navigator.of(context).pop();
              } else {
                widget.onBack?.call();
              }
            },
            child: Container(
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ),
          title: widget.context.localeRepository().getString(Locales.cart),
        ),
      ],
    );
  }
}
