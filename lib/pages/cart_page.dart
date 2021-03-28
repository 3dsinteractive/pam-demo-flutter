import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pam_flutter/pam_flutter.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/cores/constants.dart';
import 'package:singh_architecture/cores/context.dart';
import 'package:singh_architecture/models/cart_model.dart';
import 'package:singh_architecture/styles/colors.dart';
import 'package:singh_architecture/styles/fonts.dart';
import 'package:singh_architecture/widgets/carts/cart_item.dart';
import 'package:singh_architecture/widgets/commons/checkbox_circle.dart';
import 'package:singh_architecture/widgets/commons/loading_stack.dart';
import 'package:singh_architecture/widgets/commons/primary_button.dart';
import 'package:singh_architecture/widgets/commons/top_bar.dart';

class CartPage extends StatefulWidget {
  final IContext context;
  final IConfig config;
  final EdgeInsets? padding;
  final EdgeInsets? checkoutPadding;
  final void Function()? onBack;

  CartPage({
    required this.context,
    required this.config,
    this.padding,
    this.checkoutPadding,
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
      localeRepository: widget.context.localeRepository(),
      isLoadingSCs: [
        widget.context
            .repositories()
            .cartRepository()
            .isLoadingSC
      ],
      children: () =>
      [
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

                              return CartItem(
                                product: widget.context
                                    .repositories()
                                    .cartRepository()
                                    .data!
                                    .Products[index],
                                onSelected: (id) {
                                  if (widget.context
                                      .repositories()
                                      .cartRepository()
                                      .data!
                                      .Products[index]
                                      .isSelected) {
                                    widget.context
                                        .repositories()
                                        .cartRepository()
                                        .unSelectProduct(id);
                                  } else {
                                    widget.context
                                        .repositories()
                                        .cartRepository()
                                        .selectProduct(id);
                                  }
                                },
                                onIncrease: (id) {
                                  widget.context
                                      .repositories()
                                      .cartRepository()
                                      .mockAddToCart(id).then((_){
                                        Pam.trackAddToCart(id: id);
                                  });
                                },
                                onDecrease: (id) {
                                  widget.context
                                      .repositories()
                                      .cartRepository()
                                      .mockRemoveToCart(id).then((_){
                                    Pam.trackRemoveFromCart(id: id);
                                  });
                                },
                              );
                            },
                          ),
                        );
                      }),
                ),
              ),
              Container(
                padding: widget.checkoutPadding,
                color: Colors.white,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        right: 32,
                      ),
                      child: Row(
                        children: [
                          CheckboxCircle(
                            margin: EdgeInsets.only(
                              right: 14,
                            ),
                            value: widget.context
                                .repositories()
                                .cartRepository()
                                .isAllSelected,
                            onChecked: (value) {
                              if (widget.context
                                  .repositories()
                                  .cartRepository()
                                  .data
                                  ?.Products
                                  .length !=
                                  0) {
                                if (value) {
                                  widget.context
                                      .repositories()
                                      .cartRepository()
                                      .unSelectAllProduct();
                                } else {
                                  widget.context
                                      .repositories()
                                      .cartRepository()
                                      .selectAllProduct();
                                }
                              }
                            },
                          ),
                          Container(
                            child: Text(widget.context.localeRepository().getString("all")),
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
                                              widget.context.localeRepository().getString("total_price"),
                                              style: TextStyle(
                                                fontWeight: fontWeightBold,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              "฿ ${widget.context
                                                  .repositories()
                                                  .cartRepository()
                                                  .data
                                                  ?.Total
                                                  .toString() ?? "0"}",
                                              style: TextStyle(
                                                color: colorSecondary,
                                                fontWeight: fontWeightBold,
                                              ),
                                            ),
                                          ),
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
                                              widget.context.localeRepository().getString("delivery_price"),
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
                              child: PrimaryButton(
                                width: 125,
                                padding: EdgeInsets.only(
                                  top: 8,
                                  bottom: 8,
                                ),
                                backgroundColor: colorSecondary,
                                borderColor: colorSecondary,
                                onClick: () {
                                  Pam.trackPurchaseSuccess(
                                    ids: widget.context.repositories().cartRepository().data!.Products.map((e) => e.Id).toList(),
                                    titles: widget.context.repositories().cartRepository().data!.Products.map((e) => e.Title).toList(),
                                    categories: widget.context.repositories().cartRepository().data!.Products.map((e) => e.Title).toList(),
                                    totalPrice: widget.context.repositories().cartRepository().data!.Total,
                                  );

                                  widget.context
                                      .repositories()
                                      .cartRepository()
                                      .mockCheckout();
                                },
                                title: widget.context.localeRepository().getString("payment"),
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
