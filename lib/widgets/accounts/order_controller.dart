import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/styles/colors.dart';
import 'package:singh_architecture/styles/fonts.dart';

class OrderController extends StatefulWidget {
  final EdgeInsets? margin;

  OrderController({
    this.margin,
  });

  @override
  State<StatefulWidget> createState() {
    return OrderControllerState();
  }
}

class OrderControllerState extends State<OrderController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Text(
                      "รายการสั่งซื้อของฉัน",
                      style: TextStyle(
                        fontSize: h6,
                        fontWeight: fontWeightBold,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    "ดูเพิ่มเติม >",
                    style: TextStyle(
                      fontSize: s2,
                      color: colorGray,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: 14,
              right: 14,
            ),
            child: Divider(
              height: 0,
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: 16,
              bottom: 32,
              left: 12,
              right: 12,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            bottom: 6,
                          ),
                          child: Icon(
                            Icons.credit_card,
                            size: h1,
                          ),
                        ),
                        Container(
                          child: Text(
                            "ที่ต้องชำระ",
                            style: TextStyle(
                              fontSize: s2,
                              fontWeight: fontWeightBold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            bottom: 6,
                          ),
                          child: Icon(
                            Icons.delivery_dining,
                            size: h1,
                          ),
                        ),
                        Container(
                          child: Text(
                            "ที่ต้องจัดส่ง",
                            style: TextStyle(
                              fontSize: s2,
                              fontWeight: fontWeightBold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            bottom: 6,
                          ),
                          child: Icon(
                            Icons.card_giftcard,
                            size: h1,
                          ),
                        ),
                        Container(
                          child: Text(
                            "ที่ต้องรีวิว",
                            style: TextStyle(
                              fontSize: s2,
                              fontWeight: fontWeightBold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            bottom: 6,
                          ),
                          child: Icon(
                            Icons.rate_review_outlined,
                            size: h1,
                          ),
                        ),
                        Container(
                          child: Text(
                            "ที่ต้องรีวิว",
                            style: TextStyle(
                              fontSize: s2,
                              fontWeight: fontWeightBold,
                            ),
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
    );
  }
}
